
(function(doc, req) {
  return provides('html', function() {
    var data, tpl;
    data = {
      thing: doc
    };
    tpl = require('app/template');
    return tpl(this.app.app, data);
  });
});
