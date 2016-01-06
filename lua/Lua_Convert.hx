package lua;

import lua.Lua_State;

class Lua_Convert {

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
                return false;
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
            var obj:Anon = Anon.create(); // {}
            Lua.pushnil(l);
            while(Lua.next(l,-2) != 0) {
                obj.add(Std.string(lua_to_haxe(l, -2)), lua_to_haxe(l, -1));
                Lua.pop(l,1);
            }
            ret = obj;
        }

        return ret;
    }
    
}

// Anon_obj from hxcpp
@:include('hxcpp.h')
@:native('hx::Anon')
extern class Anon {

    @:native('hx::Anon_obj::Create')
    public static function create() : Anon;

    @:native('hx::Anon_obj::Add')
    public function add(k:String, v:Dynamic):Void;

}
// typedef Anon_obj = cpp.Pointer<Anon>;

// typedef Anon_obj = Anon;
