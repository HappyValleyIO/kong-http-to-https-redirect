# kong-http-to-https-redirect
301 redirect from http to https

## Installation
To use, allow kong to access route on both https and http. Only allowing http results in kong responding before ever hitting the access method in the lifecycle of the request.

Then run:
```
luarocks install *.rockspec
```

Then in the kong.yml add 

```
custom_plugins:
  - kong-http-to-https-redirect
```

Run kong reload or start and add the plugin as normal.

### Docker installation
We recommend using [kong-docker by dojot](https://github.com/dojot/kong). Copy this repo into the plugins directory of that project and build a custom docker image.

## Configuration

* `exclude_uri_pattern`: 
    When this value is empty, then a redirect is done in every HTTP (not HTTPS) request.
    When it is set, then the redirect to https is only done when the called URI doesn't match to the Lua pattern in `exclude_uri_pattern`.

Raise an issue if there's anything more you'd like to see.

## Misc

Thanks to the creator of https://github.com/jicong/kong-aliyun-http-filter off of which this plugin was created.
