local basic = require('basic')
local address = require('address')
local date = require('date')

local meta = {}

--[==[
随机生成一个 GUID。
http://www.broofa.com/2008/09/javascript-uuid-function/
[UUID 规范](http://www.ietf.org/rfc/rfc4122.txt)
    UUIDs (Universally Unique IDentifier)
    GUIDs (Globally Unique IDentifier)
    The formal definition of the UUID string representation is provided by the following ABNF [7]:
        UUID                   = time-low "-" time-mid "-"
                                time-high-and-version "-"
                                clock-seq-and-reserved
                                clock-seq-low "-" node
        time-low               = 4hexOctet
        time-mid               = 2hexOctet
        time-high-and-version  = 2hexOctet
        clock-seq-and-reserved = hexOctet
        clock-seq-low          = hexOctet
        node                   = 6hexOctet
        hexOctet               = hexDigit hexDigit
        hexDigit =
            "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9" /
            "a" / "b" / "c" / "d" / "e" / "f" /
            "A" / "B" / "C" / "D" / "E" / "F"

https://github.com/victorquinn/chancejs/blob/develop/chance.js#L1349
--]==]
function meta.GUID()
    local pool = 'abcdefABCDEF1234567890'
    local guid = basic.string(pool, 8) .. '-' ..
          basic.string(pool, 4) .. '-' ..
          basic.string(pool, 4) .. '-' ..
          basic.string(pool, 4) .. '-' ..
          basic.string(pool, 12)
    return guid
end

function meta.UUID()
    return meta.GUID()
end

--[==[
随机生成一个 18 位身份证。
[身份证](http://baike.baidu.com/view/1697.htm#4)
地址码 6 + 出生日期码 8 + 顺序码 3 + 校验码 1
[《中华人民共和国行政区划代码》国家标准(GB/T2260)](http://zhidao.baidu.com/question/1954561.html)
--]==]
function meta.ID()
    local id = ''
    local sum = 0
    local rank = {
        "7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"
    }
    local last = {
        "1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"
    }
    id = address.countyId() .. date.date('yyyyMMdd') .. basic.string('number', 3)
    for i = 1, #id do
        -- print(id:sub(i, i) .. ", " .. rank[i])
        sum = sum + (tonumber(id:sub(i, i)) * tonumber(rank[i]))
    end
    -- print("sum:" .. tostring(sum))
    id = id .. last[(sum % 11)+1]

    return id
end

local _incr
local function increment()
    local total = 0
    return function(step)
        total = total + (step or 1)
        return total
    end
end

function meta.incr(step)
    step = step or 1
    if _incr == nil then
        _incr = increment()
    end
    return _incr(step)
end

return meta