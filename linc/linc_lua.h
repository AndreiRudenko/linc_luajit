#ifndef _LINC_LUA_H_
#define _LINC_LUA_H_
    
// #include "../lib/____"

#include <hxcpp.h>
#include "../lib/lua/src/lua.hpp"

namespace linc {

    namespace lua {
        extern ::String version();
        extern ::String versionJIT();
        extern ::String tostring(lua_State *l, int v);
        extern ::String tolstring(lua_State *l, int v, size_t *len);
        extern ::String _typename(lua_State *l, int tp);

    } //empty namespace

} //linc

#endif //_LINC_LUA_H_
