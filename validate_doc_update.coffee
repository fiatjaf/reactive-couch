(doc, old, userCtx, secObj) ->

  # asserts value of `field` equals `value`
  verify = (field, value) ->
    if doc[field] != value
      throw forbidden: "you are passing wrong information"

  # asserts `field` exists
  exists = (field) ->
    if field not of doc
      throw forbidden: "must have `#{field}`"

  # asserts `field` wasn't subject of change
  unchanged = (field) ->
    if doc[field] != old[field]
      throw forbidden: "`#{field}` cannot change"

  # guarantees that `field` will only be modified by doc.owner
  owner = (field) ->
    if doc.owner != userCtx.name and doc[field] != old[field]
      throw unauthorized: "only the owner can change `#{field}`"

  # guarantees that `field` will only be modified by members of doc.organization 
  # (users that have doc.organization in its `roles`)
  organization = (field) ->
    if doc.organization not in userCtx.roles and doc.owner != userCtx.name
      if field == '*'
        throw unauthorized: """only members of the organization 
                            `#{doc.organization}` can update this doc"""

      if doc[field] != old[field]
        throw unauthorized: """only members of the organization 
                            `#{doc.organization}` can change `#{field}`"""

  if doc.type == 'anything'
    # check existence of fields
    exists 'owner'
    exists 'updater'
    exists 'created'
    # exists 'type'
    # exists 'someField'

    # verify if the updater is who it claims to be
    verify 'updater', userCtx.name

    if old
      # some fields cannot change
      unchanged 'owner'

      # only the owner can updated some fields
      owner 'organization'
      owner '_deleted'

      # only members of the organization can update the rest
      organization '*'

    else
      # verify if the owner is who it claims to be
      verify 'owner', userCtx.name
      verify 'organization', userCtx.roles[0]
