Table = require 'cli-table'

createTable = () ->
  return new Table
    head: ['Title', 'ID', 'Description']
    style:
      'compact': true
      'padding-left': 1
      'padding-right': 1

module.exports = (client, args) ->
  unless args.length == 1
    console.log 'You must specify a dash id'
    process.exit(1)
  id = args.shift()
  client.get "/api/v1/dash/#{id}", (err, result) ->
    console.log require('util').inspect result.dash.graphs, false
