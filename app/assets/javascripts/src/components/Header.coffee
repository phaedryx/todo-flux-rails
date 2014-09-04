# @cjsx React.DOM

React         = require('react')
TodoActions   = require('../actions/TodoActions.coffee')
TodoTextInput = require('./TodoTextInput.coffee')

Header = React.createClass(
  _onSave: (text) ->
    TodoActions.create(text) if text.trim()

  render: ->
    <header id="header">
      <h1>todos</h1>
      <TodoTextInput id="new-todo" placeholder="What next?" onSave={@_onSave} />
    </header>
)

module.exports = Header
