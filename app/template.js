var React, SomeFormOfDisplayOfSomeKindOfThing;

React = require('lib/react');

SomeFormOfDisplayOfSomeKindOfThing = require('components/SomeFormOfDisplayOfSomeKindOfThing');

module.exports = function(browsercode, data) {
  return "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Curitiba 942</title>\n    <link rel=\"stylesheet\" href=\"/default.css\" type=\"text/css\">\n  </head>\n  <body>\n\n    <div id=\"someKindOfThingList\">\n      " + (React.renderComponentToString(SomeFormOfDisplayOfSomeKindOfThing(data))) + "\n    </div>\n\n  </body>\n\n  <script src=\"//cdnjs.cloudflare.com/ajax/libs/curl/0.7.3/curl/curl.min.js\"></script>\n  <script>\n    window.data = " + (toJSON(data)) + "\n    " + browsercode + "\n  </script>\n\n</html>";
};
