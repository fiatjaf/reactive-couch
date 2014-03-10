(doc, req) ->
  date = new Date()
  today = (->
    year = date.getFullYear()
    month = date.getMonth() + 1
    day = date.getDate()
    month = '0' + month if "#{month}".length == 1
    day = '0' + day if "#{day}".length == 1
    return
      year: year
      month: month
      day: day
  )()

  if not doc
    log 'not doc'
    doc =
      _id: req.uuid
      created: today
      owner: req.userCtx.name
      # add default fields here
      # doc.type = 'doc'
  else
    doc = doc
  
  # update the doc
  updates = JSON.parse req.body
  # doc.someProperty = updates.someProperty
  # doc.someOtherProperty = updates.someOtherProperty

  doc.updater = req.userCtx.name
  doc.updated = today

  return [doc, {headers: 'Content-Type': 'application/json', 'body': JSON.stringify doc}]
