local M = {}

---My special Module :)
---@class larp
---@field fn larp.fn
M = M or {}

---@class larp.fn
---@field merge_dict function
---@field map function
---@field multimap function
M.fn = M.fn or {}
M.fn.merge_dict = M.fn.merge_dict or {}
M.fn.map = M.fn.map or vim.keymap.set
M.fn.multimap = M.fn.multimap or {}

---@class larp.fn.merge_dict.opts
---@field overlay? larp.fn.merge_dict.opts.overlay
---@field format? fun(key: any, value: any): any function to format values in `overlay` table.
---
---@class larp.fn.merge_dict.opts.overlay
---@field enable? boolean Whether to overlay.
---@field exclude? table Array of specific keys to prevent correspoding values from getting overlayed.
---
---Merge two tables, one overlaying the other.
---@param base table Base table to be overlayed.
---@param top table Overlay table to be overlayed with onto {base}.
---@param opts? larp.fn.merge_dict.opts Options
---@return table
function M.fn.merge_dict(base, top, opts)
    opts = opts or {}
    setmetatable(opts, {
        __index = {
            overlay = {
                enable = true,
                exclude = {},
            },
            format = function(_, v)
                return v
            end,
        },
    })

    for k, v in pairs(top) do
        if (opts.overlay == false and opts[k] ~= nil) or opts.overlay == true then
            base[k] = opts.format(v)
        end
    end
    return base
end

---@class larp.fn.map.Params
---@field mode string Mode in which the keymap is applied.
---@field lhs string Key sequence to be mapped.
---@field rhs string|function Key sequence or function to be simulated.
---@field opts? larp.fn.map.Opts
---
---@class larp.fn.map.Opts : vim.keymap.set.Opts
---@field desc_prefix? string String prefix to add to description.
---
---Set keymaps. Same with [vim.keymap.set()](lua://vim.api.nvim_set_keymap), but with some tweaks.
---@param mode string Mode in which the keymap is applied.
---@param lhs string Key sequence to be mapped.
---@param rhs string|function Key sequence or function to be simulated.
---@param opts? larp.fn.map.Opts Options to change behavior of the keymap function.
---@see larp.fn.multimap
---@return nil
function M.fn.map(mode, lhs, rhs, opts)
    opts = opts or {}
    setmetatable(opts, {
        __index = {
            silent = true,
            remap = false,
            desc_prefix = '[larp] ',
        },
    })

    opts.desc = opts.desc ~= nil and opts.desc_prefix .. opts.desc or opts.desc

    vim.keymap.set(mode, lhs, rhs, opts)
end

---Set Keymaps at once using [map](lua://larp.fn.map) function.
---@param keymaps larp.fn.map.Params[] List of keymaps.
---@see larp.fn.map
---@return nil
function M.fn.multimap(keymaps)
    for _, keymap in ipairs(keymaps) do
        M.fn.map(table.unpack(keymap))
    end
end

---Get currently selected text.
---@return table
function M.fn.get_selection_text()
    local _, srow, scol = unpack(vim.fn.getpos('v'))
    local _, erow, ecol = unpack(vim.fn.getpos('.'))

    -- visual line mode
    if vim.fn.mode() == 'V' then
        if srow > erow then
            return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
        else
            return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
        end
    end

    -- regular visual mode
    if vim.fn.mode() == 'v' then
        if srow < erow or (srow == erow and scol <= ecol) then
            return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
        else
            return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
        end
    end

    -- visual block mode
    if vim.fn.mode() == '\22' then
        local lines = {}
        if srow > erow then
            srow, erow = erow, srow
        end
        if scol > ecol then
            scol, ecol = ecol, scol
        end
        for i = srow, erow do
            table.insert(
                lines,
                vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
            )
        end
        return lines
    end
    return { "" }
end

return M
