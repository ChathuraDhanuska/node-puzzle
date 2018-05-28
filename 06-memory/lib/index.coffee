fs = require 'fs'
readline = require 'readline'


exports.countryIpCounter = (countryCode, cb) ->
  return cb() unless countryCode

  counter = 0
  lineCount = 0

  stream = readline.createInterface
    input: fs.createReadStream "#{__dirname}/../data/geo.txt"
    terminal: false

  stream.on 'line', (line) ->
    lines = line.split '\t'
    
    if lines[3] == countryCode
      counter += lines[1] - lines[0]
      lineCount += 1

  stream.on 'close', ->
    cb null, counter
