Template.postSubmit.events
  'submit form': ( e ) ->
    e.preventDefault()

    post =
      url     : $( e.target ).find( '[name=url]' ).val()
      title   : $( e.target ).find( '[name=title]' ).val()
      message : $( e.target ).find( '[name=message]' ).val()

    Meteor.call 'post', post, ( error, id ) ->
      if error then return alert error.reason

      # Meteor.Router.to 'postPage', id

    Meteor.Router.to 'postsList'

    # post._id = Posts.insert post
    # Meteor.Router.to 'postPage', post
