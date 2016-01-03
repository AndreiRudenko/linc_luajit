#include "./linc_lua.h"

#include <hxcpp.h>
#include "../lib/lua/src/lua.hpp"

namespace linc {

    namespace lua {

        ::String version(){
        	return ::String(LUA_VERSION);
        }
        ::String versionJIT(){
        	return ::String(LUAJIT_VERSION);
        }

        ::String tostring(lua_State *l, int v){
            return ::String(lua_tostring(l, v));
        }

        ::String tolstring(lua_State *l, int v, size_t *len){
            return ::String(lua_tolstring(l, v, len));
        }

        ::String _typename(lua_State *l, int v){
            return ::String(lua_typename(l, v));
        }

        // callbacks

        static luaCallbackFN event_fn = 0;
        static int luaCallback(lua_State *L){
            // printf("luaCallback!!!");
            return event_fn(L, ::String(lua_tostring(L, lua_upvalueindex(1))));
        }

        void callbacks_register(lua_State *L, const char *name, luaCallbackFN fn){
            event_fn = fn;
        }

        void add_lua_callback(lua_State *L, const char *name){
            my_lua_register(L, name, luaCallback);
        }

        void remove_lua_callback(lua_State *L, const char *name){
            lua_pushnil(L);
            lua_setglobal(L, name);
        }

        void my_lua_register(lua_State *L, const char *name, lua_CFunction f) {
            lua_pushstring(L, name);
            lua_pushcclosure(L, f, 1);
            lua_setglobal(L, name);
        }

    } // lua

} //linc