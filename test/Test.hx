import lua.Lua;
import lua.LuaL;
import wrapper.LuaWrapper;

class Test {
        
    static function main() {

    	var lua:LuaWrapper = new LuaWrapper();
        // Lua_helper.stackDump(lua.vm);

    	trace(LuaWrapper.version);
    	trace(LuaWrapper.versionJIT);


        trace(lua.execute('return true', true));
        trace(lua.execute('return false', true));
        trace(lua.execute('return 123', true));
        trace(lua.execute('return 12.57', true));
        trace(lua.execute('return "this is string"', true));
        trace(lua.execute('return {1, 3.5, 123, "some string", {754, 12.23, "some string"}}', true));
        trace(lua.execute('return {a = 123, b = "some text", c = 53.67, d = {1,2,3,4}}', true));


        // callbacks
        lua.setFunction("callBack", 
            function(a:String, b:Float) {
                trace("callBack function called! : " + a + " " + b);
                return 123;
            }
        );

        lua.doFile('script.lua');
        lua.execute('test()'); // cant return function result
        
        trace(lua.call('test', null, true));
        trace(lua.call('test2', 845, true));
        trace(lua.call('test2', {"a" : 423.5}, true));
        trace(lua.call('test2', [12], true));

        lua.setVar("testvar", 123.765);
        trace(lua.getVar("testvar"));

        // Lua_helper.stackDump(lua.vm);

    	lua.close();
    }

}