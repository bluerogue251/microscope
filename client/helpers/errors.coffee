this.Errors = new Meteor.Collection(null)

this.throwError = (message) ->
  Errors.insert({message: message, seen: false})

this.clearErrors = () ->
  Errors.remove({seen: true})

