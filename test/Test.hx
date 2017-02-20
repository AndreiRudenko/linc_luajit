import llua.Lua;
import llua.LuaL;
import llua.State;


class Test {
		

	static function main() {

		var vm:State = LuaL.newstate();
		LuaL.openlibs(vm);
		trace("Lua version: " + Lua.version());
		trace("LuaJIT version: " + Lua.versionJIT());

		LuaL.dofile(vm, "script.lua");

		Lua.getglobal(vm, "foo");

		Lua.pushinteger(vm, 1);
		Lua.pushnumber(vm, 2.0);
		Lua.pushstring(vm, "three");

		Lua.pcall(vm, 3, 0, 1);

		Lua.close(vm);

	}


}