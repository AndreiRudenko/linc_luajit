package llua;


import llua.State;


@:include('linc_lua.h')
extern class LuaOpen {

    @:native('luaopen_base')
    static function base(l:State) : Int;

    @:native('luaopen_math')
    static function math(l:State) : Int;

    @:native('luaopen_string')
    static function string(l:State) : Int;

    @:native('luaopen_table')
    static function table(l:State) : Int;

    @:native('luaopen_io')
    static function io(l:State) : Int;

    @:native('luaopen_os')
    static function os(l:State) : Int;

    @:native('luaopen_package')
    static function lpackage(l:State) : Int; // renamed from "package"

    @:native('luaopen_debug')
    static function debug(l:State) : Int;

    @:native('luaopen_bit')
    static function bit(l:State) : Int;

    @:native('luaopen_jit')
    static function jit(l:State) : Int;

    @:native('luaopen_ffi')
    static function ffi(l:State) : Int;

} // Luaopen
