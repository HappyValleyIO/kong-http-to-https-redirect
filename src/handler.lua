local MyPlugin = {
  -- handle redirect after ip-restriction, bot-detection, cors - but before jwt and other authentication plugins
  -- see https://docs.konghq.com/0.14.x/plugin-development/custom-logic/
  PRIORITY = 1500,
  VERSION = "1.0",
}

local kong = kong

function MyPlugin:access(conf)
  if ngx.var.https ~= "on" and ngx.var.http_x_forwarded_proto ~= "https" then
    local matches_exclude_pattern = conf.exclude_uri_pattern and string.find(ngx.var.request_uri, conf.exclude_uri_pattern)
    if not matches_exclude_pattern then
      return ngx.redirect("https://" .. ngx.var.host .. ngx.var.request_uri, ngx.HTTP_MOVED_PERMANENTLY)
    end
  end  
end

return MyPlugin
