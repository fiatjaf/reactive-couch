
(function(doc) {
  var day, month, year, _ref;
  if (doc.type === 'someKindOfThing') {
    _ref = doc.date, year = _ref.year, month = _ref.month, day = _ref.day;
    return emit([year, month, day, doc.type, null], doc.value);
  }
});
