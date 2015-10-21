((window, $, templates) ->

  FIELDS = [
    'frequency',
    'symbolrate',
    'polarization',
    'delivery',
    'modulation'
  ]

  onddForm = $ '#ondd-form'

  # Ignore if required elements are not present
  if not onddForm.length
    return

  # Cache selectors for the form field
  fields = {}
  for f in FIELDS
    fields[f] = $ "##{f}"

  # Grab refrences to relevant elements
  customSettingsFields = onddForm.find '.settings-fields'
  transponders = onddForm.find '#transponders'
  help = transponders.next '.o-field-help-message'

  # Hide custom settings
  customSettingsFields.hide()

  # Cache selectors for all options
  options = {}
  (transponders.find 'option').each () ->
    opt = $ this
    options[opt.val()] = opt
    return

  onTransponderSwitch = () ->
    val = transponders.val()
    opt = options[val]

    help.text ''

    if not val
      customSettingsFields.hide()
    else if val is '-1'
      customSettingsFields.show()
    else
      customSettingsFields.hide()
      data = opt.data()
      coverage = data.coverage
      help.text coverage
      for f in FIELDS
        fields[f].val data[f]

    return

  # Handle transponder select list change event
  transponders.on 'change', onTransponderSwitch

  # Reset inital state
  onTransponderSwitch()

  return

) this, this.jQuery, this.templates
