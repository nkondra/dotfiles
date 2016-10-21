# Nathan's DotFiles

Testing configurations:

- Removed xmod mapper from zshrc and replaced it with dconf command

`dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"`

This will get automated into the build rake task when confirmed
functionaility is correct
