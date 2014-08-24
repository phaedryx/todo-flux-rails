# @cjsx React.DOM
React = require('react')

Hello = React.createClass(
  render: ->
    <h3>Hello {@props.name}!</h3>
)

module.exports = Hello
