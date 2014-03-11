
(function(doc, req) {
  var date, today, updates;
  date = new Date();
  today = (function() {
    var day, month, year;
    year = date.getFullYear();
    month = date.getMonth() + 1;
    day = date.getDate();
    if (("" + month).length === 1) month = '0' + month;
    if (("" + day).length === 1) day = '0' + day;
    return {
      year: year,
      month: month,
      day: day
    };
  })();
  if (!doc) {
    log('not doc');
    doc = {
      _id: req.uuid,
      created: today,
      owner: req.userCtx.name
    };
  } else {
    doc = doc;
  }
  updates = JSON.parse(req.body);
  doc.updater = req.userCtx.name;
  doc.updated = today;
  return [
    doc, {
      headers: {
        'Content-Type': 'application/json',
        'body': JSON.stringify(doc)
      }
    }
  ];
});
