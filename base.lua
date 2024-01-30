local utils = require('utils')
utils.randseed()

local meta = {}

local constant = {
    '0','1','2','3','4','5','6','7','8','9',
    'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
    '!','@', '#', '$', '%', '^', '&', '*', '(', ')', '[', ']'
}

function meta.bool()
    return math.random(1, 10) > 5
end

function meta.natural(min, max)
    min = min or 0
    max = max or (2^16)
    return math.random(min, max)
end

function meta.int(min, max)
    if max <= 0 or max <= min then
        min = -2^16
        max = 2^16
    end
    return math.random(min, max)
end

function meta.char(type)
    local c = ''
    if type == nil then
        type = 'alpha'
    end
    if type == 'all' then
        c = constant[math.random(1, 74)]
    elseif type == 'alpha' then
        c = constant[math.random(11, 62)]
    elseif type == 'lower' then
        c = constant[math.random(11, 36)]
    elseif type == 'upper' then
        c = constant[math.random(37, 62)]
    elseif type == 'number' then
        c = constant[math.random(1, 10)]
    elseif type == 'symbol' then
        c = constant[math.random(63, 74)]
    else
        local len = #type
        local i = math.random(1, len)
        c = string.sub(type, i, i)
    end 
    return c
end

function meta.string(pool, min, max)
    local len = 0
    if max == nil then
        len = min
    else
        len = math.random(min, max)
    end
    local str = ''
    for i = 1, len do
        str = str .. meta.char(pool)
    end
    return str
end

function meta.range(start, stop, step)
    start = start or 0
    if stop <= start then
        stop = start + 5
    end
    if step == nil then
        step = 1
    end
    local range = {}
    for i = start, stop, step do
        range[#range + 1] = i
    end
    return range
end

return meta