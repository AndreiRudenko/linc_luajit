#pragma once

#include <hxcpp.h>
#include <hx/CFFI.h>

#include <sstream>
#include <iostream>

#include "../lib/lua/src/lua.hpp"

namespace linc {

    typedef ::cpp::Function < int(::cpp::Reference<lua_State>, ::String) > luaCallbackFN;
    // typedef ::cpp::Function < int(::cpp::Pointer<lua_State>, ::String) > luaCallbackFN;
    typedef ::cpp::Function < int(String) > HxTraceFN;

    namespace lua {

        extern ::String version();
        extern ::String versionJIT();
        extern ::String tostring(lua_State *l, int v);
        extern ::String tolstring(lua_State *l, int v, size_t *len);
        extern ::String _typename(lua_State *l, int tp);

        extern int getstack(lua_State *L, int level, Dynamic ar);
        extern int getinfo(lua_State *L, const char *what, Dynamic ar);

    } // lua

    namespace lual {

        extern ::String checklstring(lua_State *l, int numArg, size_t *len);
        extern ::String optlstring(lua_State *L, int numArg, const char *def, size_t *l);
        extern ::String prepbuffer(luaL_Buffer *B);
        extern ::String gsub(lua_State *l, const char *s, const char *p, const char *r);
        extern ::String findtable(lua_State *L, int idx, const char *fname, int szhint);
        extern ::String checkstring(lua_State *L, int n);
        extern ::String optstring(lua_State *L, int n, const char *d);
        extern ::String ltypename(lua_State *L, int idx);

    }

    namespace helpers {

        extern int setErrorHandler(lua_State *L);
        extern void register_hxtrace_func(HxTraceFN fn);
        extern void register_hxtrace_lib(lua_State* L);

    }

    namespace callbacks {

        extern void set_callbacks_function(luaCallbackFN fn);
        extern void add_callback_function(lua_State *L, const char *name);
        extern void remove_callback_function(lua_State *L, const char *name);
        
    }


} //linc
