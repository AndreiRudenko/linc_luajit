package lua;

import lua.Lua_State;

/*
@:native("luaL_Buffer")
@:include('linc_lua.h')
extern private class LuaLBuffer {}
typedef LuaL_Buffer = cpp.Pointer<LuaLBuffer>;
*/

@:structAccess
@:include('linc_sdl.h') @:native("::cpp::Struct<luaL_Buffer>")
extern class LuaL_Buffer {
    var p:String;
    var lvl:Int;
    var L:Lua_State;
    var file:cpp.ConstCharStar;
    var buffer:Array<String>;
}

/*
typedef struct luaL_Buffer {
  char *p;          // current position in buffer 
  int lvl;  // number of strings in the stack (level)
  lua_State *L;
  char buffer[LUAL_BUFFERSIZE];
} luaL_Buffer;

*/

