" Vim plug-in
" Author: 0x501D

let s:is_playing = 0
let s:is_recording = 0
let s:play_job = {}
let s:rec_job = {}
let s:random_name = ''

function! s:on_out(msgs, title)
    echom a:title .. a:msgs
endfunction

function! s:on_play_exit()
    let s:is_playing = 0
endfunction

function! PlayVoice()
    if s:is_playing == 1
        let s:is_playing = 0
        call job_stop(s:play_job, 'int')
        return
    endif

    let line = getline('.')
    if match(line, ' voice:') > 0
        let comment_path = substitute(line, '^.* voice:\(.*\)$', '\1', '')
        let comment_path = substitute(comment_path, '\(.*\)\s\*/', '\1', '')
        if len(comment_path) > 0
            let cmd = ["play", comment_path]
            let s:play_job = job_start(cmd, {
                        \ 'exit_cb': {job, status -> s:on_play_exit()},
                        \ 'err_cb': {channel, msgs ->
                        \ s:on_out(msgs, 'playing: ' .. comment_path .. ' ')},})
            let s:is_playing = 1
        endif
    endif
endfunction

function! RecVoice()
    if s:is_recording == 1
        let s:is_recording = 0
        call job_stop(s:rec_job, 'int')

        let type = &filetype
        if type ==# 'c'
            call setline('.', '/* voice:' .. s:random_name .. ' */')
        elseif type ==# 'cpp' || type ==# 'rust'
            call setline('.', '// voice:' .. s:random_name)
        elseif type ==# 'sh' || type == 'python'
            call setline('.', '# voice:' .. s:random_name)
        else
            let comment = printf(&commentstring, ' voice:' .. s:random_name)
            call setline('.', comment)
        endif

        return
    endif

    if len(getline('.')) == 0
        let format = get(g:, 'voice_comment_format', 'ogg')
        let s:random_name = './' ..
                    \ substitute(reltimestr(reltime()), '\.', '', 'g') ..
                    \ '.' .. format

        let cmd = ["rec", s:random_name]
        let s:rec_job = job_start(cmd, {
                        \ 'err_cb': {channel, msgs ->
                        \ s:on_out(msgs, 'recording: ' .. s:random_name ..
                        \ ' ')},})
        let s:is_recording = 1
    endif
endfunction
