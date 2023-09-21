# Voice comments plugin for vim

## Install
.vimrc:
```vim
Plugin '0x501D/vim-voice-comments'
nnoremap <silent> <F7> :call PlayVoice()<CR>
```

## Usage example
```c
/* :voice="~/stuff/bruh.mp3" */
int (*c(int (*cb(void))(int)))(int)
{
    return cb();
}
```

Move cursor to line with voice commet and press F7.
`mpv` required.
