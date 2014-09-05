# @cjsx React.DOM

React         = require('react')
TodoActions   = require('../actions/TodoActions.coffee')
TodoTextInput = require('./TodoTextInput.coffee')

Header = React.createClass(
  _onSave: (text) ->
    TodoActions.create(text) if text.trim()

  render: ->
    <div className="row" id="header">
      <div className="small-12 columns">
        <h2>Todo List</h2>
        <TodoTextInput
          id="new-todo"
          placeholder="What next?"
          className="large-12 columns"
          onSave={@_onSave}
        />
      </div>
    </div>
)

module.exports = Header
