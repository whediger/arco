module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 404
    res.data.body.error = (error.message || error || 'not found')
    res.data.body.error_code = code if code?
    
    next()
