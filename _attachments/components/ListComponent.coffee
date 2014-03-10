deps = ['lib/superagent', 'lib/lodash', 'lib/react', 'lib/history', 'lib/today']
factory = (request, _, React, History, today, require) ->
  {style, button, div, span, a, p, hr, dl, dt, dd, label, fieldset, legend, table, tr, th, td, h1, h2, h3, form, input, textarea} = React.DOM

  # this is a top level component for directly rendering HTML elements.
  # it will receive the data from the list function and reload this same
  # data dynamically from the browser, causing it to be re-rendered whenever
  # something changes.

  # you make it work the way you want. the key, however, is the
  # @props.listOfSomeKindOfThing property, which was defined at the
  # standardListOfSomeKindOfThing list function and contains the collection
  # of objects that will be used by this component.

  ListComponent = React.createClass
    displayName: 'ListResults'
    getInitialState: ->
      list: @props.listOfSomeKindOfThing

    reload: (viewparams, e) ->
      # this function will reload the data for this component calling the
      # same standardListOfSomeKindOfThing list function that rendered it
      # on the server.

      # if this reload function was meant to be called with arguments --
      # which would then be passed to the view function and the list
      # function, this session extracts then from an object and build
      # a query string, which then is passed to the History module, a simple
      # wrapper around browsers window.history.
      query = _.pairs(viewparams).map((pair) -> pair.join '=').join '&'
      History.to "/someKindOfThing?#{query}"

      # this is the proper reload. a simple ajax call (here we make use of
      # the superagent module [http://visionmedia.github.io/superagent/],
      # but any kind of ajax/couchdb clients can be used.
      self = this
      request.get("/_list/standardListOfSomeKindOfThing/someKindOfThing")
             .set('Accept', 'application/json')
             .query(viewparams)
             .end (res) ->
               self.setState list: res.body

      e.preventDefault()

    render: ->
      (div {},
        (button onClick: @reload.bind @, {startkey: [2014, null]}
        , 'newer results'),
        (button onClick: @reload.bind @, {endkey: [2013, {}]}
        , 'older results'),
        (Results results: @state.list)
      )

  Results = React.createClass
    displayName: 'Results'
    render: ->
      (table {},
        (h1 {}, 'items of some kind')
        (ul {},
          (li {ref: item._id}
          , item.value
          ) for item in @props.results
        )
      )

  return ListComponent

if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = factory.apply @, deps.map require
