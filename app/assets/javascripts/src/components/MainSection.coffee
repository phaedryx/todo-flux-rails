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

    <div className="row" id="main">
      <div className="small-12 columns">
        <input
          id="toggle-all"
          type="checkbox"
          onChange={@_onToggleCompleteAll}
          checked={@props.areAllComplete ? 'checked' : ''}
        />
        <label htmlFor="toggle-all">Mark all as completed</label>
        <ul className="no-bullet" id="todo-list">{todos}</ul>
      </div>
    </div>
)

module.exports = MainSection
