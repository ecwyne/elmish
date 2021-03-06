html = require('react').DOM

userItem = require('src/user-item')

spinner = require 'src/spinner.coffee'

# request a query for who's following this user.
effects = (state) ->
  {$github: ['following', {limit: 20}, userItem.fields()]}
  
view = ({selected, select, data}) ->
  if data.following.$pending
    spinner()
  else if data.following
    data.following.map (user) ->
      html.div
        key: user.id
        className: 'item' + (if user.login is selected then ' selected' else '')
        onClick: -> select(user.login)
        userItem.view(user)
  else if data.error
    html.div
      className: 'error'
      error.message    
  else
    console.warn("shouldn't be here")

module.exports = {effects, view}
