local name = require('name')
print(name.firstname())
print(name.lastname())
print(name.fullname(true))
print(name.cfirstname())
print(name.clastname())
print(name.cfullname())
print(name.cfullname())

local base = require('base')
print(base.bool())
print(base.natural(10, 20))
print(base.natural(-10, 200))
print(base.int(10, 20))
print(base.int(10, 2))
print(base.char('all'))
print(base.char())
print(base.char('ab@#$%^&*cdefghijk'))
print(base.string('ab@#$%^&*cdefghijk', 3, 6))

local address = require('address')
print(address.region())
print(address.zip())
print(address.province())
print(address.city())
print(address.city(true))
print(address.county())
print(address.county(true))
print(address.countyId())

local text = require('text')
print(text.word())
print(text.cword())

local web = require('web')
print(web.TLD())
print(web.IP())