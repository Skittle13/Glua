local MODULE = GAS.Logging:MODULE();

MODULE.Category = "Amnestics"
MODULE.Name = "injected"
MODULE.Colour = Color(161,16,166) 

MODULE:Setup( function()
    MODULE:Hook( "HexAmnestics::Injected", "HexAmnestics::Injected", function( ply, target, typ)
        MODULE:Log( "Player("..ply:Nick()..") ➞ injected amnestic with tpye("..typ.." in "..target:Nick()..")" )
    end );
end );

GAS.Logging:AddModule( MODULE );