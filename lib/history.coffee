deps = []
factory = () ->
  window.addEventListener 'popstate', (e) ->
    if e.state and e.state.pushed
      location.reload()

  return {
    to: (address) ->
      if window.history and window.history.pushState
        window.history.pushState {pushed: true}, null, address
      else
        location.href = address
  }
  
if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = {}
