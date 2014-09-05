invariant = require('./invariant.js')

_lastID = 1
_prefix = 'ID_'

Dispatcher = ->
  @$Dispatcher_callbacks = {}
  @$Dispatcher_isPending = {}
  @$Dispatcher_isHandled = {}
  @$Dispatcher_isDispatching  = false
  @$Dispatcher_pendingPayload = null

Dispatcher::register = (callback) ->
  id = _prefix + _lastID++
  @$Dispatcher_callbacks[id] = callback
  id

Dispatcher::unregister = (id) ->
  message = 'Dispatcher.unregister(...): `%s` does not map to a registered callback.'
  invariant(@$Dispatcher_callbacks[id], message, id)
  delete @$Dispacther_callbacks[id]

Dispatcher::waitFor = (ids) ->
  invoked_message = 'Dispatcher.waitFor(...): Must be invoked while dispatching.'
  invariant(@$Dispatcher_isDispatching, invoked_message)

  for id in ids
    dependency_message = 'Dispatcher.waitFor(...): Circular dependency detected while waiting for `%s`.'
    registered_message = 'Dispatcher.waitFor(...): `%s` does not map to a registered callback.'

    if @$Dispatcher_isPending[id]
      invariant(@$Dispatcher_isHandled[id], dependency_message, id)
      continue

    invariant(@$Dispatcher_callbacks[id], registered_message, id)

    @$Dispatcher_invokeCallback(id)

Dispatcher::dispatch = (payload) ->
  dispatch_message = 'Dispatch.dispatch(...): Cannot dispatch in the middle of a dispatch.'
  invariant(!@$Dispatcher_isDispatching, dispatch_message)

  @$Dispatcher_startDispatching(payload)
  try
    for id of @$Dispatcher_callbacks
      if @$Dispatcher_isPending[id]
        continue
      @$Dispatcher_invokeCallback(id)
  finally
    @$Dispatcher_stopDispatching()

Dispatcher::isDispatching = ->
  @$Dispatcher_isDispatching

Dispatcher::$Dispatcher_invokeCallback = (id) ->
  @$Dispatcher_isPending[id] = true
  @$Dispatcher_callbacks[id](@$Dispatcher_pendingPayload)
  @$Dispatcher_isHandled[id] = true

Dispatcher::$Dispatcher_startDispatching = (payload) ->
  for id of @$Dispatcher_callbacks
    @$Dispatcher_isPending[id] = false
    @$Dispatcher_isHandled[id] = false

  @$Dispatcher_pendingPayload = payload
  @$Dispatcher_isDispatching  = true

Dispatcher::$Dispatcher_stopDispatching = ->
    @$Dispatcher_pendingPayload = null
    @$Dispatcher_isDispatching  = false


module.exports = Dispatcher
