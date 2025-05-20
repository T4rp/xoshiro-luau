local Xoshiro128PlusPlus = require("./Xoshiro128PlusPlus")

local function testNext()
	print("[START] testNext")

	local s = { 1, 2, 3, 4 }

	assert(Xoshiro128PlusPlus.nextState(s) == 641)
	assert(Xoshiro128PlusPlus.nextState(s) == 1573767)
	assert(Xoshiro128PlusPlus.nextState(s) == 3222811527)

	print("[PASSED] testNext")
end

local function testJump()
	print("[START] testJump")

	local s = { 1, 2, 3, 4 }

	Xoshiro128PlusPlus.jump(s)

	assert(s[1] == 2843103750)
	assert(s[2] == 2038079848)
	assert(s[3] == 1533207345)
	assert(s[4] == 44816753)

	print("[PASSED] testJump")
end

local function testLongJump()
	print("[START] textLongJump")
	local s = { 1, 2, 3, 4 }

	Xoshiro128PlusPlus.longJump(s)

	assert(s[1] == 1611968294)
	assert(s[2] == 2125834322)
	assert(s[3] == 966769569)
	assert(s[4] == 3193880526)

	print("[PASSED] textLongJump")
end

print("Test results:")
print("\n")
testNext()
print("\n")
testJump()
print("\n")
testLongJump()
