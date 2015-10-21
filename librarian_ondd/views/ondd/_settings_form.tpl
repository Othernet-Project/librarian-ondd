<%namespace name="settings_fields" file="_settings_fields.tpl"/>

${h.form('post', action=i18n_url('ondd:settings'), _class='settings-form', _id='settings-form')}
    <input type="hidden" name="backto" value="${request.original_path}">
    ${settings_fields.body()}
    <p>
    ## Translators, button label that confirms tuner settings
    <button type="submit" class="primary">${_('Tune in')}</button>
    </p>
</form>
