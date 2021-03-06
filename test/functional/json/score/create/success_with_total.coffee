#> Create new score with total - success
path: '/score'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
  'Cookie': config.system_users[0]
body:
  type: 'FITA 90+70+50+30'
  total: '1300'

#? Status: 201 created
response.statusCode.should.equal 201

#? Response.user should exist
should.exist json

#? score id
should.exist json.id

#? score type
should.exist json.type
json.type.should.equal 'FITA 90+70+50+30'

#? score user id
should.exist json.user_id

#? score times
should.exist json.times

#? score places
# should.exist json.places

#?score arrows
should.exist json.arrows

#? return correct total
json.total.should.equal 1300
