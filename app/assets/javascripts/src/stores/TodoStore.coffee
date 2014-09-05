AppDispatcher  = require('../dispatchers/AppDispatcher.coffee')
{EventEmitter} = require('events')
TodoConstants  = require('../constants/TodoConstants.coffee')
merge          = require('react/lib/merge')
CHANGE_EVENT   = 'change'
_todos         = {}

create = (text) ->
  id = Date.now()
  _todos[id] = {id: id, complete: false, text: text}

update = (id, updates) ->
  _todos[id] = merge(_todos[id], updates)

updateAll = (updates) ->
  update(id, updates) for id of _todos

destroy = (id) ->
  delete _todos[id]

destroyCompleted = ->
  for id of _todos
    destroy(id) if _todos[id].complete


TodoStore = merge(EventEmitter.prototype,
  areAllComplete: ->
    for id of _todos
      return false unless _todos[id].complete
    true

  getAll: -> _todos

  emitChange: -> @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)
)


AppDispatcher.register((payload) ->
  action = payload.action
  text   = ''

  switch action.actionType
    when TodoConstants.TODO_CREATE
      text = action.text.trim()
      create(text) unless text is ''

    when TodoConstants.TODO_TOGGLE_COMPLETE_ALL
      if TodoStore.areAllComplete()
        updateAll({complete: false})
      else
        updateAll({complete: true})

    when TodoConstants.TODO_UNDO_COMPLETE
      update(action.id, {complete: false})

    when TodoConstants.TODO_COMPLETE
      update(action.id, {complete: true})

    when TodoConstants.TODO_UPDATE_TEXT
      text = action.text.trim()
      update(action.id, text: text) unless text is ''

    when TodoConstants.TODO_DESTROY
      destroy(action.id)

    when TodoConstants.TODO_DESTROY_COMPLETED
      destroyCompleted()

    else true

  TodoStore.emitChange()

  true
)

module.exports = TodoStore
