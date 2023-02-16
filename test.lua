phonenumber = require 'luaphonenumber'

-- Test `parse`
local pn = phonenumber.parse( "+18045551234", "us", "en", "US" )
assert(pn.E164 == '+18045551234')
assert(pn.RFC3966 == 'tel:+1-804-555-1234')
assert(pn.INTERNATIONAL == '+1 804-555-1234')
assert(pn.NATIONAL == '(804) 555-1234')
assert(pn.country == 'US')
assert(pn.location == 'Virginia')
assert(pn.type == 'FIXED_LINE_OR_MOBILE')

-- Test `format`
assert(phonenumber.format( "+18045551234", "us", "E164" ) == '+18045551234')
assert(phonenumber.format( "+18045551234", "us", "RFC3966" ) == 'tel:+1-804-555-1234')
assert(phonenumber.format( "+18045551234", "us", "INTERNATIONAL" ) == '+1 804-555-1234')
assert(phonenumber.format( "+18045551234", "us", "NATIONAL" ) == '(804) 555-1234')

-- Test `get_country`
assert(phonenumber.get_country( "+18045551234", "us" ) == 'US')
assert(phonenumber.get_country( "8045551234", "us" ) == 'ZZ')
assert(phonenumber.get_country( "+447400555123", "us" ) == 'GB')
assert(phonenumber.get_country( "07400555123", "us" ) == 'ZZ')

-- Test `get_location`
assert(phonenumber.get_location( "+18045551234", "us", "en", "US" ) == 'Virginia')
assert(phonenumber.get_location( "+442085551234", "gb", "en", "US" ) == 'London')

-- Test `get_type`
assert(phonenumber.get_type( "+18045551234", "us" ) == 'FIXED_LINE_OR_MOBILE')
assert(phonenumber.get_type( "+442085551234", "gb" ) == 'FIXED_LINE')
assert(phonenumber.get_type( "+40740555123", "ro" ) == 'MOBILE')
