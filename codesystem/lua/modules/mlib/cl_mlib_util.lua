////////////////////////////////////////
//         Maax´s Libary (MLIB)       //
//          Coded by: Maax            //
//                                    //
//      Version: v1.0 (Workshop)      //
//                                    //
//      You are not permitted to      //
//        reupload this Script!       //
//                                    //
////////////////////////////////////////


function MLIB:BroadcastPrint(type, header, text_)
    MsgC( type, "[MLIB - "..header.. "] ", Color(255,255,255), text_ ,"\n")
end

function MLIB:ChatPrint(type, header, text)
  chat.AddText( type , "[MLIB - "..header.."] ",Color(255,255,255), text)
end
