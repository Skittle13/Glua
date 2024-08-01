local sv_mats = {
    "egg_icon_939.png",
}

for i, mat in pairs( sv_mats ) do
    resource.AddSingleFile( "materials/scp_collection/" .. mat )
end