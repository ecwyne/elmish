html = require('react').DOM

require 'src/user-item.styl'

fields = () ->
  ['login', 'avatar_url']

view = (user) ->
  html.div
    className: 'user-item'
    html.img
      className: 'image'
      src: user.avatar_url
    html.span
      className: 'name'
      user.login

module.exports = {view, fields}