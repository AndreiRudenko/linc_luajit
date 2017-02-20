package llua;


@:native('::cpp::Reference<lua_State>')
@:include('linc_lua.h')
extern class State {}


// @:native("lua_State")
// @:include('linc_lua.h')
// extern private class Lua_State {}
// typedef State = cpp.Pointer<Lua_State>;
