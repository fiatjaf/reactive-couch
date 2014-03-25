define ['promise', 'stores/all',
                   'stores/item'], (Promise,
                                    AllStore,
                                    ItemStore) ->
  class Dispatcher
    _all: new AllStore()
    _items: new ItemStore()

    constructor: ->
      @_all.start()

    clear: ->
      @_all.clear()

    searchItem: (str) ->
      return new Promise (resolve) =>
        @_items.search(str).then (ids) ->
          console.log ids
          resolve ids

    addItem: (name) ->
      return new Promise (resolve) =>
        @_items.add(name).then (res) ->
          console.log res
          resolve res

  return Dispatcher
