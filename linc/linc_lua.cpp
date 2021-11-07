#include <hxcpp.h>
#include <hx/CFFI.h>

#include "./linc_lua.h"
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

        int getstack(lua_State *L, int level, Dynamic ar){

            lua_Debug dbg;

            int ret = lua_getstack(L, level, &dbg);

            ar->__FieldRef(HX_CSTRING("i_ci")) = (int)dbg.i_ci;

            return ret;

        }

        int getinfo(lua_State *L, const char *what, Dynamic ar){

            lua_Debug dbg;

            dbg.i_ci = ar->__FieldRef(HX_CSTRING("i_ci"));

            int ret = lua_getinfo(L, what, &dbg);

            if (strchr(what, 'S')) {

                if (dbg.source != NULL) {
                    ar->__FieldRef(HX_CSTRING("source")) = ::String(dbg.source);
                }

                if (dbg.short_src != NULL) {
                    ar->__FieldRef(HX_CSTRING("short_src")) = ::String(dbg.short_src);
                }

                if (dbg.linedefined != NULL) {
                    ar->__FieldRef(HX_CSTRING("linedefined")) = (int)dbg.linedefined;
                }

                if (dbg.lastlinedefined != NULL) {
                    ar->__FieldRef(HX_CSTRING("lastlinedefined")) = (int)dbg.lastlinedefined;
                }

                if (dbg.what != NULL) {
                    ar->__FieldRef(HX_CSTRING("what")) = ::String(dbg.what);
                }

            }

            if (strchr(what, 'n')) {
                if (dbg.name != NULL) {
                    ar->__FieldRef(HX_CSTRING("name")) = ::String(dbg.name);
                }

                if (dbg.namewhat != NULL) {
                    ar->__FieldRef(HX_CSTRING("namewhat")) = ::String(dbg.namewhat);
                }
            }

            if (strchr(what, 'l')) {
                if (dbg.currentline != NULL) {
                    ar->__FieldRef(HX_CSTRING("currentline")) = (int)dbg.currentline;
                }
            }

            if (strchr(what, 'u')) {
                if (dbg.nups != NULL) {
                    ar->__FieldRef(HX_CSTRING("nups")) = (int)dbg.nups;
                }
            }

            return ret;

        }

    } //lua

    namespace lual {

        ::String checklstring(lua_State *l, int numArg, size_t *len){

            return ::String(luaL_checklstring(l, numArg, len));

        }

        ::String optlstring(lua_State *l, int numArg, const char *def, size_t *len){

            return ::String(luaL_optlstring(l, numArg, def, len));

        }

        ::String prepbuffer(luaL_Buffer *B){

            return ::String(luaL_prepbuffer(B));

        }

        ::String gsub(lua_State *l, const char *s, const char *p, const char *r){

            return ::String(luaL_gsub(l, s, p, r));

        }

        ::String findtable(lua_State *L, int idx, const char *fname, int szhint){

            return ::String(luaL_findtable(L, idx, fname, szhint));

        }

        ::String checkstring(lua_State *L, int n){

            return ::String(luaL_checkstring(L, n));

        }

        ::String optstring(lua_State *L, int n, const char *d){

            return ::String(luaL_optstring(L, n, d));

        }

        ::String ltypename(lua_State *L, int idx){

            return ::String(luaL_typename(L, idx));

        }

    } //lual

    namespace helpers {

        static int onError(lua_State *L) {

            const char *msg = lua_tostring(L, 1);

            if (msg)
                luaL_traceback(L, L, msg, 1);
            else if (!lua_isnoneornil(L, 1)) {  /* is there an error object? */
                if (!luaL_callmeta(L, 1, "__tostring"))  /* try its 'tostring' metamethod */
                    lua_pushliteral(L, "(no error message)");
            }

            return 1;

        }

        int setErrorHandler(lua_State *L){

            lua_pushcfunction(L, onError);
            return 1;

        }


        // haxe trace function

        static HxTraceFN print_fn = 0;
        static int hx_trace(lua_State* L) {

            std::stringstream buffer;
            int n = lua_gettop(L);  /* number of arguments */
            
            lua_getglobal(L,"tostring");
            
            for ( int i = 1;  i <= n;  ++i ){
                const char* s = NULL;
                size_t      l = 0;

                lua_pushvalue(L,-1);    /* function to be called */
                lua_pushvalue(L,i); /* value to print */
                lua_call(L,1,1);

                s = lua_tolstring(L,-1, &l); /* get result */
                if ( s == NULL ){
                    return luaL_error(L,LUA_QL("tostring") " must return a string to " LUA_QL("print"));
                }
                
                if ( i>1 ){
                    buffer << "\t";
                }

                buffer << s;

                lua_pop(L,1);   /* pop result */
            }

            // std::cout << buffer.str(); // c++ out
            print_fn(::String(buffer.str().c_str())); // hx out
            
            return 0;

        }

        static const struct luaL_Reg printlib [] = {

            {"print", hx_trace},
            {NULL, NULL} /* end of array */

        };

        void register_hxtrace_func(HxTraceFN fn){

            print_fn = fn;

        }

        void register_hxtrace_lib(lua_State* L){

            lua_getglobal(L, "_G");
            luaL_register(L, NULL, printlib);
            lua_pop(L, 1);

        }

    } //helpers

    namespace callbacks {
        
        static luaCallbackFN event_fn = 0;
        static int luaCallback(lua_State *L){

            return event_fn(L, ::String(lua_tostring(L, lua_upvalueindex(1))));

        }

        void set_callbacks_function(luaCallbackFN fn){

            event_fn = fn;

        }

        void add_callback_function(lua_State *L, const char *name) {

            lua_pushstring(L, name);
            lua_pushcclosure(L, luaCallback, 1);
            lua_setglobal(L, name);

        }

        void remove_callback_function(lua_State *L, const char *name){

            lua_pushnil(L);
            lua_setglobal(L, name);

        }

    } //callbacks


} //linc
