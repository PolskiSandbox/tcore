function OpenVipGui()
	local frame = vgui.Create("DFrame")
	frame:SetSize(250,100)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("V.I.P")
	frame.Paint = function(_,w,h)
		surface.SetDrawColor(Color(20,20,20,250))
		surface.DrawRect(0,0,w,h)
	end
	local label = vgui.Create("DLabel",frame)
	label:Dock(TOP)
	label:SetContentAlignment(5)
	label:SetText("Na jak długo chcesz kupić vipa?")
	label:SizeToContents()

	local buttbase = vgui.Create("DPanel",frame)
	buttbase.Paint = function() end
	buttbase:Dock(BOTTOM)
	local monthbutt = vgui.Create("DButton",buttbase)
	monthbutt:Dock(LEFT)
	monthbutt:SetText("Miesiąc (12 zł)")
	monthbutt:SetSize(125,10)
	monthbutt.DoClick = function()
		net.Start("tb530vipbuy")
		net.WriteString("12.00")
		net.SendToServer()
		frame:Remove()
	end

	local weekbutt = vgui.Create("DButton",buttbase)
	weekbutt:Dock(LEFT)
	weekbutt:SetText("Tydzień (5zł)")
	weekbutt:SetSize(125,10)
	weekbutt.DoClick = function()
		net.Start("tb530vipbuy")
		net.WriteString("5.00")
		net.SendToServer()
		frame:Remove()
	end
end
--https://microsms.pl/api/check.php?userid=2190&number=76480&code=c4k7l8u3&serviceid=5210
--OpenVipGui()
net.Receive("tb530vipguiopen",function()
OpenVipGui()
end)
net.Receive("InfoBuyed",function()
local ply = net.ReadEntity()
local much = net.ReadString()
chat.AddText(Color(128,0,255),"[SERVER]",Color(230,230,230)," ",ply:Nick()," kupił ",Color(255,0,0,255),much,"$",Color(255,255,255,255),"!")
end)

net.Receive("tb530vipguiopenurl",function()
	local url = net.ReadString()
	local id = net.ReadString()
	local frame = vgui.Create("DFrame")
	frame.payid = id
	frame:SetSize(250,150)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("V.I.P")
	frame.Paint = function(_,w,h)
		surface.SetDrawColor(Color(20,20,20,250))
		surface.DrawRect(0,0,w,h)
	end
	local label = vgui.Create("DLabel",frame)
	label:Dock(TOP)
	label:SetContentAlignment(5)
	label:SetText("Przygotowano płatność!\nNie zamykaj tego okna!\n(no chyba że zrezygnowałeś)")
	label:SizeToContents()

	local buttbase = vgui.Create("DPanel",frame)
	buttbase.Paint = function() end
	buttbase:Dock(BOTTOM)
	local monthbutt = vgui.Create("DButton",buttbase)
	monthbutt:Dock(LEFT)
	monthbutt:SetText("Zapłać")
	monthbutt:SetSize(125,10)
	monthbutt.DoClick = function()
		gui.OpenURL(url)
	end
	local weekbutt = vgui.Create("DButton",buttbase)
	weekbutt:Dock(LEFT)
	weekbutt:SetText("Sprawdź")
	weekbutt:SetSize(125,10)
	weekbutt.DoClick = function()
		net.Start("tb530vipcheck")
		net.WriteString(frame.payid)
		net.SendToServer()
	end
end)
