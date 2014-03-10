
(function(head, req) {
  var day, month, year, _ref;
  _ref = require('lib/today'), year = _ref.year, month = _ref.month, day = _ref.day;
  return {
    code: 302,
    headers: {
      location: "operacoes?include_docs=true&startkey=[\"" + year + "\", \"" + month + "\", \"" + day + "\", {}]&endkey=[\"" + year + "\", \"" + month + "\", \"" + day + "\", null]&descending=true&reduce=false"
    }
  };
});
