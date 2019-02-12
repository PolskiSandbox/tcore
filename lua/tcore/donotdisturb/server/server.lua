local ply = FindMetaTable("Player")
util.AddNetworkString("DoNotDisturb")
util.AddNetworkString("GetWhitelist")
util.AddNetworkString("WHAddPerson")
util.AddNetworkString("WHRemovePerson")

function ply:GetDNDWhitelist()
    local t = util.JSONToTable(self:GetPData("dnd_whitelist","[]"))
    return t
end
function ply:GetDNDAccess(who)
    local wh = self:GetDNDWhitelist()
    local hasAccess = false
    for i,v in pairs(wh) do
        if v[2] == who:SteamID64() then
            hasAccess = true
        end
    end
    return hasAccess
end
net.Receive("WHAddPerson",function(_,who)
    local list = util.JSONToTable(who:GetPData("dnd_whitelist","[]"))
    local target = net.ReadEntity()
    list[target:Name()] = {target:Name(),target:SteamID64()}
    local s = util.TableToJSON(list)
    who:SetPData("dnd_whitelist",s)
end)

net.Receive("WHRemovePerson",function(_,who)
        local list = util.JSONToTable(who:GetPData("dnd_whitelist","[]"))
        --local name = net.ReadString()
        local sid = net.ReadString()
        for i,v in pairs(list) do
            if v[2] == sid then
                list[i] = nil
            end
        end
        local s = util.TableToJSON(list)
        who:SetPData("dnd_whitelist",s)
end)

net.Receive("GetWhitelist",function(_,who)
    local list = util.JSONToTable(who:GetPData("dnd_whitelist","[]"))
    net.Start("GetWhitelist")
    net.WriteTable(list)
    net.Send(who)
end)
function ply:IsDND()
    return self:GetPData("DoNotDisturb",false)
end
net.Receive("DoNotDisturb",function(_,who)
    local toggle = net.ReadBool()
    who:SetPData("DoNotDisturb",toggle)
end)