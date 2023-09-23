" Vim plug-in
" Author: 0x501D

function! s:on_out(msgs)
    echom a:msgs
endfunction

function! PlayVoice()
    let line = getline('.')
    if match(line, ' :voice=')
        let comment_path = substitute(line, '.* :voice="\(.*\)".*', '\1', '') 
        if len(comment_path) > 0
            let cmd = ["mpv", comment_path]
            let job = job_start(cmd, {
                        \ 'out_cb': {channel, msgs -> s:on_out(msgs)},})
        endif
    endif
endfunction
