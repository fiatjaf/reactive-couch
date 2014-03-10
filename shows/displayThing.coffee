(doc, req) ->
  provides 'html', ->
    data =
      thing: doc

    tpl = require 'app/template'
    tpl @app.app, data
