<input type="hidden" name="preset">

<%namespace name="forms" file="/ui/forms.tpl"/>

<div class="lnb-settings">
    ${forms.field(form.lnb)}
</div>

<div class="settings-fields">
    ${forms.field(form.frequency)}
    ${forms.field(form.symbolrate)}
    ${forms.field(form.delivery)}
    ${forms.field(form.modulation)}
    ${forms.field(form.polarization)}
    ## TODO: Add support for DiSEqC azimuth value
</div>
