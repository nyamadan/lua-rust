#![allow(non_snake_case)]

use std::ffi::{c_char, c_int, c_longlong, c_void, CString};

#[link(name = "./build/lib/lua544d", kind = "dylib")]
extern "C" {
    fn luaL_checkinteger(L: *const c_void, arg: c_int) -> c_longlong;
    fn lua_pushinteger(L: *const c_void, arg: c_longlong);

    fn lua_setfield(L: *const c_void, idx: c_int, k: *const c_char);
    fn lua_createtable(L: *const c_void, narr: c_int, nrec: c_int);
    fn lua_pushcclosure(
        L: *const c_void,
        callback: unsafe extern "C" fn(*const c_void) -> c_int,
        n: c_int,
    );
}

unsafe extern "C" fn lua_hello_world(_: *const c_void) -> c_int {
    println!("Hello world!!");
    return 0;
}

unsafe extern "C" fn lua_add(L: *const c_void) -> c_int {
    let x = luaL_checkinteger(L, 1);
    let y = luaL_checkinteger(L, 2);
    lua_pushinteger(L, x + y);
    return 1;
}

#[no_mangle]
pub unsafe extern "C" fn luaopen_lua_rust(L: *const c_void) -> c_int {
    lua_createtable(L, 0, 0);

    lua_pushcclosure(L, lua_hello_world, 0);
    let name = CString::new("hello_world").unwrap();
    lua_setfield(L, -2, name.as_ptr());

    lua_pushcclosure(L, lua_add, 0);
    let name = CString::new("add").unwrap();
    lua_setfield(L, -2, name.as_ptr());
    return 1;
}
