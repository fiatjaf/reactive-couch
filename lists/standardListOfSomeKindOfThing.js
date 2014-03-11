
(function(head, req) {
  var fetch;
  fetch = function() {
    var doc, results, row;
    results = [];
    while (row = getRow()) {
      doc = row.doc;
    }
    return results;
  };
  provides('html', function() {
    var data, tpl;
    tpl = require('app/template');
    data = {
      listOfSomeKindOfThing: fetch()
    };
    return tpl(this.app.app, data);
  });
  return provides('json', function() {
    return toJSON(fetch());
  });
});
