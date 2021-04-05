wait(0.5); if _G.AutoArrest == false or game.PlaceId ~= 2788229376 then return end
local Plr
function serverhop()
    print("PENIS")
    pcall(function()
	    Plr.Character:Destroy()
	    repeat wait() until Plr.Character
    end)
    Plr:Kick("Rejoining...")
    
	while wait(5) do
	    local x = {}
	    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId and v.maxPlayers-10 < v.playing then
			    x[#x + 1] = v.id
        	end
	    end
    	if #x > 0 then
    		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
    	end
    end
end

spawn(function()
    wait(300)
    serverhop()
end)
local insults = {
    "xretardxx",
    "nice forhead!"
}
--//handling
repeat wait() until game.Players.LocalPlayer
Plr = game.Players.LocalPlayer

repeat wait() until Plr.Character and Plr.Character:FindFirstChild("FULLY_LOADED_CHAR")
spawn(function()
    local arm = Plr.Character:WaitForChild("BodyEffects"):WaitForChild("Armor")
    arm:Clone().Parent = arm.Parent
    arm:Destroy()
end)
wait(5)
if not Plr.Backpack:FindFirstChild("Cuff") and not Plr.Character:FindFirstChild("Cuff") then
    local p = game.Workspace.Ignored["Join/Leave"]
    Plr.Character:MoveTo(p.Head.Position)
    wait(2)
    fireclickdetector(p.ClickDetector)
end
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(e, i, ...)
    if i == "TeleportDetect" then
        return wait(1e9)
    end
    return old(e, i, ...)
end)
setreadonly(mt, true)
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
local m = {}

if not isfile("arrestlog.txt") then
    writefile("arrestlog.txt", '--START OF LOG--')
end

for i, v in next, game.Workspace:GetDescendants() do
	if v:IsA("Seat") then
		v:Destroy()
	end
end

game:GetService("RunService").Stepped:connect(function()
    Plr.Character.Humanoid:ChangeState(11)
    if Plr.Character.BodyEffects["K.O"].Value then
        Plr.Character:Destroy()
    end
end)
wait()
local c
Plr.CharacterAdded:Connect(serverhop)
c = Instance.new("BodyPosition", Plr.Character.RightHand)
c.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
c.P = 9e5
local target
while wait() do
    target = nil
    local highest = 0
    for i, v in pairs(game.Players:GetPlayers()) do
        if v:FindFirstChild("DataFolder") and v.Character:FindFirstChild("FULLY_LOADED_CHAR") and (v.Character.BodyEffects:FindFirstChild("Defense") or not v.Character.BodyEffects:FindFirstChild("Block")) and tonumber(v.DataFolder.Information.Wanted.Value) > 1000 and tonumber(v.DataFolder.Information.Wanted.Value) >= highest then
            target = v 
            highest = tonumber(v.DataFolder.Information.Wanted.Value)
        end
    end
    if not target then serverhop() end
    local e = true
    local hand = Plr.Character.RightHand
    if not hand then serverhop() end
    local Time = os.time()
    spawn(function()
        pcall(function() hand:FindFirstChild("RightWrist"):Destroy() end)
        game.Workspace.CurrentCamera.CameraSubject = hand;
        hand.Size = Vector3.new(1, 1, 1)
        while e and target and target.Character and target.Parent ~= nil do game.RunService.Stepped:wait()
            pcall(function()
                if Plr.Character.Humanoid.Health > 80 then
                    c.Position = target.Character.UpperTorso.Position
                    if target.Character.BodyEffects["K.O"].Value then
                        Plr.Character.HumanoidRootPart.CFrame = target.Character.UpperTorso.CFrame
                    else
                        Plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
                    end
                else
                    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
                    c.Position = Vector3.new(0, 999, 0)
                    if Plr.Character:FindFirstChild("[Chicken]") == nil and Plr.Backpack:FindFirstChild("[Chicken]") == nil then
                        Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Chicken] - $7"].Head.CFrame
                        wait(0.5)
                        fireclickdetector(game.Workspace.Ignored.Shop["[Chicken] - $7"].ClickDetector)
                    end
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Chicken]"])end)
                    pcall(function()
                        Plr.Character["[Chicken]"]:Activate()
                        wait(0.1)
                        Plr.Character["[Chicken]"]:Deactivate()
                    end)
                end
            end)
        end
    end)
    repeat wait()
        pcall(function()
            if Plr.Character.Humanoid.Health > 80 then
                c.Parent.Anchored = true
                c.Parent.Anchored = false
                if target.Character.BodyEffects["K.O"].Value then
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack.Cuff)end)
                    pcall(function()
                        Plr.Character.Cuff:Activate()
                        wait(0.1)
                        Plr.Character.Cuff:Deactivate()
                    end)
                else
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack.Combat)end)
                    wait(0.1)
                    Plr.Character.Combat:Activate()
                    wait(2)
                    pcall(function() firetouchinterest(hand, target.UpperTorso, 0) end)
                    Plr.Character.Combat:Deactivate()
                    wait(1)
                end
            end
        end)  
    until tonumber(target.DataFolder.Information.Wanted.Value) == 0 or not (target and target.Character and target.Parent ~= nil) or not target.Character:FindFirstChild("FULLY_LOADED_CHAR") or (not target.Character.BodyEffects:FindFirstChild("Defense") and target.Character.BodyEffects:FindFirstChild("Block"))
    pcall(function()
        if target ~= nil and not m[tostring(target)] and tonumber(target.DataFolder.Information.Wanted.Value) == 0 then
            m[tostring(target)] = true
            appendfile("arrestlog.txt", "\nuser:"..tostring(target).." | time: "..tostring(os.time()-Time).." Seconds | Bounty: "..tostring(highest))
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("thanks for the "..tostring(highest).." bounty, "..tostring(target).." ("..insults[math.random(1, #insults)]..")", "All")
        end
    end)
    e = false
end
serverhop()
