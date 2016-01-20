<%namespace name="widgets" file="/ui/widgets.tpl"/>

<%!
import math


def truncate(text, max_size=50, separator='...'):
    text_len = len(text)
    if text_len <= max_size:
        return text

    sep_len = len(separator)
    usable_chars_len = max_size - sep_len
    first_len = int(math.ceil(usable_chars_len / 2))
    second_len = int(math.floor(usable_chars_len /2))
    if usable_chars_len % 2 != 0:
        second_len += 1
    return text[0:first_len] + separator + text[(text_len - second_len):]
%>

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
                ${truncate(f['filename'])} 
                % if f['complete']:
                    (100%)
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
