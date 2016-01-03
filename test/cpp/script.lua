function test()
	print("calling test() func")
	return "bla bla"
end

function test2(a)
	print("calling test2() func")
	print(a)
	return a
end



local ret = callBack("test callback", 234.54)
print(ret)

print("file script.lua loaded!")
