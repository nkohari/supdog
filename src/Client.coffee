https = require 'https'
querystring = require 'querystring'
_ = require 'underscore'

class Client

  constructor: (@config) ->

  get:    (options, callback) -> @request 'get',    options, callback
  put:    (options, callback) -> @request 'put',    options, callback
  post:   (options, callback) -> @request 'post',   options, callback
  delete: (options, callback) -> @request 'delete', options, callback

  request: (method, options, callback) ->
    options = {path: options} if _.isString(options)

    options = _.extend options,
      host:   'app.datadoghq.com'
      port:   443
      method: method

    options.query = {} unless options.query?
    options.query.api_key = @config.apikey
    options.query.application_key = @config.appkey
    options.path += '?' + querystring.stringify(options.query)

    if options.data?
      data = new Buffer(JSON.stringify(options.data), utf8)
      options.headers = {} unless options.headers?
      options.headers['Content-Length'] = data.length

    req = https.request options, (res) ->
      res.setEncoding('utf8')
      buffer = ''
      res.on 'data', (chunk) -> buffer += chunk
      res.on 'end', () ->
        if res.statusCode isnt 200
          callback buffer
        else
          callback null, JSON.parse(buffer)

    req.on 'error', (err) ->
      callback(err)

    req.write(data) if data?
    req.end()

module.exports = Client
