#ifndef _LINC_LUA_H_
#define _LINC_LUA_H_
    
// #include "../lib/____"

#include <hxcpp.h>
#include "../lib/lua/src/lua.hpp"

namespace linc {

    typedef ::cpp::Function < int(::cpp::Reference<lua_State>, ::String) > luaCallbackFN;

    namespace lua {
        extern ::String version();
        extern ::String versionJIT();
        extern ::String tostring(lua_State *l, int v);
        extern ::String tolstring(lua_State *l, int v, size_t *len);
        extern ::String _typename(lua_State *l, int tp);

        extern luaL_Buffer* buffinit(lua_State *l);




        extern void set_callbacks_function(luaCallbackFN fn);
        extern void add_callback_function(lua_State *L, const char *name);
        extern void remove_callback_function(lua_State *L, const char *name);
        
    } // lua

} //linc

#endif //_LINC_LUA_H_
