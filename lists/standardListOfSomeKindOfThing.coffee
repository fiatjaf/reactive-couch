(head, req) ->

  fetch = ->
    results = []
    while row = getRow()
      doc = row.doc
    results

  provides 'html', ->
    tpl = require 'app/template'
    data =
      listOfSomeKindOfThing: fetch()
    tpl @app.app, data

  provides 'json', ->
    toJSON fetch()
