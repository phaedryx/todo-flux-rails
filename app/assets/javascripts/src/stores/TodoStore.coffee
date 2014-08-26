AppDispatcher   = require('../dispatcher/AppDispatcher')
{EventEmitter}  = require('events')
TodoConstants   = require('../constants/TodoConstants')
merge           = require('react/lib/merge')

CHANGE_EVENT = 'change'

_todos = {}

create = (text) ->
  id = Date.now()
  _todos[id] = {
    id: id
    complete: false
    text: text
  }

destroy = (id) -> delete _todos[id]

TodoStore = merge(EventEmitter.prototype,
  getAll: -> _todos

  emitChange: -> @emit(CHANGE_EVENT)

  addChangeListener: (callback) -> @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) -> @removeListener(CHANGE_EVENT, callback)

  dispatcherIndex: AppDispatcher.register((payload) ->
    action = payload.action

    switch action.actionType
      when TodoConstants.TODO_CREATE
        text = action.text.trim()
        if (text isnt '')
          create(text)
          TodoStore.emitChange()
      when TodoConstants.TODO_DESTROY
        destroy(action.id)
        TodoStore.emitChange()

    true
  )
)

module.exports = TodoStore
