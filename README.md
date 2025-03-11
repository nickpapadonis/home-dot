# Home Dot Files for Multi-OS and Shell Environments

These are some dot files I've been testing across different operating systems
and shells.  Recently, I've tested zsh, ksh and bash on MacOS.  If you install
X with MacPorts or Homebrew the xterm and rxvt titlebar will update with the
executed command.  This occurs for all shells mentioned above.  In addition
the prompt is colorized.  I also provide an Xresources to configure 'rxvt' and
'xterm'

## Installation

These files go in $HOME, pick and choose.

```bash
cp ./.name ~
```

## Notes

For some reason, which I continue to debug, ksh and bash make audible
beeps when updating the Terminal.app, xterm or rxvt title bar.  This corresponds
to the escapes in $PS1 prompt command.  I notice that the zsh included with OSX
doesn't make these audible beeps, probably because it's not using the same operating
in the DEBUG trap used to update the title bar.

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
