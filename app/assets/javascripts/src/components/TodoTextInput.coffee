# @cjsx React.DOM

React          = require('react')
ReactPropTypes = React.PropTypes
ENTER_KEY_CODE = 13

TodoTextInput = React.createClass(
  propTypes:
    className:   ReactPropTypes.string
    id:          ReactPropTypes.string
    placeholder: ReactPropTypes.string
    onSave:      ReactPropTypes.func.isRequired
    value:       ReactPropTypes.string

  getInitialState: ->
    {
      value: (@props.value || '')
    }

  _save: ->
    @props.onSave(@state.value)
    @setState({value: ''})

  _onChange: (event) ->
    @setState({value: event.target.value})

  _onKeyDown: (event) ->
    @_save() if event.keyCode is ENTER_KEY_CODE

  render: ->
    <input
      className={@props.className}
      id={@props.id}
      placeholder={@props.placeholder}
      onBlur={@_save}
      onChange={@_onChange}
      onKeyDown={@_onKeyDown}
      value={@state.value}
      autoFocus={true}
    />
)

module.exports = TodoTextInput
