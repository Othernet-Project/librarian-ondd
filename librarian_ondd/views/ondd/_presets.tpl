<%namespace name="forms" file="/ui/forms.tpl"/>

<% value = request.params.get('preset') %>

<p class="o-field">
    ## Translators, label for select list that allows user to pick a satellite to tune into
    ${forms.label(_('Satellite'), id='transponders')}
    <select name="preset" id="transponders" class="transponders">
        ## Translators, placeholder for satellite selection select list
        <option>${_('Select a satellite')}</option>
        % for pname, index, preset in form.PRESETS:
            <option value="${index}" ${ 'selected' if value == str(index) else ''}
                data-frequency="${preset['frequency']}"
                data-symbolrate="${preset['symbolrate']}"
                data-polarization="${preset['polarization']}"
                data-delivery="${preset['delivery']}"
                data-modulation="${preset['modulation']}"
                data-coverage="${preset['coverage']}">${pname}</option>
        % endfor
        ## Translators, label for option that allows user to set custom transponder parameters
        <option value="-1">${_('Custom...')}</option>
    </select>
    ${forms.field_help('')}
</p>
