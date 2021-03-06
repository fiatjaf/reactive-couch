React = require 'lib/react'
ListComponent = require 'components/ListComponent'

module.exports = (browsercode, data) ->
  """
<!DOCTYPE html>
<html>
  <head>
    <title>Curitiba 942</title>
    <link rel="stylesheet" href="/default.css" type="text/css">
  </head>
  <body>

    <div id="someKindOfThingList">
      #{React.renderComponentToString ListComponent(data)}
    </div>

  </body>

  <script src="//cdnjs.cloudflare.com/ajax/libs/curl/0.7.3/curl/curl.min.js"></script>
  <script>
    window.data = #{toJSON data}
    #{browsercode}
  </script>

</html>
  """
