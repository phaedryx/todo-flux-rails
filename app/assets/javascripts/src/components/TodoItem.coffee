# @cjsx React.DOM

React          = require('react')
cx             = require('react/lib/cx')
ReactPropTypes = React.PropTypes
TodoActions    = require('../actions/TodoActions.coffee')
TodoTextInput  = require('./TodoTextInput.coffee')

TodoItem = React.createClass(
  propTypes:
    todo: ReactPropTypes.object.isRequired

  getInitialState: ->
    {
      isEditing: false
    }

  _onToggleComplete: -> TodoActions.toggleComplete(@props.todo)

  _onDoubleClick: -> @setState({isEditing: true})

  _onSave: (text) ->
    TodoActions.updateText(@props.todo.id, text)
    @setState({isEditing: false})

  _onDestroyClick: -> TodoActions.destroy(@props.todo.id)

  render: ->
    todo = @props.todo

    if @state.isEditing
      input =
        <TodoTextInput
          className='edit'
          onSave={@_onSave}
          value={todo.text}
        />
    else
      input = null

    <li
      className={cx({'completed': todo.complete, 'editing': @state.isEditing})}
      key={todo.id}
    >
      <div className="view">
        <input
          className="toggle"
          type="checkbox"
          checked={todo.complete}
          onChange={@_onToggleComplete}
        />
        <label onDoubleClick={@_onDoubleClick}>
          {todo.text}
        </label>
      </div>
      {input}
    </li>
)

module.exports = TodoItem
