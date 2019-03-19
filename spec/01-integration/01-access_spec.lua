local helpers = require "spec.helpers"

for _, strategy in helpers.each_strategy() do
  describe("Plugin: http-to-https-redirect (access) [#" .. strategy .. "]", function()
    local proxy_client
    local proxy_ssl_client

    lazy_setup(function()
      local bp = helpers.get_db_utils(strategy)

      local route = bp.routes:insert {
        hosts = { "example.com" },
      }

      bp.plugins:insert {
        name  = "kong-http-to-https-redirect",
        route = { id = route.id },
      }

      assert(helpers.start_kong({
        database = strategy,
        plugins = "bundled, kong-http-to-https-redirect",
        custom_plugins = "kong-http-to-https-redirect",
        nginx_conf = "spec/fixtures/custom_nginx.template",
      }))

      proxy_client = helpers.proxy_client()
      proxy_ssl_client = helpers.proxy_ssl_client()
    end)

    it("is redirected when scheme is http", function()
      local res = assert(proxy_client:send {
        method  = "GET",
        path    = "/",
        headers = {
          ["Host"] = "example.com",
        }
      })

      assert.res_status(301, res)
    end)

    it("is not redirected when scheme is https", function()
      local res = assert(proxy_ssl_client:send {
        method  = "GET",
        path    = "/",
        headers = {
          ["Host"]              = "example.com",
          ["X-Forwarded-Proto"] = "https"
        }
      })

      assert.res_status(200, res)
    end)

    lazy_teardown(function()
      if proxy_client and proxy_ssl_client then
        proxy_client:close()
        proxy_ssl_client:close()
      end

      helpers.stop_kong()
    end)
  end)
end
