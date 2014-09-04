# @cjsx React.DOM

React          = require('react')
ReactPropTypes = React.PropTypes
TodoActions    = require('../actions/TodoActions.coffee')

Footer = React.createClass(
  propTypes:
    allTodos: ReactPropTypes.object.isRequired

  _onClearCompletedClick: -> TodoActions.destroyCompleted()

  render: ->
    allTodos  = @props.allTodos
    total     = Object.keys(allTodos).length
    completed = 0

    return null if total is 0

    for key of allTodos
      completed++ if allTodos[key].complete

    itemsLeft = total - completed
    itemsLeftPhrase = if itemsLeft is 1 then 'item' else 'items'
    itemsLeftPhrase = "#{itemsLeftPhrase} left"

    if completed > 0
      clearCompletedButton =
        <button id="clear-completed" onClick={@_onClearCompletedClick}>
          Clear completed ({completed})
        </button>
    else
      clearCompletedButton = null

    <footer id="footer">
      <span id="todo-count">
        {itemsLeft} {itemsLeftPhrase}
      </span>
      {clearCompletedButton}
    </footer>
)

module.exports = Footer
