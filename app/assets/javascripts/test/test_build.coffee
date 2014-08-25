require('chai').should()

(()->
  describe 'truth test', ->
    it 'should test for truth', ->
      (true).should.equal(true)
)()

((square)->
  describe 'square', ->
    it 'should square a number', ->
      square(3).should.equal(9)
)(require('../src/actions/square.coffee'))

((Hello)->
  describe 'Hello', ->
    it 'should allow property setting', ->
      # a silly test, but does demonstrate that it works
      hello = Hello(name: 'Dave')
      hello.props.name.should.equal('Dave')
)(require('../src/components/Hello.coffee'))
