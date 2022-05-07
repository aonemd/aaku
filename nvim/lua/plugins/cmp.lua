local require_safe = require("utils").require_safe

local cmp     = require_safe("cmp")
local luasnip = require_safe("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local mappings = cmp.mapping.preset.insert({
  ["<C-k>"]  = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ["<C-j>"]  = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  ['<Up>']   = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),

  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),

  ['<Enter>']   = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping.complete(),
  ["<C-y>"]     = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ["<C-e>"]     = cmp.mapping {
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  },
  -- Accept currently selected item. If none selected, `select` first item.
  -- Set `select` to `false` to only confirm explicitly selected items.
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      fallback()
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
})

cmp.setup {
  completion = { completeopt = "menu,menuone,noinsert" },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = mappings,
  formatting = {
    fields = { "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    documentation = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
  },
  views = {
    entries = 'native',
  },
  experimental = {
    ghost_text = false,
  },
}

cmp.setup.cmdline('/', {
	mapping = mappings,
  view = {
    entries = {name = 'wildmenu', separator = '|' }
  },
	sources = {
		{ name = "buffer", keyword_length = 2 },
	},
})

cmp.setup.cmdline(":", {
	mapping = mappings,
	sources = {
		{ name = "path", keyword_length = 2 },
		{ name = "cmdline", keyword_length = 2, keyword_pattern = [=[[^[:blank:]\!]*]=] },
	},
})
