package lua;

// @:native("lua_State")
@:native('::cpp::Reference<lua_State>')
@:include('linc_lua.h')
extern class State {}
// private extern class Lua_State {}
// typedef State = cpp.Pointer<Lua_State>;