deps = ['lib/react']
factory = (React) ->
  {input, label, div} = React.DOM

  RadioField = React.createClass
    displayName: 'RadioField'
    handleChange: (e) ->
      if e.target.checked
        @props.onChange @props.name, e.target.value

    render: ->
      (div {},
        (label {},
          (input
            type: 'radio'
            key: @props.name
            name: @props.name
            value: option.value
            onChange: @handleChange
            checked: @props.value == option.value
          ),
          option.label,
        ) for option in @props.fields
      )

  return RadioField

if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = factory.apply @, deps.map require
