# @cjsx React.DOM

React       = require('react')
TodoStore   = require('../stores/TodoStore.coffee')
Header      = require('./Header.coffee')
MainSection = require('./MainSection.coffee')
Footer      = require('./Footer.coffee')

getTodoState = ->
  {
    allTodos: TodoStore.getAll()
    areAllComplete: TodoStore.areAllComplete()
  }

TodoApp = React.createClass(
  getInitialState: -> getTodoState()

  _onChange: -> @setState(getTodoState())

  componentDidMount: -> TodoStore.addChangeListener(@_onChange)

  componentWillMount: -> TodoStore.removeChangeListener(@_onChange)

  render: ->
    <div className="row">
      <div className="small-6 large-centered columns">
        <Header />
        <MainSection
          allTodos={@state.allTodos}
          areAllComplete={@state.areAllComplete}
        />
        <Footer allTodos={@state.allTodos} />
      </div>
    </div>
)

module.exports = TodoApp
