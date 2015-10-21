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

  # Cache selectors for all options
  options = {}
  index = () ->
    transponders = onddForm.find '#transponders'
    (transponders.find 'option').each () ->
      opt = $ this
      options[opt.val()] = opt
      return

  onTransponderSwitch = () ->
    customSettingsFields = onddForm.find '.settings-fields'
    transponders = onddForm.find '#transponders'
    val = transponders.val()
    opt = options[val]
    help = transponders.next '.o-field-help-message'

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
  onddForm.on 'change', '#transponders', onTransponderSwitch
  ($ window).on 'transponder-updated', () ->
    index()
    onTransponderSwitch()

  # Reset inital state
  index()
  onTransponderSwitch()

  return

) this, this.jQuery, this.templates
