local rootDirectory = "leonheartcode"

local function AddFile(File, directory)
    local prefix = string.lower(string.Left(File, 3))

    if SERVER and prefix == "sv_" then
        include(directory .. File)
    elseif prefix == "sh_" then
        if SERVER then
            AddCSLuaFile(directory .. File)
        end

        include(directory .. File)
    elseif prefix == "cl_" then
        if SERVER then
            AddCSLuaFile(directory .. File)
        elseif CLIENT then
            include(directory .. File)
        end
    end
end

local function IncludeDir(directory)
    directory = directory .. "/"
    local files, directories = file.Find(directory .. "*", "LUA")

    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, directory)
            print(v)
        end
    end

    for _, v in ipairs(directories) do
        IncludeDir(directory .. v)
    end
end

IncludeDir(rootDirectory)