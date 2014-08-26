Dispatcher = require('./Dispatcher')
merge      = require('react/lib/merge')

AppDispatcher = merge(Dispatcher.prototype,
  handleViewAction: (action) ->
    @dispatch({source: 'VIEW_ACTION', action: action})
)

module.exports = AppDispatcher
