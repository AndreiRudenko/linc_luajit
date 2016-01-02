package lua;

import lua.Lua;

@:keep
@:include('linc_lua.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('lua'))
#end
extern class LuaL {

    @:native('luaL_addchar')
    static function addchar(b:LuaL_Buffer, c:String) : Void;

    @:native('luaL_addlstring')
    static function addlstring(b:LuaL_Buffer, s:String, l:Int) : Void;

    @:native('luaL_addsize')
    static function addsize(b:LuaL_Buffer, n:Int) : Void;

    @:native('luaL_addstring')
    static function addstring(b:LuaL_Buffer, s:String) : Void;

    @:native('luaL_addvalue')
    static function addvalue(b:LuaL_Buffer) : Void;

    @:native('luaL_argcheck')
    static function argcheck(l:Lua_State, cond:Int, narg:Int, extramsg:String) : Void;

    @:native('luaL_argerror')
    static function argerror(l:Lua_State, narg:Int, extramsg:String) : Int;

    @:native('luaL_buffinit')
    static function buffinit(l:Lua_State, b:LuaL_Buffer) : Void;

    @:native('luaL_callmeta')
    static function callmeta(l:Lua_State, obj:Int, e:String) : Int;

    @:native('luaL_checkany')
    static function checkany(l:Lua_State, narg:Int) : Void;

    @:native('luaL_checkint')
    static function checkint(l:Lua_State, narg:Int) : Int;

    @:native('luaL_checkinteger')
    static function checkinteger(l:Lua_State, narg:Int) : Int;

    @:native('luaL_checklong')
    static function checklong(l:Lua_State, narg:Int) : Float;

    @:native('luaL_checklstring')
    static function checklstring(l:Lua_State, narg:Int, l:Int) : String;

    @:native('luaL_checknumber')
    static function checknumber(l:Lua_State, narg:Int) : Float;

    @:native('luaL_checkoption')
    static function checkoption(l:Lua_State, narg:Int, def:String, const:Array<String>) : Int;

    @:native('luaL_checkstack')
    static function checkstack(l:Lua_State, sz:Int, msg:String) : Void;

    @:native('luaL_checkstring')
    static function checkstring(l:Lua_State, narg:Int) : String;

    @:native('luaL_checktype')
    static function checktype(l:Lua_State, narg:Int, t:Int) : Void;

    @:native('luaL_checkudata')
    static function checkudata(l:Lua_State, narg:Int, tname:String) : Void;

    @:native('luaL_dofile')
    static function dofile(l:Lua_State, filename:String) : Int;

    @:native('luaL_dostring')
    static function dostring(l:Lua_State, str:String) : Int;

    // @:native('luaL_error')
    // static function error(l:Lua_State, fmt:String, ...) : Int;

    @:native('luaL_getmetafield')
    static function getmetafield(l:Lua_State, obj:Int, e:String) : Int;

    @:native('luaL_getmetatable')
    static function getmetatable(l:Lua_State, tname:String) : Void;

    @:native('luaL_gsub')
    static function gsub(l:Lua_State, s:String, p:String, r:String) : String;

    @:native('luaL_loadbuffer')
    static function loadbuffer(l:Lua_State, buff:String, sz:Int, name:String) : Int;

    @:native('luaL_loadfile')
    static function loadfile(l:Lua_State, filename:String) : Int;

    @:native('luaL_loadstring')
    static function loadstring(l:Lua_State, s:String) : Int;

    @:native('luaL_newmetatable')
    static function newmetatable(l:Lua_State, tname:String) : Int;

    @:native('luaL_newstate')
    static function newstate() : Lua_State;

    @:native('luaL_openlibs')
    static function openlibs(l:Lua_State) : Void;

    @:native('luaL_optint')
    static function optint(l:Lua_State, narg:Int, d:Int) : Int;

    @:native('luaL_optinteger')
    static function optinteger(l:Lua_State, narg:Int, d:Int) : Int;

    @:native('luaL_optlong')
    static function optlong(l:Lua_State, narg:Int, d:Float) : Float;

    @:native('luaL_optlstring')
    static function optlstring(l:Lua_State, narg:Int, d:String, l:Int) : String;

    @:native('luaL_optnumber')
    static function optnumber(l:Lua_State, narg:Int, d:Float) : Float;

    @:native('luaL_optstring')
    static function optstring(l:Lua_State, narg:Int, d:String) : String;

    @:native('luaL_prepbuffer')
    static function prepbuffer(b:LuaL_Buffer) : String;

    @:native('luaL_pushresult')
    static function pushresult(b:LuaL_Buffer) : Void;

    @:native('luaL_ref')
    static function ref(b:LuaL_Buffer, t:Int) : Int;

    // luaL_Reg
    // typedef struct luaL_Reg {
    //   const char *name;
    //   lua_CFunction func;
    // } luaL_Reg;

    // @:native('luaL_register')
    // static function register(l:Lua_State, libname:String, lr:luaL_Reg) : Void;

    @:native('luaL_typename')
    static function typename(l:Lua_State, index:Int) : String;

    @:native('luaL_typerror')
    static function typerror(l:Lua_State, narg:Int, tname:String) : Int;

    @:native('luaL_unref')
    static function unref(l:Lua_State, t:Int, ref:Int) : Void;

    @:native('luaL_where')
    static function where(l:Lua_State, lvl:Int) : Void;


} //LuaL

@:include('linc_lua.h') @:native("::cpp::Reference<LuaL_Buffer>")
extern class LuaL_Buffer {}