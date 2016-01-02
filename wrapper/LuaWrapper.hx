package wrapper;

import lua.Lua;
import lua.LuaL;

class LuaWrapper {
	public var vm:Lua_State;

	/**
	 * Creates a new lua vm state
	 */
	public function new() {
		vm = LuaL.newstate();
    	LuaL.openlibs(vm);

	}

	public function close() {
		Lua.close(vm);
	}

	/**
	 * Get the version string from Lua
	 */
	public static var version(get, never):String;
	private inline static function get_version():String {
		return Lua.version();
	}

	public static var versionJIT(get, never):String;
	private inline static function get_versionJIT():String {
		return Lua.versionJIT();
	}

	/**
	 * Loads lua libraries (base, debug, io, math, os, package, string, table)
	 * @param libs An array of library names to load
	 */
	public function loadLibs(libs:Array<String>):Void {}

	/**
	 * Defines variables in the lua vars
	 * @param vars An object defining the lua variables to create
	 */
	public function setVars(vars:Dynamic):Void {
		// lua_load_context(vm, vars);
	}

	/**
	 * Runs a lua script
	 * @param script The lua script to run in a string
	 * @return The result from the lua script in Haxe
	 */
	public function execute(script:String, retVal:Bool = false):Dynamic {
		var ret:Dynamic = null;
        var oldtop:Int = Lua.gettop(vm);

		if(LuaL.dostring(vm, script) != 0){
			trace("LUA execute error : " + Lua.tostring(vm, -1));
		} else if(retVal){
			ret = lua_to_haxe(-1);


/*			if(Lua.gettop(vm) > 1){ // for multi return
				var arr:Array<Dynamic> = [];
				var top:Int;
				while ((top = Lua.gettop(vm)) != 0){
					arr.push(lua_to_haxe(top));
					Lua.pop(vm, 1);
				}
				ret = arr;
			} else {
				ret = lua_to_haxe(-1);
			}*/

		}

        Lua.settop(vm, oldtop);

		return ret;
	}
	
	/**
	 * Runs a lua file
	 * @param path The path of the lua file to run
	 * @return The result from the lua script in Haxe
	 */
	public function executeFile(path:String, retVal:Bool = false):Dynamic {
		// return lua_execute(vm, path, true);
		// (luaL_loadfile(L, filename) || lua_pcall(L, 0, LUA_MULTRET, 0))
        var oldtop:Int = Lua.gettop(vm);

		if(LuaL.dofile(vm, path) != 0){
			trace("LUA executeFile error : " + Lua.tostring(vm, -1));
		} else if(retVal){
            return lua_to_haxe(-1);
		}

        Lua.settop(vm, oldtop);
		return null;
	}

	/**
	 * Calls a previously loaded lua function
	 * @param func The lua function name (globals only)
	 * @param args A single argument or array of arguments
	 */
	public function call(func:String, args:Dynamic, retVal:Bool = false):Dynamic {

        var oldtop:Int = Lua.gettop(vm);

		Lua.getglobal(vm, func);

        if(args == null){
        	if(Lua.pcall(vm, 0, 1, 0) != 0){
				trace("LUA call error : " + Lua.tostring(vm, -1));
        	}
        } else {
            if(Std.is(args, Array)){
                var nargs:Int = 0;
                var arr:Array<Dynamic>;
                arr = cast args;
                for (a in arr) {
                    if(haxe_to_lua(a)){
                        nargs++;
                    }
                }
                if(Lua.pcall(vm, nargs, 1, 0) != 0){
					trace("LUA call error : " + Lua.tostring(vm, -1));
	        	}
            } else {
                if(haxe_to_lua(args)){
                	if(Lua.pcall(vm, 1, 1, 0) != 0){
						trace("LUA call error : " + Lua.tostring(vm, -1));
		        	}
                } else {
                    // trace('unknown type!');
                }
            }
        }


        var hv:Dynamic = null;

        if(retVal){
            hv = lua_to_haxe(-1);
        }

        Lua.settop(vm, oldtop);

        return hv;
        // return null;
	}

