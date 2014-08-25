((square)->
  describe 'square', ->
    it 'should square a number', ->
      square(3).should.equal(9)
)(require('../src/actions/square.coffee'))
