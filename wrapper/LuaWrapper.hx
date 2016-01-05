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
    	Lua.init_callbacks(vm);
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


	public function setVar(vname:String, v:Dynamic):Void {
		LuaConvert.haxe_to_lua(vm, v);
        Lua.setglobal(vm, vname);
	}

	public function getVar(vname:String):Dynamic {
		Lua.getglobal(vm, vname);
		var ret:Dynamic = LuaConvert.lua_to_haxe(vm, -1);
		if(ret != null) Lua.pop(vm, 1);

		return ret;
	}

	public function setFunction(fname:String, f:Dynamic):Void {
        Lua.register(vm, fname,f);
	}

	public function removeFunction(fname:String):Void {
        Lua_helper.remove_callback(vm, fname);
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
			ret = LuaConvert.lua_to_haxe(vm, -1);


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
	public function doFile(path:String, retVal:Bool = false):Dynamic {
        var ret:Dynamic = null;
        var oldtop:Int = Lua.gettop(vm);
		if(LuaL.dofile(vm, path) != 0){ // (luaL_loadfile(L, filename) || lua_pcall(L, 0, LUA_MULTRET, 0))
			trace("LUA executeFile error : " + Lua.tostring(vm, -1));
		} else if(retVal){
            ret = LuaConvert.lua_to_haxe(vm, -1);
		}

        Lua.settop(vm, oldtop);
		return ret;
	}

	/**
	 * Calls a previously loaded lua function
	 * @param func The lua function name (globals only)
	 * @param args A single argument or array of arguments
	 */
	 
	public function call(func:String, args:Dynamic, retVal:Bool = false):Dynamic {

        var oldtop:Int = Lua.gettop(vm);
        var hv:Dynamic = null;

		Lua.getglobal(vm, func);

        if(args == null){
        	if(Lua.pcall(vm, 0, 1, 0) != 0){
				trace("LUA call error : " + Lua.tostring(vm, -1));
        	} else if(retVal) {
				hv = LuaConvert.lua_to_haxe(vm, -1);
		    }
        } else {
            if(Std.is(args, Array)){
                var nargs:Int = 0;
                var arr:Array<Dynamic>;
                arr = cast args;
                for (a in arr) {
                    if(LuaConvert.haxe_to_lua(vm, a)){
                        nargs++;
                    }
                }
                if(Lua.pcall(vm, nargs, 1, 0) != 0){
					trace("LUA call error : " + Lua.tostring(vm, -1));
	        	} else if(retVal) {
					hv = LuaConvert.lua_to_haxe(vm, -1);
		        }
            } else {
                if(LuaConvert.haxe_to_lua(vm, args)){
                	if(Lua.pcall(vm, 1, 1, 0) != 0){
						trace("LUA call error : " + Lua.tostring(vm, -1));
		        	} else if(retVal) {
						hv = LuaConvert.lua_to_haxe(vm, -1);
		        	}
                } else {
                    trace('LUA call error : unknown type of argument !');
                }
            }
        }

        Lua.settop(vm, oldtop);

        return hv;
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

}

