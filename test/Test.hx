import lua.Lua;
import lua.LuaL;
import wrapper.LuaWrapper;

class Test {
        
    static function main() {

    	var lua:LuaWrapper = new LuaWrapper();
    	trace(LuaWrapper.version);
    	trace(LuaWrapper.versionJIT);
        lua.executeFile('script.lua');


        trace(lua.execute('return true', true));
        trace(lua.execute('return false', true));
        trace(lua.execute('return 123', true));
        trace(lua.execute('return 12.57', true));
        trace(lua.execute('return "this is string"', true));
        trace(lua.execute('return {1, 3.5, 123, "some string", {754, 12.23, "some string"}}', true));
        trace(lua.execute('return {a = 123, b = "some text", c = 53.67, d = {1,2,3,4}}', true));

        lua.execute('test()'); // cant return function result
        
        trace(lua.call('test', null, true));
        trace(lua.call('test2', 845, true));
        trace(lua.call('test2', {"a" : 423.5}, true));
        trace(lua.call('test2', [12], true));

    	lua.close();
    }

}