" Vim plug-in
" Author: 0x501D

function! Play_voice()
    let line = getline('.')
    if match(line, ' :voice=')
        let comment_path = substitute(line, '.* :voice="\(.*\)".*', '\1', '') 
        if len(comment_path) > 0
            call system("/usr/bin/mpv " . comment_path . " >/dev/null 2>&1")
        endif
    endif
endfunction

nnoremap <silent> <F7> :call Play_voice()<CR>
