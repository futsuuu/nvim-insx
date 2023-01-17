local kit = require('insx.kit')
local helper = require('insx.helper')

---@class insx.recipe.jump_next.Option
---@field public jump_pat string|string[]

---@param option insx.recipe.jump_next.Option
---@return insx.RecipeSource
local function jump_next(option)
  local jump_pat = kit.to_array(option.jump_pat)
  return {
    ---@param ctx insx.ActionContext
    action = function(ctx)
      ctx.move(ctx.data.pos[1], ctx.data.pos[2])
    end,
    ---@param ctx insx.Context
    enabled = function(ctx)
      local curr_pos = { math.huge, math.huge }
      for _, pat in ipairs(jump_pat) do
        local pos = helper.search.get_next(pat)
        if pos then
          if helper.position.gt(pos, curr_pos) then
            curr_pos = pos
          end
        end
      end
      if curr_pos[1] == math.huge then
        return false
      end
      ctx.data.pos = curr_pos
      return true
    end,
  }
end

return jump_next
