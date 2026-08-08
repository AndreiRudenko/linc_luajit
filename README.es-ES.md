

# linc/LuaJIT
Enlaces @:native de Haxe/hxcpp para [LuaJIT](http://luajit.org/).

Esta es una biblioteca de [linc](http://snowkit.github.io/linc/).

---

Esta biblioteca funciona únicamente con el destino cpp de Haxe.

---

### Uso de ejemplo

Consulta test/Test.hx

Asegúrate de leer la documentación de Lua  
www.lua.org/manual/5.1/manual.html  

```haxe
import llua.Lua;
import llua.LuaL;
import llua.State;

class Test {
        
    static function main() {

        var lua:State = LuaL.newstate();
        LuaL.openlibs(lua);
        trace("Lua version: " + Lua.version());
        trace("LuaJIT version: " + Lua.versionJIT());

        LuaL.dofile(lua, "script.lua");

        Lua.getglobal(lua, "foo");

        Lua.pushinteger(lua, 1);
        Lua.pushnumber(lua, 2.0);
        Lua.pushstring(lua, "three");

        Lua.pcall(lua, 3, 0, 1);

        Lua.close(lua);
        
    }

}
```
