# nvim-insx

Flexible key mapping manager.

https://github.com/hrsh7th/nvim-insx/assets/629908/ad878d95-c541-4d6c-b135-139d511602b8


## Warning

- The *basic* recipes supports dot-repeat
  - However, advanced recipes don't support dot-repeat.
- This plugin is *usually* works as expected.
  - Does not aim to support to always work as expected because this plugin uses RegExp 😅
- It is more convenient when used with vim-matchup.
  - The demo image uses with vim-matchup. 👍
- This plugin provides *basic* cmdline-mode pairwise features.
  - The advanced recipes aren't support cmdline-mode.

## Usage

This plugin does not provide any default mappings.
You should define mapping by yourself like this.

#### Use preset

```lua
require('insx.preset.standard').setup()
```

#### Use recipe

```lua
local insx = require('insx')

insx.add(
  "'",
  insx.with(require('insx.recipe.auto_pair')({
    open = "'",
    close = "'"
  }), {
    insx.with.in_string(false),
    insx.with.in_comment(false),
    insx.with.nomatch([[\\\%#]]),
    insx.with.nomatch([[\a\%#]])
  })
)
```

## Create your own recipe

```lua
-- Simple pair deletion recipe.
local function your_recipe(option)
  return {
    action = function(ctx)
      if option.allow_space then
        ctx.remove([[\s*\%#\s*]])
      end
      ctx.send('<BS><Right><BS>')
    end,
    enabled = function(ctx)
      if option.allow_space then
        return ctx.match([[(\s*\%#\s*)]])
      end
      return ctx.match([[(\%#)]])
    end
  }
end
```

The standard preset enables some of the advanced features.

### Status

The API is stable except helper related APIs.

bug report & feature request are welcome.

