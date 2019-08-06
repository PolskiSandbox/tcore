local loaded = {}
if SERVER then
util.AddNetworkString("PlayerFinishedLoading")
net.Receive("PlayerFinishedLoading",function(_,ply)
if table.HasValue(loaded,ply) then return end
table.insert(loaded,ply)
hook.Run("PlayerFinishedLoading",ply)
end)
end
if CLIENT then
hook.Add("HUDPaint","FinishLoadingChecker",function()
hook.Remove("HUDPaint","FinishLoadingChecker")
net.Start("PlayerFinishedLoading")
net.SendToServer()
end)
end