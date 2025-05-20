local JUMP = { 0x8764000b, 0xf542d2d3, 0x6fa035c3, 0x77f2db5b }
local LONG_JUMP = { 0xb523952e, 0x0b6f099f, 0xccf5a0ef, 0x1c580662 }

local function nextState(s)
	local result = (bit32.lrotate((s[1] + s[4]) % 2 ^ 32, 7) + s[1]) % 2 ^ 32
	local t = bit32.lshift(s[2], 9)

	s[3] = bit32.bxor(s[3], s[1])
	s[4] = bit32.bxor(s[4], s[2])
	s[2] = bit32.bxor(s[2], s[3])
	s[1] = bit32.bxor(s[1], s[4])

	s[3] = bit32.bxor(s[3], t)

	s[4] = bit32.lrotate(s[4], 11)

	return result
end

local function jump(s)
	local s1 = 0
	local s2 = 0
	local s3 = 0
	local s4 = 0

	for _, j in JUMP do
		for b = 0, 31 do
			if bit32.band(j, bit32.lshift(1, b)) ~= 0 then
				s1 = bit32.bxor(s1, s[1])
				s2 = bit32.bxor(s2, s[2])
				s3 = bit32.bxor(s3, s[3])
				s4 = bit32.bxor(s4, s[4])
			end
			nextState(s)
		end
	end

	s[1] = s1
	s[2] = s2
	s[3] = s3
	s[4] = s4
end

local function longJump(s)
	local s1 = 0
	local s2 = 0
	local s3 = 0
	local s4 = 0

	for _, j in LONG_JUMP do
		for b = 0, 31 do
			if bit32.band(j, bit32.lshift(1, b)) ~= 0 then
				s1 = bit32.bxor(s1, s[1])
				s2 = bit32.bxor(s2, s[2])
				s3 = bit32.bxor(s3, s[3])
				s4 = bit32.bxor(s4, s[4])
			end
			nextState(s)
		end
	end

	s[1] = s1
	s[2] = s2
	s[3] = s3
	s[4] = s4
end

return {
	nextState = nextState,
	jump = jump,
	longJump = longJump,
}
