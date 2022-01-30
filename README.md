# luaphonenumber
Lua 5.1+ bindings for libphonenumber

### Install
Ensure build dependencies are readily available on your system:
* [Google libphonenumber](https://github.com/googlei18n/libphonenumber)
* [ICU library](http://site.icu-project.org/)

```sh
luarocks install luaphonenumber
```

or

```sh
luarocks https://raw.githubusercontent.com/singlecomm/luaphonenumber/master/luaphonenumber-1.0-1.rockspec
```

Typical install outout sample:
```
Using luaphonenumber-1.0-1.rockspec... switching to 'build' mode
Cloning into 'luaphonenumber'...
remote: Enumerating objects: 7, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 7 (delta 0), reused 4 (delta 0), pack-reused 0
Receiving objects: 100% (7/7), done.
Checking connectivity... done.
Warning: variable CFLAGS was not passed in build_variables
g++ -std=c++11 -Wall -fPIC -c luaphonenumber.cpp
g++ -shared -Wl,-soname,luaphonenumber.so.1 -o luaphonenumber.so.1.0 luaphonenumber.o -lphonenumber -lgeocoding
ln -sf luaphonenumber.so.1.0 luaphonenumber.so
ln -sf luaphonenumber.so.1.0 luaphonenumber.so.1
cp luaphonenumber.so* /usr/local/lib/lua/5.1
Updating manifest for /usr/local/lib/luarocks/rocks
No existing manifest. Attempting to rebuild...
luaphonenumber 1.0-1 is now built and installed in /usr/local (license: MIT)
```

### Methods

##### parse( input, country, language, localization_country )

Parses the `input` against the phone numbering schema of the `country` jurisdiction. The results are subsequently localized for the `language` used in `localization_country` area.

```lua
phonenumber = require 'luaphonenumber'

local pn = phonenumber.parse( "+18045551234", "us", "en", "US" )

print( "e164 format: " .. pn.E164 )
print( "rfc3966 format: " .. pn.RFC3966 )
print( "international format: " .. pn.INTERNATIONAL )
print( "national format: " .. pn.NATIONAL )
print( "country: " .. pn.country )
print( "location: " .. pn.location )
print( "line type: " .. pn.type )
```

Output:

```
e164 format: +18045551234
rfc3966 format: tel:+1-804-555-1234
international format: +1 804-555-1234
national format: (804) 555-1234
country: US
location: Virginia
line type: FIXED_LINE_OR_MOBILE
```

##### format( input, country, pattern )

Formats the `input` against the phone numbering schema of the `country` jurisdiction, using one of the following patterns:
* `E164`
* `INTERNATIONAL`
* `NATIONAL`
* `RFC3966`

```lua
phonenumber = require 'luaphonenumber'

print( "e164 format: " .. phonenumber.format( "+18045551234", "us", "E164" ) )
print( "rfc3966 format: " .. phonenumber.format( "+18045551234", "us", "RFC3966" ) )
print( "international format: " .. phonenumber.format( "+18045551234", "us", "INTERNATIONAL" ) )
print( "national format: " .. phonenumber.format( "+18045551234", "us", "NATIONAL" ) )
```

Output:

```
e164 format: +18045551234
rfc3966 format: tel:+1-804-555-1234
international format: +1 804-555-1234
national format: (804) 555-1234
```

##### get_country( input, bias_country )

Returns the country of the `input` with consideration to the `bias_country`.

When providing the `input` in e.164 format, the `bias_country` is effectively ignored. Also, it returns a country code of `ZZ` when it cannot make a proper assessment.

```lua
phonenumber = require 'luaphonenumber'

local input1 = "+18045551234"
local input2 = "8045551234"
local input3 = "+447400555123"
local input4 = "07400555123"

print( "Country of " .. input1 .. ": " .. phonenumber.get_country( input1, "us" ) )
print( "Country of " .. input2 .. ": " .. phonenumber.get_country( input2, "us" ) )
print( "Country of " .. input3 .. ": " .. phonenumber.get_country( input3, "us" ) )
print( "Country of " .. input4 .. ": " .. phonenumber.get_country( input4, "us" ) )
```

Output:

```
Country of +18045551234: US
Country of 8045551234: US
Country of +447400555123: GB
Country of 07400555123: ZZ
```

##### get_location( input, country, language, localization_country )

Returns the region (country subdivision) of the `input` against the phone numbering schema of the `country` jurisdiction. The results are subsequently localized for the `language` used in `localization_country` area.

```lua
phonenumber = require 'luaphonenumber'

local input1 = "+18045551234"
local country1 = "us"
local input2 = "+442085551234"
local country2 = "gb"

print( "Region of " .. input1 .. ": " .. phonenumber.get_location( input1, country1, "en", "US" ) )
print( "Region of " .. input2 .. ": " .. phonenumber.get_location( input2, country2, "en", "US" ) )
```

Output:

```
Region of +18045551234: Virginia
Region of +442085551234: London
```

##### get_type( input, country )

Returns the line type of `input` with consideration to the `country` numbering schema. The returned type can be one of the following:
* `FIXED_LINE `
* `FIXED_LINE_OR_MOBILE `
* `MOBILE `
* `PAGER `
* `PERSONAL_NUMBER `
* `PREMIUM_RATE `
* `SHARED_COST `
* `TOLL_FREE `
* `UAN `
* `UNKNOWN `
* `VOICEMAIL `
* `VOIP `

```lua
phonenumber = require 'luaphonenumber'

local input1 = "+18045551234"
local country1 = "us"
local input2 = "+442085551234"
local country2 = "gb"
local input3 = "+40740555123"
local country3 = "ro"

print( "Type of " .. input1 .. ": " .. phonenumber.get_type( input1, country1 ) )
print( "Type of " .. input2 .. ": " .. phonenumber.get_type( input2, country2 ) )
print( "Type of " .. input3 .. ": " .. phonenumber.get_type( input3, country3 ) )
```

Output:

```
Type of +18045551234: FIXED_LINE_OR_MOBILE
Type of +442085551234: FIXED_LINE
Type of +40740555123: MOBILE
```
