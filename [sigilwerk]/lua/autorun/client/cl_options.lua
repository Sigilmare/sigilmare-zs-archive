function SigilmareRules()
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 500)
    frame:SetTitle("")
    frame:Center()
    frame:MakePopup()

    local html = vgui.Create("DHTML", frame)
    html:Dock(FILL)
    html:SetHTML([[<html>
    <head>
        <style>
        body
        {
            font-family:tahoma;
            font-size:12px;
            color:white;
            background-color:black;
        }
        div p
		{
			margin:10px;
			padding:2px;
		}
        </style>
    </head>

    <body>
        <center>
            <span style="color:red;font-size:30px;">Sigilmare Zombie Survival</span>
            <span style="font-size:20px;"><br>Server Rules</span>
            
        </center><br><br><div>]]..SM.Rules..[[</div>
    </body>

    </html>
    ]])
end

function image(url)
    local frame = vgui.Create("DFrame")
    frame:SetSize(500, 500)
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame.Paint = function() end
    timer.Simple(1, function()
        frame:Close()
    end)
    frame:Center()

    local html = vgui.Create("DHTML", frame)
    html:Dock(FILL)
    html:OpenURL(url)

    local html2 = vgui.Create("DPanel", frame)
    html2:Dock(FILL)
    html2.Paint = function() end
end