package.cpath = package.cpath .. ";./target/debug/?.dll"

local rust = require("lua_rust")
rust.hello_world()
