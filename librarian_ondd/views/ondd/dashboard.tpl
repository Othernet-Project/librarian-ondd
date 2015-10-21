<%namespace name="settings_form" file="_settings_form.tpl"/>
<%namespace name="signal" file="_signal.tpl"/>
<%namespace name="file_list" file="_file_list.tpl"/>
<%namespace name="presets" file="_presets.tpl"/>
<%namespace name="forms" file="/ui/forms.tpl"/>

<div class="ondd-status">
    <div id="signal-status" class="signal-status" data-url="${i18n_url('ondd:status')}">
        ${signal.body()}
    </div>
    <div id="ondd-file-list" class="ondd-file-list" data-url="${i18n_url('ondd:files')}">
        ${file_list.body()}
    </div>
</div>

<div class="ondd-settings">
    <form action="${i18n_url('ondd:settings')}" class="ondd-form" id="ondd-form" method="POST">
        ${settings_form.body()}
    </form>
</div>

<script type="text/template" id="onddSettingsError">
    <% 
    errors = [_('Tuner settings could not be set due to application error.')] 
    %>
    ${forms.form_errors(errors)}
</script>

