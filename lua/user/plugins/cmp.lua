local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print("cmp not ok")
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  print("luasnip not ok")
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  print("icons not ok")
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Class           = icons.code.class,
  Color           = icons.code.color,
  Constant        = icons.code.constant,
  Constructor     = icons.code.constructor,
  Enum            = icons.code.enum,
  EnumMember      = icons.code.enum,
  Event           = icons.code.event,
  Field           = icons.code.field,
  File            = icons.code.file,
  Folder          = icons.code.folder,
  Function        = icons.code.func,
  Interface       = icons.code.interface,
  Keyword         = icons.code.keyword,
  Method          = icons.code.method,
  Module          = icons.code.module,
  Operator        = icons.code.operators,
  Property        = icons.code.property,
  Reference       = icons.code.reference,
  Snippet         = icons.code.snippet,
  Struct          = icons.code.struct,
  Text            = icons.code.text,
  TypeParameter   = icons.code.typeParameter,
  Unit            = icons.code.unit,
  Value           = icons.code.value,
  Variable        = icons.code.variable,
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-a>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- ["<C-e>"] = cmp.mapping {
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- },
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = {"abbr", "kind", "menu" },
    format = function(entry, item)
      -- print(entry.source.name)
      -- local icon = entry.source.name == "copilot" and icons.copilot or kind_icons[item.kind]
      local icon = kind_icons[item.kind]
      item.kind = string.format("%s %s", icon, item.kind)
      return item
    end,
  },
  sources = {
    { name = "nvim_lsp", group_index = 2, priority = 100 },
    { name = "nvim_lsp_signature_help", group_index = 2},
    { name = "nvim_lua", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "path", group_index = 2 },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  window = {
    completion = {
      side_padding = 1,
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
      scrollbar = false,
      border = border "CmpBorder",
    },
    documentation = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc",
    },
  },
  compare = {
    locality = {
      lines_count = 300
    }
  },
  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },
  preselect = cmp.PreselectMode.Item,
  sorting = {
    priority_weight = 2,
    comparators = {
      -- require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,

      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too

      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
