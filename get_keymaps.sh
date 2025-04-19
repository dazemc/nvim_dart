#/bin/bash
cat ~/.config/nvim/init.lua | grep -E "map|keymap|nvim_set_keymap" > keymaps.txt
