" Vim plug-in
" Author: 0x501D

let s:is_playing = 0
let s:job = {}

function! s:on_out(msgs)
    echom a:msgs
endfunction

function! s:on_play_exit()
    let s:is_playing = 0
endfunction

function! PlayVoice()
    if s:is_playing == 1
        let s:is_playing = 0
        call job_stop(s:job, 'int')
        return
    endif

    let line = getline('.')
    if match(line, ' :voice=')
        let comment_path = substitute(line, '.* :voice="\(.*\)".*', '\1', '') 
        if len(comment_path) > 0
            let cmd = ["mpv", comment_path]
            let s:job = job_start(cmd, {
                        \ 'exit_cb': {job, status -> s:on_play_exit()},
                        \ 'out_cb': {channel, msgs -> s:on_out(msgs)},})
            let s:is_playing = 1
        endif
    endif
endfunction
