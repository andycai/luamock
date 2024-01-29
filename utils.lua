local math = math
local string = string
local table = table

local meta = {}

function meta.randseed()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
end

function meta.shuffle(tbl)
	for i = #tbl,1,-1 do
		local j = math.random(1, i)
		local tmp = tbl[i]
		tbl[i] = tbl[j]
		tbl[j] = tmp
	end
end

function meta.split(s, sep)
	local t = {}
	for o in string.gmatch(s, "([^" .. (sep or " ") .. "]+)") do
		table.insert(t, o)
	end

	return t
end

function meta.capitalize(word)
	return word:sub(1,1):upper() .. word:sub(2)
end

function meta.upper(str)
	return str:upper()
end

function meta.pick(tbl)
	return tbl[math.random(1, #tbl)]
end

return meta