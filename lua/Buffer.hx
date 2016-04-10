package lua;

import lua.State;

// @:native("luaL_Buffer")
// @:include('linc_lua.h')
// extern private class LuaL_Buffer {}
// typedef Buffer = cpp.Pointer<LuaL_Buffer>;	

/*
@:keep
@:include('linc_lua.h') @:native("luaL_Buffer")
extern class Buffer {
    var p:String;    // current position in buffer
    var lvl:Int;     // number of strings in the stack (level)
    var L:State;        
    var buffer:String;
}
*/

@:noCompletion
@:structAccess
@:include('linc_lua.h') @:native("::luaL_Buffer")
extern class LuaL_Buffer {
    var p:String;    // current position in buffer
    var lvl:Int;     // number of strings in the stack (level)
    var L:State;        
    var buffer:String;
}
@:include('linc_lua.h') @:native("::cpp::Reference<luaL_Buffer>")
extern class BufferRef extends LuaL_Buffer {}
@:include('linc_lua.h') @:native("::cpp::Struct<luaL_Buffer>")
extern class Buffer extends BufferRef {}