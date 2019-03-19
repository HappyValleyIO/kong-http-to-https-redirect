package = "kong-http-to-https-redirect"
version = "0.13.2-0"
source = {
    url = "git://github.com/HappyValleyIO/kong-http-to-https-redirect",
    branch = "master"
}
description = {
    summary = "A Kong plugin for redirecting HTTP traffic to HTTPS.",
    detailed = [[
      Redirects traffic from HTTP to HTTPS (currently only offers 301 redirect).
    ]],
    homepage = "https://github.com/HappyValleyIO/kong-http-to-https-redirect",
    license = "MIT"
}
dependencies = {
}
build = {
    type = "builtin",
    modules = {
    ["kong.plugins.kong-http-to-https-redirect.handler"] = "src/handler.lua",
    ["kong.plugins.kong-http-to-https-redirect.schema"] = "src/schema.lua",
    }
}
