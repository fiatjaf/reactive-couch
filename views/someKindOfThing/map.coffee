(doc) ->
  if doc.type == 'someKindOfThing'
    {year, month, day} = doc.date
    emit [year, month, day, doc.type, null], doc.value
