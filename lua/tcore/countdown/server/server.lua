local function Shake()
			for k,v in pairs(player.GetAll()) do
				util.ScreenShake(v:GetPos(), math.Rand(0.1,5), math.Rand(1,5), 2, 500)
			end
		end
util.AddNetworkString("TB530Countdown")
function startCountdown(txt,time,cb)
net.Start("TB530Countdown")
net.WriteString("start")
net.WriteString(txt)
net.WriteString(tostring(time))
net.Broadcast()
timer.Simple(time,cb)
timer.Create("shake",1,math.floor(time),Shake)
end
function abortCountdown()
  net.Start("TB530Countdown")
  net.WriteString("abort")
  net.Broadcast()
end


local midnightstart = false
hook.Add("Think","waitformidnight",function()
local date = (os.date("%H:%M:%S",os.time()))
if date == "02:55:00" and midnightstart == false then
midnighstart = true
startCountdown("RESTART SERWERA",300,function()
  midnightstart = false
end)
end
end)

local papyszmidnightstart = false
hook.Add("Think","waitforpapyszmidnight",function()
local date = (os.date("%H:%M:%S",os.time()))
if date == "21:36:50" and papyszmidnightstart == false then
papyszmidnightstart = true
startCountdown("Inbaaa",10,function()
  RunConsoleCommand("ulx","wojenna")
  BroadcastLua("runPapysz()")
  timer.Create("pshake",1/3,0,Shake)
  timer.Simple(60,function()
  timer.Remove("pshake")
  end)
  papyszmidnightstart = false
end)
end
end)
local wojennastart = false
hook.Add("Think","godzinapolicyjna",function()
local date = (os.date("%H:%M:%S",os.time()))
if date == "19:59:00" and wojennastart == false then
wojennastart = true
startCountdown("Wprowadzam Stan Wojenny",60,function()
RunConsoleCommand("ulx","wojenna")
wojennastart = false
end)
end
end)
