---@class LuaRust
---@field hello_world fun(): nil
---@field add fun(x: integer, y: integer): integer
local rust = require("lua_rust")

print(string.format("1 + 2 = %d", rust.add(1, 2)))
rust.hello_world()

