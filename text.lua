local utils = require('utils')
local base = require('base')
utils.randseed()

local meta = {}

function meta.chsize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end

function meta.utf8len(str)
    local len = 0
    local current = 1
    while current < #str do
        local char = string.byte(str, current)
        current = current + meta.chsize(char)
        len = len + 1
    end
    return len
end

function meta.utf8_len(str)
    local _, count = string.gsub(str, "[^\128-\191]", "")
    return count
end

function meta.utf8sub(str, start, num)
    local startIndex = 1
    while start > 1 do
        local char = string.byte(str, startIndex)
        startIndex = startIndex + meta.chsize(char)
        start = start - 1
    end

    local current = startIndex
    while num > 0 and current <= #str do
        local char = string.byte(str, current)
        current = current + meta.chsize(char)
        num = num - 1
    end
    return str:sub(startIndex, current - 1)
end

function meta.word(min, max)
    min = min or 3
    max = max or 10
    local len = base.natural(min, max)
    local result = ''
    for i = 1, len do
        result = result .. base.char('lower')
    end
    return result
end

function meta.cword(min, max)
    min = min or 1
    max = max or 5
    -- 最常用的 500 个汉字 http://baike.baidu.com/view/568436.htm
    local DICT_KANZI = "的一是在不了有和人这中大为上个国我以要他时来用们生到作地于出就分对成会可主发年动同工也能下过子说产种面而方后多定行学法所民得经十三之进着等部度家电力里如水化高自二理起小物现实加量都两体制机当使点从业本去把性好应开它合还因由其些然前外天政四日那社义事平形相全表间样与关各重新线内数正心反你明看原又么利比或但质气第向道命此变条只没结解问意建月公无系军很情者最立代想已通并提直题党程展五果料象员革位入常文总次品式活设及管特件长求老头基资边流路级少图山统接知较将组见计别她手角期根论运农指几九区强放决西被干做必战先回则任取据处队南给色光门即保治北造百规热领七海口东导器压志世金增争济阶油思术极交受联什认六共权收证改清己美再采转更单风切打白教速花带安场身车例真务具万每目至达走积示议声报斗完类八离华名确才科张信马节话米整空元况今集温传土许步群广石记需段研界拉林律叫且究观越织装影算低持音众书布复容儿须际商非验连断深难近矿千周委素技备半办青省列习响约支般史感劳便团往酸历市克何除消构府称太准精值号率族维划选标写存候毛亲快效斯院查江型眼王按格养易置派层片始却专状育厂京识适属圆包火住调满县局照参红细引听该铁价严龙飞"
    local len = base.natural(min, max)
    local result = ''
    for i = 1, len do
        local pos = base.natural(1, meta.utf8len(DICT_KANZI))
        result = result .. meta.utf8sub(DICT_KANZI, pos, 1)
    end
    return result
end

function meta.title(min, max)
    min = min or 3
    max = max or 8
    local len = base.natural(min, max)
    local result = ''
    for i = 1, len do
        result = result .. utils.capitalize(meta.word()) .. ' '
    end
    return utils.trim(result)
end

function meta.ctitle(min, max)
    min = min or 3
    max = max or 8
    local len = base.natural(min, max)
    local result = ''
    for i = 1, len do
        result = result .. meta.cword() .. ' '
    end
    return utils.trim(result)
end

return meta