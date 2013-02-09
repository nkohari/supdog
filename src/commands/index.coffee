fs = require 'fs'
path = require 'path'

for file in fs.readdirSync(__dirname)
  name = path.basename(file, '.coffee')
  exports[name] = require "./#{file}"
