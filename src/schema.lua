-- see https://docs.konghq.com/gateway/3.4.x/plugin-development/configuration/
-- see https://github.com/Kong/kong-plugin/blob/master/kong/plugins/myplugin/schema.lua

local typedefs = require "kong.db.schema.typedefs"


return {
  name = "kong-http-to-https-redirect",
  fields = {
    {
      -- this plugin will only be applied to Services or Routes
      consumer = typedefs.no_consumer
    },
    {
      -- this plugin will only run within Nginx HTTP module
      protocols = typedefs.protocols_http
    },
    {
      config = {
        type = "record",
        fields = {
          {
            exclude_uri_pattern = {type = "string", required = false},
          },
        },
      },
    },
  },
}
