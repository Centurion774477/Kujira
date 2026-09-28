#!/usr/bin/env lua

local command = arg[1]
local file = arg[2]
local outputFile = arg[3] or "kujira.css"

if command ~= "scaffold" and command ~= "digest" then
    print("Invalid command: " .. command .. ". Please use either 'scaffold' or 'digest'.")
    os.exit(1)
end

local function writeLine(file_handle, line)
    file_handle:write(line .. "\n")
end

-- parse Kujira into CSS
local function parseLine(file_handle, line)

    -- check if the line is a Kujira verb
    if line:match("^%s*center%s+#") then
        local id = line:match("center #([%a_][%w_]*)")

        if id == nil then
            return
        end

        writeLine(file_handle, "#" .. id .. [[ {
    display: flex;
    flex-direction: column;
    align-items: center;
}   
        ]])
    elseif line:match("%f[%a]text%f[%A]") then
        writeLine(file_handle, "h1, h2, h3, h4, h5, h6, p, a, label, textarea, button, span {")
    elseif line:match("%f[%a]checkbox%f[%A]") then
        writeLine(file_handle, "input[type=\"checkbox\"] {")
    else
        -- let normal CSS fall through
        writeLine(file_handle, line)
    end
end

local function parseFile(file)
    if file == nil then
        print("Please provide a file to parse. Your command should look like: lua kujira.lua digest <file>")
        os.exit(1)
    end

    local fileHandle = io.open(file, "r")


    if not fileHandle then
        print("Error: Could not open file " .. file .. " Are you sure it exists in this context?")
        os.exit(1)
    end

    local outputFileHandle = io.open(outputFile, "w")

    if not outputFileHandle then
        print("Error: Failed to open" .. outputFile .. " for writing.")
        os.exit(1)
    end

    for line in fileHandle:lines() do
        parseLine(outputFileHandle, line)
    end

    io.close(fileHandle)
    io.close(outputFileHandle)

    print("Kujira successfully generated your CSS file titled " .. outputFile .. ".")
end


-- scaffold a .sass file with Kujira features as mixins
local function scaffold(file)

    -- replace extension with .sass if it doesn't already have it
    file = file:gsub("%.[^./\\]+$", "") .. ".sass"

    local fileHandle = io.open(file, "w")

    if not fileHandle then
        print("Error: Could not open file " .. file .. " for writing.")
        os.exit(1)
    end

    fileHandle:write([[
@mixin center
	display: flex
	align-items: center
	justify-content: center

    ]])
    io.close(fileHandle)

    print("Successfully scaffolded your file titled " .. file .. ".")
end

if command == "scaffold" then
    scaffold(file)
elseif command == "digest" then
    parseFile(file)
end


