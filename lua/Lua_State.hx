package lua;

@:native("lua_State")
@:include('linc_lua.h')
private extern class LState {}
typedef Lua_State = cpp.Pointer<LState>;


