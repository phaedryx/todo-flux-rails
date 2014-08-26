{Promise} = require('es6-promise')
merge     = require('react/lib/merge')

_callbacks = []
_promises = []

Dispatcher = ->

Dispatcher.prototype = merge(Dispatcher.prototype,
  register: (callback) ->
    _callbacks.push(callback)
    _callbacks.length - 1


  dispatch: (payload) ->
    resolves = []
    rejects = []
    _promises = _callbacks.map((_, i) ->
      new Promise((resolve, reject) ->
        resolves[i] = resolve
        rejects[i] = reject
      )
    )
    _callbacks.forEach((callback, i) ->
      Promise.resolve(callback(payload)).then(->
        resolves[i](payload)
      , ->
        rejects[i](new Error('Dispatcher callback unsuccessful'))
      )
    )
    _promises = [];
)

module.exports = Dispatcher
