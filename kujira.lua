
local file = arg[1]
local outputFile = arg[2] or "kujira.css"

if file == nil then
    print("Please provide a file to parse. Your command should look like: lua kujira.lua <file>")
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

local function writeLine(line)
    outputFileHandle:write(line .. "\n")
end

local function parseLine(line)
    -- check if the line is a Kujira verb
    if line:match("center") then
        local id = line:match("center #([%a_][%w_]*)")

        if id == nil then
            return
        end

        writeLine(id .. [[ {
        display: flex;
        flex-direction: column;
        align-items: center;
}   
        ]])
    else
        -- let normal CSS fall through
        writeLine(line)
    end
end

for line in fileHandle:lines() do
    parseLine(line)
end

io.close(fileHandle)
io.close(outputFileHandle)
