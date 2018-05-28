through2 = require 'through2'


module.exports = ->
  words = 0
  lines = 1

  transform = (chunk, encoding, cb) ->
    tokens = []

    curser = 0
    found_quote = false

    for i in [0..(chunk.length-1)]
      if(chunk[i] == '"')
        if found_quote='true' then 'false' else 'true'

      if(chunk[i] == ' ')
        if(found_quote == false)
          tokens.push chunk.substr curser, i
          curser = i
    
    tokens.push chunk.substr curser, chunk.length-1

    words = tokens.length

    return cb()

  flush = (cb) ->
    this.push {words, lines}
    this.push null
    return cb()

  return through2.obj transform, flush
