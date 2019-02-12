local weeknumer = 76480
local monthnumer = 79480

local function OpenMonthGui()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,200)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Kupno Cebulacoin")
	frame.Paint = function(_,w,h)
		surface.SetDrawColor(Color(20,20,20,250))
		surface.DrawRect(0,0,w,h)
	end
	local label = vgui.Create("DLabel",frame)
	label:Dock(TOP)
	label:SetFont("Trebuchet24")
	label:SetWrap(true)
	label:SetSize(390,50)
	label:SetContentAlignment(5)
	label:SetText("Aby Kupić 4 miliony cebulacoin wyślij sms o treści MSMS.PLSANDBOX na numer " .. monthnumer)
	local textentry = vgui.Create("DTextEntry",frame)
	textentry:SetSize(130,20)
	textentry:SetPos(120,100)
	textentry:SetPlaceholderText("Wpisz kod z sms tutaj")

	local buybutton = vgui.Create("DButton",frame)
	buybutton:Dock(BOTTOM)
	buybutton:SetText("Kup")
	buybutton.DoClick = function()
net.Start("tb530vipbuy")
net.WriteString(textentry:GetValue())
net.WriteString(tostring(monthnumer))
net.SendToServer()
frame:Remove()
	end
end

local function OpenWeekGui()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,200)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Kupno Cebulacoin")
	frame.Paint = function(_,w,h)
		surface.SetDrawColor(Color(20,20,20,250))
		surface.DrawRect(0,0,w,h)
	end
	local label = vgui.Create("DLabel",frame)
	label:Dock(TOP)
	label:SetFont("Trebuchet24")
	label:SetWrap(true)
	label:SetSize(390,50)
	label:SetContentAlignment(5)
	label:SetText("Aby Kupić 1 milion cebulacoin wyślij sms o treści MSMS.PLSANDBOX na numer " .. weeknumer)
	local textentry = vgui.Create("DTextEntry",frame)
	textentry:SetSize(130,20)
	textentry:SetPos(120,100)
	textentry:SetPlaceholderText("Wpisz kod z sms tutaj")

	local buybutton = vgui.Create("DButton",frame)
	buybutton:Dock(BOTTOM)
	buybutton:SetText("Kup")
	buybutton.DoClick = function()
		net.Start("tb530vipbuy")
		net.WriteString(textentry:GetValue())
		net.WriteString(tostring(weeknumer))
		net.SendToServer()
frame:Remove()
	end
end


function OpenVipGui()
	local frame = vgui.Create("DFrame")
	frame:SetSize(250,100)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Kupno Cebulacoin")
	frame.Paint = function(_,w,h)
		surface.SetDrawColor(Color(20,20,20,250))
		surface.DrawRect(0,0,w,h)
	end
	local label = vgui.Create("DLabel",frame)
	label:Dock(TOP)
	label:SetContentAlignment(5)
	label:SetText("Cebula Coin to system waluty na serwerze, \nza ktora mozesz kupowac rozne rzeczy :)")
	label:SizeToContents()

	local buttbase = vgui.Create("DPanel",frame)
	buttbase.Paint = function() end
	buttbase:Dock(BOTTOM)
	local monthbutt = vgui.Create("DButton",buttbase)
	monthbutt:Dock(LEFT)
	monthbutt:SetText("4Miliony(11.07)")
	monthbutt:SetSize(125,10)
	monthbutt.DoClick = function()
		OpenMonthGui()
		frame:Remove()
	end

	local weekbutt = vgui.Create("DButton",buttbase)
	weekbutt:Dock(LEFT)
	weekbutt:SetText("1 Milion(7.38)")
	weekbutt:SetSize(125,10)
	weekbutt.DoClick = function()
		OpenWeekGui()
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