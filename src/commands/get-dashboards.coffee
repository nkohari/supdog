Table = require 'cli-table'

createTable = () ->
  return new Table
    head: ['Title', 'ID', 'Description']
    style:
      'compact': true
      'padding-left': 1
      'padding-right': 1

module.exports = (client, args) ->
  client.get '/api/v1/dash', (err, result) ->
    table = createTable()
    for dash in result.dashes
      table.push [dash.title, dash.id, dash.description]
    console.log table.toString()