	/**
	 * Convienient way to run a lua script in Haxe without loading any libraries
	 * @param script The lua script to run in a string
	 * @param vars An object defining the lua variables to create
	 * @return The result from the lua script in Haxe
	 */
	public static function run(script:String, ?vars:Dynamic):Dynamic {
		// var lua = new Lua();
		// lua.setVars(vars);
		// return lua.execute(script);
		return null;
	}
	/**
	 * Convienient way to run a lua file in Haxe without loading any libraries
	 * @param script The path of the lua file to run
	 * @param vars An object defining the lua variables to create
	 * @return The result from the lua script in Haxe
	 */
	public static function runFile(path:String, ?vars:Dynamic):Dynamic {
		// var lua = new Lua();
		// lua.setVars(vars);
		// return lua.executeFile(path);
		return null;
	}
	
	private static function load(func:String, numArgs:Int):Dynamic{
		// return Lib.load("lua", func, numArgs);
		return null;
	}

	function haxe_to_lua(val:Dynamic):Bool {
		switch (Type.typeof(val)) {
            case Type.ValueType.TNull:
                Lua.pushnil(vm);
            case Type.ValueType.TBool:
                Lua.pushboolean(vm, val);
            case Type.ValueType.TInt:
                Lua.pushinteger(vm, cast(val, Int));
            case Type.ValueType.TFloat:
                Lua.pushnumber(vm, val);
            case Type.ValueType.TClass(String):
                Lua.pushstring(vm, cast(val, String));
            case Type.ValueType.TClass(Array):
                haxe_array_to_lua(val);
            case Type.ValueType.TObject:
            	haxe_object_to_lua(val); // {}
            case Type.ValueType.TFunction:
                trace("TFunction");
            default:
                trace("haxe value not supported\n");
                return false;
        }
        return true;
	}

	function haxe_array_to_lua(arr:Array<Dynamic>) {
		var size:Int = arr.length;
		Lua.createtable(vm, size, 0);
		for (i in 0...size) {
			Lua.pushnumber(vm, i + 1);
			haxe_to_lua(arr[i]);
			Lua.settable(vm, -3);
		}
	}

	function haxe_object_to_lua(res:Dynamic) {
		Lua.createtable(vm, 0, 0);
		for (n in Reflect.fields(res)){
			Lua.pushstring(vm, n);
			haxe_to_lua(Reflect.field(res, n));
			Lua.settable(vm, -3);
	    }
	}

    function lua_to_haxe(v:Int) {
        // trace("sq_value_to_haxe\n");
        var ret:Dynamic = null;

        switch(Lua.type(vm, v)) {
            case Lua.LUA_TNIL:
                ret = null;
            case Lua.LUA_TBOOLEAN:
                ret = Lua.toboolean(vm, v) == 0 ? false : true;
            case Lua.LUA_TNUMBER:
            	var n:Float = Lua.tonumber(vm, v);
            	ret = (n % 1) == 0 ? Std.int(n) : n;
            case Lua.LUA_TSTRING:
                ret = Lua.tostring(vm, v);
            case Lua.LUA_TTABLE:
                ret = lua_table_to_haxe();
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

	function lua_table_to_haxe():Dynamic {
		// trace("\nlua_table_to_haxe");
		var array:Bool = true;
		var ret:Dynamic = null;

        Lua.pushnil(vm);
	    while(Lua.next(vm,-2) != 0) {
			if (Lua.type(vm, -2) != Lua.LUA_TNUMBER) {
				array = false;
            	Lua.pop(vm,2);
            	break;
			} 
            Lua.pop(vm,1);
        }
		
        if(array){
			var arr:Array<Dynamic> = [];
	        Lua.pushnil(vm);
	        while(Lua.next(vm,-2) != 0) {
				var index:Int = Lua.tointeger(vm, -2) - 1; // lua has 1 based indices instead of 0
				arr[index] = lua_to_haxe(-1);
	            Lua.pop(vm,1);
	        }
	        ret = arr;
        } else {
        	var obj:Anon_obj = Anon_obj.create(); // {}
	        Lua.pushnil(vm);
	        while(Lua.next(vm,-2) != 0) {
                obj.Add(Std.string(lua_to_haxe(-2)), lua_to_haxe(-1));
	            Lua.pop(vm,1);
	        }
	        ret = obj;
        }

        return ret;
	}

	public function stackDump(){
        var top:Int = Lua.gettop(vm);
        trace("---------------- Stack Dump ----------------");
	    for (i in 0...top) {
        	trace( i + " " + lua_to_haxe(i));
	    }
        trace("---------------- Stack Dump Finished ----------------");
	}

}


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
