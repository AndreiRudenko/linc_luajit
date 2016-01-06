# linc/LuaJIT
Haxe/hxcpp @:native bindings for [LuaJIT](http://luajit.org/).

This is a [linc](http://snowkit.github.io/linc/) library.

---

This library works with the Haxe cpp target only.

---

### Example usage

See test/Test.hx

Be sure to read the Lua documentation  
www.lua.org/manual/5.1/manual.html  

```haxe
import lua.Lua;
import lua.LuaL;
import lua.Lua_State;

class Test {
        
    static function main() {
        var lua:Lua_State = LuaL.newstate();
        LuaL.openlibs(lua);

        LuaL.dofile(lua, "script.lua");

        Lua.getglobal(lua, "foo");

        Lua.pushinteger(lua, 1);
        Lua.pushnumber(lua, 2.0);
        Lua.pushstring(lua, "three");

        Lua.pcall(lua, 3, 0, 0);

        Lua.close(lua);
    }

}
```
