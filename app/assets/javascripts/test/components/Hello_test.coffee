((Hello)->
  describe 'Hello', ->
    it 'should allow property setting', ->
      # a silly test, but does demonstrate that it works
      hello = Hello(name: 'Dave')
      hello.props.name.should.equal('Dave')
)(require('../src/components/Hello.coffee'))
