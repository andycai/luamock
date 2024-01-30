local utils = require('utils')
local base = require('base')
utils.randseed()

local meta = {}

local formats = {
    yyyy = '%%Y',
    MM = '%%m',
    dd = '%%d',
    HH = '%%H',
    mm = '%%M',
    ss = '%%S'
}

local function replace_fmt(fmt)
    -- fmt = fmt:gsub('%w+', formats)
    for key, value in pairs(formats) do
        fmt = fmt:gsub(key, value)
    end
    return fmt
end

local function data_format(date, fmt)
    if type(date) == "string" or type(date) == "table" then
        -- date = os.date("*t", os.time(date))
        date = os.time(date)
    elseif type(date) ~= "number" then
        return ""
    end
    fmt = replace_fmt(fmt)
    return os.date(fmt, date)
end

local function rand_date()
    local year = base.natural(1970, tonumber(os.date("%Y", os.time())))
    local month = base.natural(1, 12)
    local days_in_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    if month == 2 and year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0) then
        days_in_month[2] = 29
    end
    local day = days_in_month[month]
    return {
        year = year,
        month = month,
        day = day,
        hour = base.int(0, 23),
        min = base.int(0, 59),
        sec = base.int(0, 59)
    }
end

function meta.date(fmt)
    fmt = fmt or 'yyyy-MM-dd'
    return data_format(rand_date(), fmt)
end

function meta.time(fmt)
    fmt = fmt or 'HH:mm:ss'
    return data_format(rand_date(), fmt)
end

function meta.datetime(fmt)
    fmt = fmt or 'yyyy-MM-dd HH:mm:ss'
    return data_format(rand_date(), fmt)
end

function meta.now(fmt)
    fmt = fmt or 'yyyy-MM-dd HH:mm:ss'
    return data_format(os.time(), fmt)
end

return meta