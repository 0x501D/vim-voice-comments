# Voice comments plugin for vim

## Install
.vimrc:
```vim
Plugin '0x501D/vim-voice-comments'
nnoremap <silent> <F7> :call PlayVoice()<CR>
nnoremap <silent> <F8> :call RecVoice()<CR>
```

## Usage example
```c
/* voice:~/stuff/bruh.ogg */
int (*c(int (*cb(void))(int)))(int)
{
    return cb();
}
```

Move cursor to line with voice commet and press F7 to play comment.
Pressing F7 again will stop playback.

Move cursor to the empty line and press F8 to record comment.
Pressing F8 again will end the recording.

## Options
`let g:voice_comment_format = 'ogg'` - recording audio format (default: ogg). 

## Demo
[![Recording](https://img.youtube.com/vi/wumX-MIJlWo/1.jpg)](https://www.youtube.com/watch?v=wumX-MIJlWo)

## Requirements
* `rec`, `play` [media-sound/sox](https://sourceforge.net/projects/sox/)
