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
            % if f['filename']:
                ${f['filename']} 
                % if f['complete']:
                    ## Translators, used in file list when download manager
                    ## sees a file that has already been downloaded once.
                    (${_('skipping')})
                % else:
                    (${f['percentage']}%)
                % endif
            % else:
                ## Translators, shown in downloads list when no file data is
                ## incoming.
                ${_('waiting for data...')}
            % endif
            </li>
        % endfor
    </ul>
% endif
