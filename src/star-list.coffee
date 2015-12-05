html = require('react').DOM
R = require('ramda')

effect = (id) ->
  {$github: ['stars', {id}, ['full_name', 'html_url', 'stargazers_count']]}

view = (data) ->
  if R.path(['stars', '$pending'], data)
    html.div
      className: 'loading'
      'Loading...'
  else if data.stars
    data.stars.map (repo) ->
      html.div
        key: repo.id
        className: 'repo-item'
        html.a
          className: 'name'
          href: repo.html_url
          repo.full_name
        html.div
          className: 'stars'
          repo.stargazers_count
  else if data.error
    html.div
      className: 'error'
      data.error.message
  else
    console.warn("shouldn't be here")
    

module.exports = {effect, view}