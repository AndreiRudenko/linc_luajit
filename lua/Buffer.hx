package lua;

@:native("luaL_Buffer")
@:include('linc_lua.h')
extern private class LuaL_Buffer {}
typedef Buffer = cpp.Pointer<LuaL_Buffer>;	
