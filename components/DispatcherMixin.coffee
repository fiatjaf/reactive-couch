define ['react'], (React) ->
  propTypes:
    dispatcher: React.PropTypes.object

  childContextTypes:
    dispatcher: React.PropTypes.object

  getChildContext: ->
    dispatcher: @props.dispatcher

  contextTypes:
    dispatcher: React.PropTypes.object

  componentWillMount: ->
    if @props.dispatcher
      @dispatcher = @props.dispatcher
    else
      @dispatcher = @context.dispatcher
