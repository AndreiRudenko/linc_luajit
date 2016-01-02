#include "./linc_lua.h"

#include <hxcpp.h>
#include "../lib/lua/src/lua.hpp"

namespace linc {

    namespace lua {

        // int version(){
        // 	return LUA_VERSION_NUM;
        // }
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

    } //empty namespace

} //linc