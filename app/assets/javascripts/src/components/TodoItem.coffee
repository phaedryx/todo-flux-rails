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
      input =
        <div className="view">
          <input
            id={todo.id}
            className="toggle"
            type="checkbox"
            checked={todo.complete ? 'checked' : ''}
            onChange={@_onToggleComplete}
          />
          <label
            htmlFor={todo.id}
            onDoubleClick={@_onDoubleClick}
          >
            {todo.text}
          </label>
        </div>

    <li
      className={cx({'completed': todo.complete, 'editing': @state.isEditing})}
      key={todo.id}
    >
      {input}
    </li>
)

module.exports = TodoItem
