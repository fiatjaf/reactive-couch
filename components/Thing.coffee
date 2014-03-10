deps = ['lib/superagent', 'lib/lodash', 'lib/react']
factory = (request, _, React, RadioField) ->
  {style, button, div, span, a, p, hr, dl, dt, dd, label, fieldset, legend, table, tr, th, td, h1, h2, h3, form, input, textarea} = React.DOM

  Thing = React.createClass
    getInitialState: ->
      # this component will have all his data passed to it at @props.thing
      # when it is rendered by a call to the displayThing show function at
      # server side, otherwise none, it will render itself empty, waiting
      # to populate itself with data after a client side call.
      thing: @props.thing or {}

    componentDidMount: ->
      # here we listen for the showThing signal, using the global event
      # emitter `ee`. the signal will be emitted anytime someone clicks
      # at some element of the list at the ListComponent.
      self = this
      ee.on 'showThing', (thingid) ->
        request.get("/_shows/displayThing/#{thingid}")
               .set('Accept', 'application/json')
               .end (res) ->
                 self.setState thing: res.body

        self.setState thing: thing
        History.to "/thing/#{thing._id}"

    render: ->
      thing = @state.thing
      if thing._id
        (div {},
          (h2 {}, thing.title)
          (dt {}, 'Property'),
          (dd {}, thing.property),
          (dt {}, 'Kind'),
          (dd {}, thing.kind),
          (dt {}, 'Value'),
          (dd {}, thing.value),
        )
      else
        (div {style: 'display: none'})

if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = factory.apply @, deps.map require
