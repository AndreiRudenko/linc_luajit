package lua;

@:keep
@:include('linc_lua.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('lua'))
#end
extern class Lua {

	// lua_Alloc : typedef void * (*lua_Alloc) (void *ud, void *ptr, size_t osize, size_t nsize);

    // @:native('lua_atpanic')
    // static function atpanic(l:Lua_State, panicf:lua_CFunction) : lua_CFunction;

    @:native('lua_call')
    static function call(l:Lua_State, nargs:Int, nresults:Int) : Void;

    // lua_CFunction : typedef int (*lua_CFunction) (lua_State *L);

    @:native('lua_checkstack')
    static function checkstack(l:Lua_State, extra:Int) : Int;
    
    @:native('lua_close')
    static function close(l:Lua_State) : Void;

    @:native('lua_concat')
    static function concat(l:Lua_State, n:Int) : Void;

    // @:native('lua_cpcall')
    // static function cpcall(l:Lua_State, func:lua_CFunction, ud:Void) : Int;

    @:native('lua_createtable')
    static function createtable(l:Lua_State, narr:Int, nrec:Int) : Void;

    // @:native('lua_dump')
    // static function dump(l:Lua_State, writer:lua_Writer, data:Void) : Void;

    @:native('lua_equal')
    static function equal(l:Lua_State, index1:Int, index2:Int) : Int;

    @:native('lua_error')
    static function error(l:Lua_State) : Int;

    @:native('lua_gc')
    static function gc(l:Lua_State, what:Int, data:Int) : Int;

    // @:native('lua_getallocf')
    // static function getallocf(l:Lua_State, ud:Void) : lua_Alloc; // lua_Alloc lua_getallocf (lua_State *L, void **ud);

    @:native('lua_getfenv')
    static function getfenv(l:Lua_State, int:Int) : Void;

    @:native('lua_getfield')
    static function getfield(l:Lua_State, index:Int, k:String) : Void;

    @:native('lua_getglobal')
    static function getglobal(l:Lua_State, name:String) : Void;

    @:native('lua_getmetatable')
    static function getmetatable(l:Lua_State, index:Int) : Int;

    @:native('lua_gettable')
    static function gettable(l:Lua_State, index:Int) : Void;

    @:native('lua_gettop')
    static function gettop(l:Lua_State) : Int;

    @:native('lua_insert')
    static function insert(l:Lua_State, index:Int) : Void;

	// lua_Integer : typedef ptrdiff_t lua_Integer;

    @:native('lua_isboolean')
    static function isboolean(l:Lua_State, index:Int) : Int;

    @:native('lua_iscfunction')
    static function iscfunction(l:Lua_State, index:Int) : Int;

    @:native('lua_isfunction')
    static function isfunction(l:Lua_State, index:Int) : Int;

    @:native('lua_islightuserdata')
    static function islightuserdata(l:Lua_State, index:Int) : Int;

    @:native('lua_isnil')
    static function isnil(l:Lua_State, index:Int) : Int;

    @:native('lua_isnone')
    static function isnone(l:Lua_State, index:Int) : Int;

    @:native('lua_isnoneornil')
    static function isnoneornil(l:Lua_State, index:Int) : Int;

    @:native('lua_isnumber')
    static function isnumber(l:Lua_State, index:Int) : Int;

    @:native('lua_isstring')
    static function isstring(l:Lua_State, index:Int) : Int;

    @:native('lua_istable')
    static function istable(l:Lua_State, index:Int) : Int;

    @:native('lua_isthread')
    static function isthread(l:Lua_State, index:Int) : Int;

    @:native('lua_isuserdata')
    static function isuserdata(l:Lua_State, index:Int) : Int;

    @:native('lua_lessthan')
    static function lessthan(l:Lua_State, index1:Int, index2:Int) : Int;

    // @:native('lua_load')
    // static function load(l:Lua_State, reader:lua_Reader, data:Void, chunkname:String) : Int;

    // @:native('lua_newstate')
    // static function newstate(f:lua_Alloc, ud:Void) : Lua_State;

    @:native('lua_newtable')
    static function newtable(l:Lua_State) : Void;

    @:native('lua_newthread')
    static function newthread(l:Lua_State) : Lua_State;

    @:native('lua_newuserdata')
    static function newuserdata(l:Lua_State, size:Int) : Void;

    @:native('lua_next')
    static function next(l:Lua_State, index:Int) : Int;

	// lua_Number : typedef double lua_Number;

    @:native('lua_objlen')
    static function objlen(l:Lua_State, index:Int) : Int;

    @:native('lua_pcall')
    static function pcall(l:Lua_State, nargs:Int, nresults:Int, errfunc:Int) : Int;

    @:native('lua_pop')
    static function pop(l:Lua_State, n:Int) : Void;

    @:native('lua_pushboolean')
    static function pushboolean(l:Lua_State, b:Int) : Void;

    // @:native('lua_pushcclosure')
    // static function pushcclosure(l:Lua_State, fn:lua_CFunction n:Int) : Void;

    // @:native('lua_pushcfunction')
    // static function pushcfunction(l:Lua_State, f:Int) : Void;

    // @:native('lua_pushfstring')
    // static function pushfstring(l:Lua_State, fmt:String, ...) : Void;

    @:native('lua_pushinteger')
    static function pushinteger(l:Lua_State, n:Int) : Void; // void lua_pushinteger (lua_State *L, lua_Integer n);

    // @:native('lua_pushlightuserdata')
    // static function pushlightuserdata(l:Lua_State, p:Void) : Void;

    @:native('lua_pushliteral')
    static function pushliteral(l:Lua_State, s:String) : Void;

    @:native('lua_pushlstring')
    static function pushlstring(l:Lua_State, s:String, len:Int) : Void;

    @:native('lua_pushnil')
    static function pushnil(l:Lua_State) : Void;

    @:native('lua_pushnumber')
    static function pushnumber(l:Lua_State, n:Float) : Void;

    @:native('lua_pushstring')
    static function pushstring(l:Lua_State, s:String) : Void;

    @:native('lua_pushthread')
    static function pushthread(l:Lua_State) : Int;

    @:native('lua_pushvalue')
    static function pushvalue(l:Lua_State, index:Int) : Void;

    // @:native('lua_pushvfstring')
    // static function pushvfstring(l:Lua_State, fmt:String, argp:va_list) : Void;

    @:native('lua_rawequal')
    static function rawequal(l:Lua_State, index1:Int, index2:Int) : Int;

    @:native('lua_rawget')
    static function rawget(l:Lua_State, index:Int) : Void;

    @:native('lua_rawgeti')
    static function rawgeti(l:Lua_State, index:Int, n:Int) : Void;

    @:native('lua_rawset')
    static function rawset(l:Lua_State, index:Int) : Void;

    @:native('lua_rawseti')
    static function rawseti(l:Lua_State, index:Int, n:Int) : Void;

    // lua_Reader : typedef const char * (*lua_Reader) (lua_State *L, void *data, size_t *size);

    static inline function register(l:Lua_State, name:String, f:Dynamic) : Void {
        if(Type.typeof(f) == Type.ValueType.TFunction && !Lua_helper.callbacks.exists(name)){
            Lua_helper.add_callback(l, name, f);
        }
    }

    @:native('lua_remove')
    static function remove(l:Lua_State, index:Int) : Void;

    @:native('lua_replace')
    static function replace(l:Lua_State, index:Int) : Void;

    @:native('lua_resume')
    static function resume(l:Lua_State, narg:Int) : Int;

    // @:native('lua_setallocf')
    // static function setallocf(l:Lua_State, f:lua_Alloc, ud:Void) : Void;

    @:native('lua_setfenv')
    static function lua_setfenv(l:Lua_State, index:Int) : Int;

    @:native('lua_setfield')
    static function setfield(l:Lua_State, index:Int, s:String) : Void;

    @:native('lua_setglobal')
    static function setglobal(l:Lua_State, name:String) : Void;

    @:native('lua_setmetatable')
    static function setmetatable(l:Lua_State, index:Int) : Int;

    @:native('lua_settable')
    static function settable(l:Lua_State, index:Int) : Int;

    @:native('lua_settop')
    static function settop(l:Lua_State, index:Int) : Void;

	// lua_State : typedef struct lua_State lua_State;

    @:native('lua_status')
    static function status(l:Lua_State) : Int;

    @:native('lua_toboolean')
    static function toboolean(l:Lua_State, index:Int) : Int;

    // @:native('lua_tocfunction')
    // static function tocfunction(l:Lua_State, index:Int) : lua_CFunction;

    @:native('lua_tointeger')
    static function tointeger(l:Lua_State, index:Int) : Int;

    // @:native('lua_tolstring')
    @:native('linc::lua::tolstring')
    static function tolstring(l:Lua_State, index:Int, len:Int) : String;

    @:native('lua_tonumber')
    static function tonumber(l:Lua_State, index:Int) : Float;

    @:native('lua_topointer')
    static function topointer(l:Lua_State, index:Int) : Void;

    // @:native('lua_tostring')
    @:native('linc::lua::tostring')
    static function tostring(l:Lua_State, index:Int) : String;

    @:native('lua_tothread')
    static function tothread(l:Lua_State, index:Int) : Lua_State;

    @:native('lua_touserdata')
    static function touserdata(l:Lua_State, index:Int) : Void;

    @:native('lua_type')
    static function type(l:Lua_State, index:Int) : Int;

    // @:native('lua_typename')
    @:native('linc::lua::_typename')
    static function typename(l:Lua_State, tp:Int) : String;

	// lua_Writer typedef int (*lua_Writer) (lua_State *L, const void* p, size_t sz, void* ud);

    @:native('lua_xmove')
    static function xmove(from:Lua_State, to:Lua_State, n:Int) : Void;

    @:native('lua_yield')
    static function yield(l:Lua_State, n:Int) : Int;

// The Debug Interface


	// lua_Debug
/*
	typedef struct lua_Debug {
	  int event;
	  const char *name;          
	  const char *namewhat;      
	  const char *what;          
	  const char *source;        
	  int currentline;           
	  int nups;                  
	  int linedefined;           
	  int lastlinedefined;       
	  char short_src[LUA_IDSIZE];
	  other fields
	} lua_Debug;

*/


    // @:native('lua_gethook')
    // static function gethook(l:Lua_State) : lua_Hook;

    @:native('lua_gethookcount')
    static function gethookcount(l:Lua_State) : Int;

    @:native('lua_gethookmask')
    static function gethookmask(l:Lua_State) : Int;

    // @:native('lua_getinfo')
    // static function getinfo(l:Lua_State, what:String, ar:lua_Debug) : Int;

    // @:native('lua_getlocal')
    // static function getlocal(l:Lua_State, ar:lua_Debug, n:Int) : String;

    // @:native('lua_getstack')
    // static function getstack(l:Lua_State, level:Int, ar:lua_Debug) : Int;

    @:native('lua_getupvalue')
    static function getupvalue(l:Lua_State, funcindex:Int, n:Int) : String;

	// lua_Hook typedef void (*lua_Hook) (lua_State *L, lua_Debug *ar);

    // @:native('lua_sethook')
    // static function sethook (l:Lua_State, f:lua_Hook, mask:Int, count:Int) : Int;

    // @:native('lua_setlocal')
    // static function setlocal (l:Lua_State, ar:lua_Debug, n:Int) : String;

    @:native('lua_setupvalue')
    static function setupvalue (l:Lua_State, funcindex:Int, n:Int) : String;


    // unofficial API helpers

    @:native('linc::lua::version')
    static function version() : String;

    @:native('linc::lua::versionJIT')
    static function versionJIT() : String;

    static inline function init_callbacks(l:Lua_State) : Void {
        Lua.callbacks_register(l, "_haxe_callback_handler_", cpp.Callable.fromStaticFunction(Lua_helper.callback_handler));
    }

    @:native('linc::lua::callbacks_register')
    static function callbacks_register(l:Lua_State, name:String, f:cpp.Callable<Lua_State->String->Int>) : Void;

    @:native('linc::lua::add_lua_callback')
    static function add_lua_callback(l:Lua_State, name:String) : Void;

    @:native('linc::lua::remove_lua_callback')
    static function remove_lua_callback(l:Lua_State, name:String) : Void;

    /* thread status */
    public static inline var LUA_OK:Int          = 0;
    public static inline var LUA_YIELD:Int       = 1;
    public static inline var LUA_ERRRUN:Int      = 2;
    public static inline var LUA_ERRSYNTAX:Int   = 3;
    public static inline var LUA_ERRMEM:Int      = 4;
    public static inline var LUA_ERRGCMM:Int     = 5;
    public static inline var LUA_ERRERR:Int      = 6;

    public static inline var LUA_TNONE:Int           = (-1);
    public static inline var LUA_TNIL:Int            = 0;
    public static inline var LUA_TBOOLEAN:Int        = 1;
    public static inline var LUA_TLIGHTUSERDATA:Int  = 2;
    public static inline var LUA_TNUMBER:Int         = 3;
    public static inline var LUA_TSTRING:Int         = 4;
    public static inline var LUA_TTABLE:Int          = 5;
    public static inline var LUA_TFUNCTION:Int       = 6;
    public static inline var LUA_TUSERDATA:Int       = 7;
    public static inline var LUA_TTHREAD:Int         = 8;
    public static inline var LUA_NUMTAGS:Int         = 9;
} //Lua


class Lua_helper {

    public static var callbacks:Map<String, Dynamic> = new Map();

    public static inline function add_callback(l:Lua_State, fname:String, f:Dynamic):Bool {
        callbacks.set(fname, f);
        Lua.add_lua_callback(l, fname);
        return true;
    }

    public static inline function remove_callback(l:Lua_State, fname:String):Bool {
        callbacks.remove(fname);
        Lua.remove_lua_callback(l, fname);
        return true;
    }

    public static inline function callback_handler(l:Lua_State, fname:String):Int {

        var cbf = callbacks.get(fname);

        if(cbf == null) {
            return 0;
        }

        var nparams:Int = Lua.gettop(l);
        var args:haxe.ds.Vector<Dynamic> = new haxe.ds.Vector(nparams);

        for (i in 0...nparams) {
            args[i] = LuaConvert.lua_to_haxe(l, i + 1);
        }

        var ret:Dynamic = null;

        switch (nparams) {
            case 0:
                ret = cbf();
            case 1:
                ret = cbf(args[0]);
            case 2:
                ret = cbf(args[0], args[1]);
            case 3:
                ret = cbf(args[0], args[1], args[2]);
            case 4:
                ret = cbf(args[0], args[1], args[2], args[3]);
            case 5:
                ret = cbf(args[0], args[1], args[2], args[3], args[4]);
            case 6:
                ret = cbf(args[0], args[1], args[2], args[3], args[4], args[5]);
            case 7:
                ret = cbf(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
            default:
                throw("> 7 arguments is not supported");
        }

        if(ret != null){
            LuaConvert.haxe_to_lua(l, ret);
        }

        /* return the number of results */
        return 1;
    } //callback_handler


    public static inline function stackDump(l:Lua_State){
        var top:Int = Lua.gettop(l);
        trace("---------------- Stack Dump ----------------");
        for (i in 1...top) {
            trace( i + " " + LuaConvert.lua_to_haxe(l, i));
        }
        trace("---------------- Stack Dump Finished ----------------");
    }
}


class LuaConvert {

    public static function haxe_to_lua(l:Lua_State, val:Dynamic):Bool {
        switch (Type.typeof(val)) {
            case Type.ValueType.TNull:
                Lua.pushnil(l);
            case Type.ValueType.TBool:
                Lua.pushboolean(l, val);
            case Type.ValueType.TInt:
                Lua.pushinteger(l, cast(val, Int));
            case Type.ValueType.TFloat:
                Lua.pushnumber(l, val);
            case Type.ValueType.TClass(String):
                Lua.pushstring(l, cast(val, String));
            case Type.ValueType.TClass(Array):
                haxe_array_to_lua(l, val);
            case Type.ValueType.TObject:
                haxe_object_to_lua(l, val); // {}
            case Type.ValueType.TFunction:
                trace("TFunction");
            default:
                trace("haxe value not supported\n");
                return false;
        }
        return true;
    }

    static inline function haxe_array_to_lua(l:Lua_State, arr:Array<Dynamic>) {
        var size:Int = arr.length;
        Lua.createtable(l, size, 0);
        for (i in 0...size) {
            Lua.pushnumber(l, i + 1);
            haxe_to_lua(l, arr[i]);
            Lua.settable(l, -3);
        }
    }

    static inline function haxe_object_to_lua(l:Lua_State, res:Dynamic) {
        Lua.createtable(l, 0, 0);
        for (n in Reflect.fields(res)){
            Lua.pushstring(l, n);
            haxe_to_lua(l, Reflect.field(res, n));
            Lua.settable(l, -3);
        }
    }

    public static inline function lua_to_haxe(l:Lua_State, v:Int) {
        // trace("sq_value_to_haxe\n");
        var ret:Dynamic = null;

        switch(Lua.type(l, v)) {
            case Lua.LUA_TNIL:
                ret = null;
            case Lua.LUA_TBOOLEAN:
                ret = Lua.toboolean(l, v) == 0 ? false : true;
            case Lua.LUA_TNUMBER:
                var n:Float = Lua.tonumber(l, v);
                ret = (n % 1) == 0 ? Std.int(n) : n;
            case Lua.LUA_TSTRING:
                ret = Lua.tostring(l, v);
            case Lua.LUA_TTABLE:
                ret = lua_table_to_haxe(l);
            case Lua.LUA_TFUNCTION:
                trace("function\n");
            case Lua.LUA_TUSERDATA:
                trace("userdata\n");
            case Lua.LUA_TTHREAD:
                trace("thread\n");
            case Lua.LUA_TLIGHTUSERDATA:
                trace("lightuserdata\n");
            default:
                trace("return value not supported\n");
        }
        return ret;
    }

    static inline function lua_table_to_haxe(l:Lua_State):Dynamic {
        // trace("\nlua_table_to_haxe");
        var array:Bool = true;
        var ret:Dynamic = null;

        Lua.pushnil(l);
        while(Lua.next(l,-2) != 0) {
            if (Lua.type(l, -2) != Lua.LUA_TNUMBER) {
                array = false;
                Lua.pop(l,2);
                break;
            } 
            Lua.pop(l,1);
        }
        
        if(array){
            var arr:Array<Dynamic> = [];
            Lua.pushnil(l);
            while(Lua.next(l,-2) != 0) {
                var index:Int = Lua.tointeger(l, -2) - 1; // lua has 1 based indices instead of 0
                arr[index] = lua_to_haxe(l, -1);
                Lua.pop(l,1);
            }
            ret = arr;
        } else {
            var obj:Anon_obj = Anon_obj.create(); // {}
            Lua.pushnil(l);
            while(Lua.next(l,-2) != 0) {
                obj.Add(Std.string(lua_to_haxe(l, -2)), lua_to_haxe(l, -1));
                Lua.pop(l,1);
            }
            ret = obj;
        }

        return ret;
    }
    
}

@:include('linc_lua.h') @:native("::cpp::Reference<lua_State>")
extern class Lua_State {}

// Anon_obj from hxcpp
@:include('hxcpp.h')
@:native('hx::Anon')
private extern class Anon {

    @:native('hx::Anon_obj::Create')
    public static function create() : Anon_obj;

    @:native('hx::Anon_obj::Add')
    public function Add(k:String, v:Dynamic):Void;
}
typedef Anon_obj = Anon;