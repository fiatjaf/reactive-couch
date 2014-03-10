deps = ['lib/react']
factory = (React) ->
  {input, label, div} = React.DOM

  RangeField = React.createClass
    displayName: 'RangeField'
    handleChange: (e) ->
      @props.onChange e

    componentDidMount: ->
      elem = @getDOMNode()
      @props.reportInputChange target: elem

    render: ->
      (div {},
        (label {},
          "#{@props.label}: ",
          (input
            type: 'range',
            name: @props.name,
            min: '1',
            max: '100',
            value: @props.value || '50',
            onChange: @handleChange)
        )
      )

  return RangeField

if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = factory.apply @, deps.map require
