{html} = require './elmish'
request = require 'browser-request'
R = require 'ramda'

randomUrl = (topic) -> 
  "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{topic}"

getRandomGif = (topic) ->
  fetch(randomUrl(topic))
    .then (response) ->
      response.json()
    .then ({data}) ->
      console.log "DONE"
      type: 'newGif'
      url: data?.image_url
    .catch (error) ->
      console.log "ERROR"
      type: 'errorGif'
      error: error

init = (topic="funny cats") -> 
  model: {topic, url: 'v2/loading.gif'}
  effects: [getRandomGif(topic)]

update = (action, model) ->
  switch action.type
    when 'newGif' then return {model: R.assoc('url', action.url, model)}
    when 'errorGif' then return {model: R.assoc('url', "v2/error.gif", model)}
    when 'anotherGif' then return {model: R.assoc('url', 'v2/loading.gif', model), effects: [getRandomGif(model.topic)]}
    else return {model}

view = (address, model) ->
  html.div {},
    html.h2 {}, model.topic
    html.img
      src: model.url
    html.button
      onClick: -> address {type: 'anotherGif'}
      'Gimme More!'

module.exports = {init, update, view}