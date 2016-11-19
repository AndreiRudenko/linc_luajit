package llua;


import llua.State;


@:include('linc_lua.h')
extern class LuaJIT {

    @:native('luaJIT_setmode')
    static function setmode(l:State, idx:Int , mode:Int) : Int;

    /* Flags or'ed in to the mode. */
    public static inline var LUAJIT_MODE_OFF:Int    = 0x0000;  /* Turn feature off. */
    public static inline var LUAJIT_MODE_ON:Int     = 0x0100;  /* Turn feature on. */
    public static inline var LUAJIT_MODE_FLUSH:Int  = 0x0200;  /* Flush JIT-compiled code. */

} // LuaJIT
