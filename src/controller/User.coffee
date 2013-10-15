http = require 'src/middleware/httpResponse'

accountService = new (require 'src/service/Account')

apiUserMapper = require 'src/mapper/api/user'

check = require 'check-types'


# ----------

index = (req, res, next) ->

  accountService.findAllUsers (err, users) ->
    return next( http.serverError(err, 1041) ) if err?

    res.data = users

    return next()
  return

# ----------

read = (req, res, next) ->

  accountService.findUserById req.params.id, (err, user) ->
    return next( http.serverError(err, 1003) ) if err?
    return next( http.notFound('user not found', 1002) ) unless user?

    try res.data = apiUserMapper.marshall user
    catch err then return next( http.serverError(err, 1012) )

    return next()
  return

# ----------

create = (req, res, next) ->

  return next( http.badRequest('Invalid user data', 1010) ) if check.isEmptyObject req.body

  try user = apiUserMapper.unmarshallForCreating req.body
  catch err then return next( http.badRequest(err, 1011) )

  accountService.createUser user, (err, user) ->
    return next( http.serverError(err, 1013) ) if err?

    res.status 201

    try res.data = apiUserMapper.marshall user
    catch err then return next( http.serverError(err, 1012) )

    return next()
  return


# ----------

edit = (req, res, next) ->

  if check.isEmptyObject req.body
    return next( http.badRequest('Invalid body', 1021) )

  accountService.findUserById req.params.id, (err, user) ->
    return next( http.serverError(err, 1003) ) if err?
    return next( http.notFound('user not found', 1022) ) unless user?

    try user = apiUserMapper.unmarshallForEditing req.body, user
    catch err then return next( http.badRequest(err, 1023) )

    accountService.updateUserById req.params.id, user, (err, user) ->
      return next( http.serverError(err, 1025) ) if err?

      try res.data = apiUserMapper.marshall user
      catch err then return next( http.serverError(err, 1024) )

      return next()
    return
  return

# ----------

remove = (req, res, next) ->

  accountService.removeUserById req.params.id, (err, user) ->
    return next( http.serverError(err, 1032) ) if err?
    return next( http.notFound('user not found', 1031) ) unless user?

    res.status 204

    return next()
  return


module.exports = {create, read, edit, remove, index}
