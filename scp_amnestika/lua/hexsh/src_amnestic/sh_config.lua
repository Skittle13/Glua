HexSh.Config["src_amnestic"] = {
    AMNESTICLEVELS = {
        ["A"] = {
            name = "A",
            time = 15, -- in seconds 
            message = "Du vergisst alles, was in den letzten 12 Stunden passiert ist.",
            -- I recommend you of keeping it like that, but you can change it if you want. Just test around. 
            BlurIntensity = { AddAlpha =0.05, DrawAlpha=0.95, Delay=0.01},
            color = Color(0, 255, 38),
            Restriction = {
                ["Citizen"] = true,
                ["Allgemeinmediziner"] = true,
                ["Psychiater"] = true,
                ["Feldsanitäter"] = true,
                ["ISD"] = true,
                ["Ethikkommission"] = true,
            }
        },

        ["B"] = {
            name = "B",
            time = 20, -- in seconds 
            message = "Du vergisst alles, was in den letzten 20 bis 72 Stunden passiert ist.",
            -- I recommend you of keeping it like that, but you can change it if you want. Just test around. 
            BlurIntensity = { AddAlpha =0.05, DrawAlpha=0.95, Delay=0.01},
            color = Color(30, 122, 54),
            Restriction = {
                ["Citizen"] = true,
                ["Allgemeinmediziner"] = true,
                ["Psychiater"] = true,
                ["Feldsanitäter"] = true,
                ["ISD"] = true,
                ["Ethikkommission"] = true,
            }
        }, 

        ["C"] = {
            name = "C",
            time = 20, -- in seconds 
            message = "Du vergisst alles, was in den letzten 4 bis 9 Tagen passiert ist.",
            -- I recommend you of keeping it like that, but you can change it if you want. Just test around. 
            BlurIntensity = { AddAlpha =0.05, DrawAlpha=0.95, Delay=0.01}, 
            color = Color(255, 247, 0),
            Restriction = {
                ["Citizen"] = true,
                ["ISD"] = true,
                ["Ethikkommission"] = true,
            }
        }, 

        ["D"] = {
            name = "D",
            time = 20, -- in seconds 
            message = "Du vergisst alles, was in den letzten 3 wochen passiert ist.",
            -- I recommend you of keeping it like that, but you can change it if you want. Just test around. 
            BlurIntensity = { AddAlpha =0.05, DrawAlpha=0.95, Delay=0.01}, 
            color = Color(255, 174, 0),
            Restriction = {
                ["Citizen"] = true,
                ["ISD"] = true,
                ["Ethikkommission"] = true,
            }
        },
        
        ["E"] = {
            name = "E",
            time = 20, -- in seconds 
            message = "Du vergisst alles",
            -- I recommend you of keeping it like that, but you can change it if you want. Just test around. 
            BlurIntensity = { AddAlpha =0.05, DrawAlpha=0.95, Delay=0.01}, 
            color = Color(162, 20, 20),
            Restriction = {
                ["Citizen"] = true,
                ["Ethikkommission"] = true,
            }
        }, 
    }
}