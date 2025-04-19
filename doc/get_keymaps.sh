#/bin/bash
# Just feed the output into an llm, too lazy to do more
cat ~/.config/nvim/init.lua | grep -E "map|keymap|nvim_set_keymap" > keymaps.txt
