# @cjsx React.DOM

React          = require('react')
ReactPropTypes = React.PropTypes
TodoActions    = require('../actions/TodoActions.coffee')
TodoItem       = require('./TodoItem.coffee')

MainSection = React.createClass(
  propTypes:
    allTodos: ReactPropTypes.object.isRequired
    areAllComplete: ReactPropTypes.bool.isRequired

  _onToggleCompleteAll: -> TodoActions.toggleCompleteAll()

  render: ->
    return null if Object.keys(@props.allTodos).length < 1

    allTodos = @props.allTodos
    todos = []

    for key of allTodos
      todos.push(<TodoItem key={key} todo={allTodos[key]} />)

    <section id="main">
      <input
        id="toggle-all"
        type="checkbox"
        onChange={@_onToggleCompleteAll}
        checked={@props.areAllComplete ? 'checked' : ''}
      />
      <label htmlFor="toggle-all">Mark all as completed</label>
      <ul id="todo-list">{todos}</ul>
    </section>
)

module.exports = MainSection
