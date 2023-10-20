local M = {}

M.toggle_quickfix = function()
  local nr = vim.fn.winnr("$")
  vim.cmd "cwindow"
  local nr2 = vim.fn.winnr("$")
  if nr == nr2 then
    vim.cmd "cclose"
  end
end

M.toggle_location = function()
  local nr = vim.fn.winnr("$")
  vim.cmd "lwindow"
  local nr2 = vim.fn.winnr("$")
  if nr == nr2 then
    vim.cmd "lclose"
  end
end

M.is_opened = function(typ)
  if typ == "qf" then
    local ids = vim.fn.getqflist({ winid = 1 })
    return ids.winid ~= 0
  else
    local ids = vim.fn.getloclist(0, { winid = 1 })
    return ids.winid ~= 0
  end
end

M.has = function(typ)
  if typ == "qf" then
    local elts = vim.fn.getqflist()
    return #elts > 0
  else
    local elts = vim.fn.getloclist(0)
    return #elts > 0
  end
end

M.loop = function()
  local statuses = {
    xx = "qx",
    ql = "qx",
    qx = "xl",
    xl = "xx",
  }
  local status = ""

  if M.is_opened("qf") then
    status = "q"
  else
    status = "x"
  end

  if M.is_opened("locl") then
    status = status .. "l"
  else
    status = status .. "x"
  end

  while true do
    status = statuses[status]
    if status:sub(1, 1) == "q" then
      if not M.has("qf") then
        -- skip rest of the loop
      else
        vim.cmd "copen"
        if status:sub(2, 2) == "l" then
          if not M.has("locl") then
            -- skip rest of the loop
          else
            vim.cmd "lopen"
            break
          end
        else
          vim.cmd "lclose"
          break
        end
      end
    else
      vim.cmd "cclose"
      if status:sub(2, 2) == "l" then
        if not M.has("locl") then
          -- skip rest of the loop
        else
          vim.cmd "lopen"
          break
        end
      else
        vim.cmd "lclose"
        break
      end
    end
  end
end


M.setup = function(opts)
  local default_keymap = {
    quickfix_loop = '<C-g><C-o>',
    quickfix_toggle = '<Leader>qt',
    location_toggle = '<Leader>lt'
  }

  opts = opts or {}
  local keymap_opts = vim.tbl_extend('force', default_keymap, opts.keymap or {})

  vim.keymap.set('n', keymap_opts.quickfix_loop, M.loop)
  vim.keymap.set('n', keymap_opts.quickfix_toggle, M.loop)
  vim.keymap.set('n', keymap_opts.location_toggle, M.loop)
end

return M
