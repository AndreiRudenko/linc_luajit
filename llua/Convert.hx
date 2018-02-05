package llua;


import llua.State;


class Convert {

	/**
	 * To Lua
	 */
	public static function toLua(l:State, val:Any):Bool {

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
				arrayToLua(l, val);
			case Type.ValueType.TObject:
				objectToLua(l, val); // {}
           // case Type.ValueType.TFunction:
           //     Lua.pushcfunction(l, val);
			default:
				trace("haxe value not supported\n");
				return false;
		}

		return true;

	}

	public static inline function arrayToLua(l:State, arr:Array<Any>) {

		var size:Int = arr.length;
		Lua.createtable(l, size, 0);

		for (i in 0...size) {
			Lua.pushnumber(l, i + 1);
			toLua(l, arr[i]);
			Lua.settable(l, -3);
		}

	}

	static inline function objectToLua(l:State, res:Any) {

		Lua.createtable(l, 0, 0); // TODO: find table length ?
		for (n in Reflect.fields(res)){
			Lua.pushstring(l, n);
			toLua(l, Reflect.field(res, n));
			Lua.settable(l, -3);
		}

	}

	/**
	 * From Lua
	 */
	public static inline function fromLua(l:State, v:Int):Any {

		var ret:Any = null;

		switch(Lua.type(l, v)) {
			case Lua.LUA_TNIL:
				ret = null;
			case Lua.LUA_TBOOLEAN:
				ret = Lua.toboolean(l, v);
			case Lua.LUA_TNUMBER:
				ret = Lua.tonumber(l, v);
			case Lua.LUA_TSTRING:
				ret = Lua.tostring(l, v);
			case Lua.LUA_TTABLE:
				ret = fromLuaTable(l);
			// case Lua.LUA_TFUNCTION:
			// 	ret = LuaL.ref(l, Lua.LUA_REGISTRYINDEX);
			// 	trace("function\n");
			// case Lua.LUA_TUSERDATA:
			// 	ret = LuaL.ref(l, Lua.LUA_REGISTRYINDEX);
			// 	trace("userdata\n");
			// case Lua.LUA_TLIGHTUSERDATA:
			// 	ret = LuaL.ref(l, Lua.LUA_REGISTRYINDEX);
			// 	trace("lightuserdata\n");
			// case Lua.LUA_TTHREAD:
			// 	ret = null;
			// 	trace("thread\n");
			default:
				ret = null;
				trace("return value not supported\n");
		}

		return ret;

	}

	static inline function fromLuaTable(l:State):Any {

		var array:Bool = true;
		var ret:Any = null;

		Lua.pushnil(l);
		while(Lua.next(l,-2) != 0) {

			if (Lua.type(l, -2) != Lua.LUA_TNUMBER) {
				array = false;
				Lua.pop(l,2);
				break;
			} 

			// check this
			var n:Float = Lua.tonumber(l, -2);
			if(n != Std.int(n)){
				array = false;
				Lua.pop(l,2);
				break;
			}
			
			Lua.pop(l,1);
			
		}

		if(array){

			var arr:Array<Any> = [];
			Lua.pushnil(l);
			while(Lua.next(l,-2) != 0) {
				var index:Int = Lua.tointeger(l, -2) - 1; // lua has 1 based indices instead of 0
				arr[index] = fromLua(l, -1); // with holes
				Lua.pop(l,1);
			}
			ret = arr;

		} else {
			
			var obj:Anon = Anon.create(); // {}
			Lua.pushnil(l);
			while(Lua.next(l,-2) != 0) {
				obj.add(Std.string(fromLua(l, -2)), fromLua(l, -1)); // works with mixed tables
				Lua.pop(l,1);
			}
			ret = obj;

		}

		return ret;

	}
	
}


// Anon_obj from hxcpp
//@:include('hxcpp.h')
@:native('hx::Anon')
extern class Anon {

	@:native('hx::Anon_obj::Create')
	public static function create() : Anon;

	@:native('hx::Anon_obj::Add')
	public function add(k:String, v:Any):Void;

}
