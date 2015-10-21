((window, $, templates) ->

  FIELDS = [
    'frequency',
    'symbolrate',
    'polarization',
    'delivery',
    'modulation'
  ]

  lnbSettings = $ '.lnb-settings'
  formFields = $ '.settings-fields'
  presets = templates.satPresets

  # Ignore if required elements are not present
  if not formFields.length
    return

  # Add presets container
  presetsContainer = $ '<div>'
  lnbSettings.after presetsContainer

  # Cache selectors for the form field
  fields = {}
  for f in FIELDS
    fields[f] = $ "##{f}"

  # Load the presets form and hide the main form
  presetsContainer.html presets
  formFields.hide()

  # Grab the elements in presets form
  transponders = presetsContainer.find '#transponders'

  # Cache selectors for all options
  options = {}
  transponders.find('option').each () ->
    opt = $ this
    options[opt.val()] = opt

  transponders.on 'change', () ->
    val = transponders.val()
    opt = options[val]

    if val is '0'
      return
    else if val is '-1'
      formFields.show()
    else
      formFields.hide()
      data = opt.data()
      for f in FIELDS
        fields[f].val data[f]


) this, this.jQuery, this.templates
