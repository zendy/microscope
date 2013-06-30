@.Posts = new Meteor.Collection 'posts'

# Posts.allow
#   insert: ( userId, doc ) ->
#     !!userId

Meteor.methods(
  post: ( postAttributes ) ->
    user = Meteor.user()
    postWithSameLink = Posts.findOne { url: postAttributes.url }

    # ensure the user is logged in
    if !user
      throw new Meteor.Error 401, "You need to log in to post new stories"

    # ensure the post has a title
    if !postAttributes.title
      throw new Meteor.Error 422, 'Please fill in a headline'

    # check that there are no previous posts with the same link
    if postAttributes.url && postWithSameLink
      throw new Meteor.Error 302, 'This link has already been posted', postWithSameLink._id

    # pick out the whitelisted keys
    post = _.extend(
      _.pick( postAttributes, 'url', 'title', 'message' )
      {
        userId: user._id
        author: user.username
        submitted: new Date().getTime()
      }
    )

    postId = Posts.insert post

    postId
)
