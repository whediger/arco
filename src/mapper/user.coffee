check = require 'check-types'
Hash = require 'node-hash'

objectIdMapper = require 'src/mapper/type/objectId'

UserModel = require 'src/model/User'


module.exports = {

  marshall: (user) ->

    throw new Error 'Invalid user' unless user instanceof UserModel

    data = {}

    data._id = objectIdMapper.marshall user.id if user.id?
    data.first_name = user.first_name if user.first_name?
    data.last_name = user.last_name if user.last_name?
    data.email = user.email if user.email?
    data.password = user.password if user.password?
    data.gender = user.gender if user.gender?
    data.birthdate = user.birthdate if user.birthdate?

    data.times = user.times.marshall()

    return data


  unmarshall: (data) ->

    throw new Error 'Invalid data' unless check.isObject data

    user = new UserModel first_name: data.first_name, last_name: data.last_name

    user.id = objectIdMapper.unmarshall data._id if data._id?
    user.email = data.email if data.email?
    user.first_name = data.first_name if data.first_name?
    user.last_name = data.last_name if data.last_name?
    user.password = data.password if data.password?
    user.birthdate = data.birthdate if data.birthdate?
    user.gender = data.gender if data.gender?

    if data.times?
      user.times = Hash.unmarshall data.times, Hash.comparator.Date

    return user

}
