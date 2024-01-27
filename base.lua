require('init')

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
    if min < 0 then
        min = 0
    end
    if max <= 0 then
        max = 2^16
    end
    return math.random(min, max)
end

function meta.int(min, max)
    if max <= 0 or max <= min then
        min = -2^16
        max = 2^16
    end
    return math.random(min, max)
end

-- print(meta.bool())
-- print(meta.natural(10, 20))
-- print(meta.natural(-10, 200))
-- print(meta.int(10, 20))
-- print(meta.int(10, 2))

return meta