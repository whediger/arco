should = require 'should'

User =  require 'src/model/User'


describe 'user model', ->

  describe 'contructor', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as properties", ->
            (-> new User invalid).should.throw 'Invalid properties'

    describe 'success', ->

      it 'should accept first name and last name', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        u.first_name.should.equal 'fabrizio'
        u.last_name.should.equal 'moscon'

      it 'should have times', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        should.exist u.times

      it 'should have places', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        should.exist u.places

      it 'should have records', ->
        u = new User {first_name:'fabrizio', last_name: 'moscon'}
        should.exist u.records

# --------------------------------------------------

  describe 'id setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as id", ->
            u = userFactory 'validUser1'
            (-> u.id = invalid).should.throw "Invalid id: #{invalid}"

    describe 'success', ->

      it 'should accept a valid id', ->
        u = userFactory 'validUser1'
        u.id = '50b896ddc814556766000999'
        u.id.should.equal '50b896ddc814556766000999'

# --------------------------------------------------

  describe 'email setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as email", ->
            u = userFactory 'validUser1'
            (-> u.email = invalid).should.throw "Invalid email: #{invalid}"

    describe 'success', ->

      it 'should accept a valid email', ->
        u = userFactory 'validUser1'
        u.email = 'fabrizio@arco.com'
        u.email.should.equal 'fabrizio@arco.com'

# --------------------------------------------------

  describe 'first name setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as first name", ->
            u = userFactory 'validUser1'
            (-> u.first_name = invalid).should.throw "Invalid first name: #{invalid}"

    describe 'success', ->

      it 'should accept a valid first name', ->
        u = userFactory 'validUser1'
        u.first_name = 'fabrizio'
        u.first_name.should.equal 'fabrizio'

# --------------------------------------------------

  describe 'last name setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as last name", ->
            u = userFactory 'validUser1'
            (-> u.last_name = invalid).should.throw "Invalid last name: #{invalid}"

    describe 'success', ->

      it 'should accept a valid last name', ->
        u = userFactory 'validUser1'
        u.last_name = 'moscon'
        u.last_name.should.equal 'moscon'

# --------------------------------------------------

  describe 'passwrod setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as passwrod", ->
            u = userFactory 'validUser1'
            (-> u.password = invalid).should.throw "Invalid password: #{invalid}"

    describe 'success', ->

      it 'should accept a valid password', ->
        u = userFactory 'validUser1'
        u.password = '$2a$08$e7Stv.uikafq58WDe1J1YOenKgMdCWgEo/6EVCTxOJ8p9Sdyl5kzq'
        u.password.should.equal '$2a$08$e7Stv.uikafq58WDe1J1YOenKgMdCWgEo/6EVCTxOJ8p9Sdyl5kzq'

# --------------------------------------------------

  describe 'birthdate setter/getter', ->

    describe 'failures', ->

      call() for call in allNotDatesTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as birthdate", ->
            u = userFactory 'validUser1'
            (-> u.birthdate = invalid).should.throw "Invalid birthdate: #{invalid}"

    describe 'success', ->

      it 'should accept a valid birthdate', ->
        u = userFactory 'validUser1'
        u.birthdate = new Date 1983, 5, 6
        u.birthdate.should.eql new Date 1983, 5, 6

# --------------------------------------------------

  describe 'gender setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as gender", ->
            u = userFactory 'validUser1'
            (-> u.gender = invalid).should.throw "Invalid gender: #{invalid}"

    describe 'success', ->

      it 'should accept M as gender', ->
        u = userFactory 'validUser1'
        u.gender = 'M'
        u.gender.should.equal 'M'

      it 'should accept F as gender', ->
        u = userFactory 'validUser1'
        u.gender = 'F'
        u.gender.should.equal 'F'
