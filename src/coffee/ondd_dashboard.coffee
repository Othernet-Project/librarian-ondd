((window, $, templates) ->

  onddForm = $ '#ondd-form'
  url = onddForm.attr 'action'
  errorMessage = templates.onddSettingsError


  removeMessage = () ->
    (onddForm.find '.o-form-message').slideUp () ->
      ($ this).remove()


  submitData = (data) ->
    res = $.post url, data
    res.done (data) ->
      onddForm.html data
      ($ window).trigger 'transponder-updated'
      setTimeout removeMessage, 5000
    res.fail () ->
      onddForm.prepend errorMessage


  onddForm.on 'submit', (e) ->
    e.preventDefault()
    data = onddForm.serialize()
    submitData data


) this, this.jQuery, this.templates
