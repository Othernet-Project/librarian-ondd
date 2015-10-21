<%namespace name="widgets" file="/ui/widgets.tpl"/>

% if not files:
    ## Translators, shown on dashboard when no files are currently being
    ## downloaded
    <p>${_('No files are being downloaded')}</p>
% else:
    <ul>
        % for f in files:
            <li>
            ${widgets.progress_mini(f['percentage'], icon='download')}
            ${f['filename']} 
            (${f['percentage']}%)
            </li>
        % endfor
    </ul>
% endif
