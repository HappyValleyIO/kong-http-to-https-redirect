local BasePlugin = require "kong.plugins.base_plugin"
local responses = require "kong.tools.responses"

local HttpFilterHandler = BasePlugin:extend()

function HttpFilterHandler:new()
  HttpFilterHandler.super.new(self, "kong-http-to-https-redirect")
end

function HttpFilterHandler:access(conf)
  HttpFilterHandler.super.access(self)

  if ngx.var.https ~= "on" then
    local matches_exclude_pattern = conf.exclude_uri_pattern and string.find(ngx.var.request_uri, conf.exclude_uri_pattern)
    if not matches_exclude_pattern then
      return ngx.redirect("https://" .. ngx.var.host .. ngx.var.request_uri, ngx.HTTP_MOVED_PERMANENTLY)
    end
  end  
end

return HttpFilterHandler
