HexSh.Amnestic = HexSh.Srcs["src_amnestic"]

if SERVER then 
    AddCSLuaFile("hexsh/src_amnestic/cl_init.lua")
    AddCSLuaFile("hexsh/src_amnestic/sh_config.lua")
    include("hexsh/src_amnestic/sv_init.lua")
    AddCSLuaFile("hexsh/src_amnestic/language/eng.lua")
end

if CLIENT then
    include("hexsh/src_amnestic/cl_init.lua")
end

include("hexsh/src_amnestic/sh_config.lua")
include("hexsh/src_amnestic/language/eng.lua")
 