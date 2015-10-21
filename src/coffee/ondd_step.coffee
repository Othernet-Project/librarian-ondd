((window, $, templates) ->

  onddForm = $ '#ondd-form'

  # Ignore if not the currect step
  if not onddForm.length
    return

  transponders = onddForm.find '#transponders'
  testButton = onddForm.find '#tuner-test'

  onTransponderSwitch = () ->
    val = transponders.val()
    testButton.attr 'disabled', val is '0'

  transponders.on 'change', onTransponderSwitch
  onTransponderSwitch()

) this, this.jQuery, this.templates
