Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: -> [Meteor.subscribe('posts'), Meteor.subscribe('notifications')]

Router.map ->
  this.route 'postsList',  { path: '/' }
  this.route 'postPage',
    {
      path: '/posts/:_id'
      waitOn: ->
        Meteor.subscribe('comments', this.params._id)
      data: -> Posts.findOne(this.params._id)
    }
  this.route 'postEdit',   { path: '/posts/:_id/edit', data: -> Posts.findOne(this.params._id) }
  this.route 'postSubmit', { path: '/submit' }

requireLogin = (pause) ->
  if !Meteor.user()
    if Meteor.loggingIn()
      this.render this.loadingTemplate
    else
      this.render 'accessDenied'
    pause()

Router.onBeforeAction('loading')
Router.onBeforeAction(requireLogin, {only: 'postSubmit'})
Router.onBeforeAction -> clearErrors()
