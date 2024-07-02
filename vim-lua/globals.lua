-- Global options
-- ===============================================
-- have vim save the backups in the /tmp/ directory, remembering the
-- file path of the files
-- https://stackoverflow.com/a/4824781/2752888
vim.opt.backupdir="~/.vim/tmp//"
vim.opt.directory="~/.vim/tmp//"
vim.opt.hidden = true -- Allows for hidden buffers in the background
vim.opt.cursorline = true-- Highlights the current line
vim.opt.number=true-- Number all the lines relative to cursor
vim.opt.relativenumber=true-- Number all the lines relative to cursor
vim.opt.expandtab = true-- Use spaces for tabs
vim.opt.cc="81" -- Set the color column at 81
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.formatoptions="tcqr"
    -- t auto-wrap text
    -- c auto-wrap commetns
    -- q allow comments to wrap
    -- r auto-continue comment lines
-- https://stackoverflow.com/a/11560415/2752888
vim.opt.list = true-- Display unprintable characters f12 - switches
-- https://vi.stackexchange.com/a/34644
vim.opt.listchars:append({ tab = '<->' }) 
vim.opt.listchars:append({ trail = '•' }) 
vim.opt.listchars:append({ extends = '»' }) 
vim.opt.listchars:append({ precedes = '«' })  -- Unprintable chars mapping
vim.opt.backspace={"indent","eol","start"} -- more powerful backspacing
-- https://stackoverflow.com/a/33358103/2752888
vim.opt.mouse="a"

