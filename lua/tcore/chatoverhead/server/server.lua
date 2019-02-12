util.AddNetworkString("ChatOnHeadStartChat")
	util.AddNetworkString("ChatOnHeadFinishChat")
	util.AddNetworkString("ChatOnHeadUpdateText")
	net.Receive("ChatOnHeadStartChat",function(_,ply)
	net.Start("ChatOnHeadStartChat")
	net.WriteEntity(ply)
	net.Broadcast()
	end)
	net.Receive("ChatOnHeadFinishChat",function(_,ply)
	net.Start("ChatOnHeadFinishChat")
	net.WriteEntity(ply)
	net.Broadcast()
	end)
	net.Receive("ChatOnHeadUpdateText",function(_,ply)
	net.Start("ChatOnHeadUpdateText")
	local text = net.ReadString()
	hook.Run("ChatUpdateText",ply,text)
	net.WriteEntity(ply)
	net.WriteString(text)
	net.Broadcast()
end)