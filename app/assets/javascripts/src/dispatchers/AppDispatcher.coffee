Dispatcher     = require('./Dispatcher.coffee')
copyProperties = require('react/lib/copyProperties')

AppDispatcher = copyProperties(new Dispatcher(),
  handleViewAction: (action) ->
    @dispatch(
      source: 'VIEW_ACTION'
      action: action
    )
)

module.exports = AppDispatcher
