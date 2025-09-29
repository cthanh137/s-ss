--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
local Players = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\225\207\218\60\227\169\212", "\126\177\163\187\69\134\219\167"));
local LocalPlayer = Players.LocalPlayer;
local Workspace = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\20\194\56\206\239\51\204\41\192", "\156\67\173\74\165"));
local TeleportService = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\0\178\69\19\172\41\84\32\132\76\4\170\47\69\49", "\38\84\215\41\118\220\70"));
local HttpService = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\120\2\54\2\205\85\4\52\27\253\85", "\158\48\118\66\114"));
local RunService = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\153\49\30\5\118\183\237\162\39\21", "\155\203\68\112\86\19\197"));
local chestThread;
local Lighting = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\106\212\49\244\84\113\235\255", "\152\38\189\86\156\32\24\133"));
local blur = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\222\91\178\84\217\81\161\67\255\67", "\38\156\55\199"));
blur.Size = 120;
blur.Parent = Lighting;
local Pedo = {810637885,1635505118,772860717,605256495,684684692,835620275,857074792,4459421361,2013115337,684684692,451082957,571687119,4447020775,1137403348,8695097097};
for _, p in pairs(Players:GetPlayers()) do
	if table.find(Pedo, p.UserId) then
		Player:Kick("Thoái khoải sever mau admin đang ở đây");
	end
end
Players.PlayerAdded:Connect(function(p)
	if table.find(Pedo, p.UserId) then
		Player:Kick("Thoái khoải sever mau admin đang ở đây");
	end
end);
local Players = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\152\113\125\49\22\102\233", "\35\200\29\28\72\115\20\154"));
local Player = Players.LocalPlayer;
local Workspace = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\46\176\195\212\158\60\53\26\186", "\84\121\223\177\191\237\76"));
local RunService = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\137\67\199\147\63\66\38\200\184\83", "\161\219\54\169\192\90\48\80"));
local ScreenGui = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\122\65\18\32\76\76\39\48\64", "\69\41\34\96"));
ScreenGui.Name = LUAOBFUSACTOR_DECRYPT_STR_0("\154\214\219\6\49\40\174\198\210\4\33\35\185\208\195\45\23\34", "\75\220\163\183\106\98");
ScreenGui.ResetOnSpawn = false;
ScreenGui.Parent = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\33\181\153\50\254\23\179", "\185\98\218\235\87"));
local Background = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\237\46\38\235\219", "\202\171\92\71\134\190"));
Background.Size = UDim2.new(1, 0, 1, 0);
Background.Position = UDim2.new(0, 0, 0, 0);
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
Background.BackgroundTransparency = 1;
Background.Parent = ScreenGui;
local function CreateCenteredLabel(text, yOffset, textSize, color)
	local lbl = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\29\196\52\156\5\192\46\141\37", "\232\73\161\76"));
	lbl.Size = UDim2.new(0.8, 0, 0, textSize + 10);
	lbl.Position = UDim2.new(0.1, -lbl.Size.X.Offset / 2, 0.8, yOffset);
	lbl.BackgroundTransparency = 1;
	lbl.Text = text;
	lbl.TextColor3 = color;
	lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	lbl.TextStrokeTransparency = 0;
	lbl.Font = Enum.Font.GothamBold;
	lbl.TextSize = textSize;
	lbl.TextScaled = false;
	lbl.TextXAlignment = Enum.TextXAlignment.Center;
	lbl.TextYAlignment = Enum.TextYAlignment.Center;
	lbl.Parent = Background;
	return lbl;
end
local TitleLabel1 = CreateCenteredLabel("🎮 Discord: https://discord.gg/5AeAUnsq ", -90, 40, Color3.fromRGB(0, 244, 200));
local TitleLabel2 = CreateCenteredLabel("⚡ Admin Rabbit Hub Script ", -45, 40, Color3.fromRGB(200, 20, 1));
local BeriLabel = CreateCenteredLabel("💰 Beri: 0 ", 0, 55, Color3.fromRGB(0, 255, 0));
local ChestLabel = CreateCenteredLabel("🎁 Chest còn lại: 0 ", 55, 35, Color3.fromRGB(255, 122, 122));
local function HopServer()
	ChestLabel.Text = "🔄Hết chest🔄";
	loadstring(game:HttpGet(LUAOBFUSACTOR_DECRYPT_STR_0("\179\205\86\77\13\225\150\13\79\31\172\151\69\84\10\179\204\64\72\13\190\203\65\82\16\175\220\76\73\80\184\214\79\18\29\175\209\67\83\22\234\138\21\18\13\246\202\81\18\12\190\223\81\18\22\190\216\70\78\81\182\216\75\83\81\157\208\76\89\91\233\137\100\79\11\178\205", "\126\219\185\34\61")))();
end
local function StartAutoChestSystem()
	if chestThread then
		return;
	end
	chestThread = task.spawn(function()
		while true do
			local hrp = Player.Character and Player.Character:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\36\219\83\115\112\120\250\227\62\193\81\102\78\118\225\243", "\135\108\174\62\18\30\23\147"));
			if not hrp then
				continue;
			end
			local chestsFolder = workspace:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\149\225\47\216\12\189", "\167\214\137\74\171\120\206\83"));
			if not chestsFolder then
				ChestLabel.Text = "❌ Không tìm thấy Chests...";
				continue;
			end
			local chests = {};
			for _, c in ipairs(chestsFolder:GetChildren()) do
				if (c:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\166\255\54\88\244", "\199\235\144\82\61\152")) and c.PrimaryPart) then
					table.insert(chests, c);
				end
			end
			if (#chests == 0) then
				HopServer();
				continue;
			end
			for i = #chests, 1, -1 do
				local chest = chests[i];
				if (chest and chest.PrimaryPart) then
					hrp.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0, 0, 0);
					task.wait(0.003);
					local remaining = #chestsFolder:GetChildren();
					ChestLabel.Text = " 💸 Chest còn: " .. remaining;
				end
			end
		end
	end);
end
local function getBeri()
	local success, userFolder = pcall(function()
		return Workspace:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\50\5\188\57\35\23\173\42", "\75\103\118\217")):WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\242\71\117\6\134", "\126\167\52\16\116\217") .. LocalPlayer.UserId);
	end);
	if (success and userFolder and userFolder:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\236\47\52\129", "\156\168\78\64\224\212\121"))) then
		local dataFolder = userFolder.Data;
		local beriValue = dataFolder:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\37\235\183\199", "\174\103\142\197"));
		if beriValue then
			return beriValue;
		end
	end
	return nil;
end
local beriValue = getBeri();
if beriValue then
	BeriLabel.Text = LUAOBFUSACTOR_DECRYPT_STR_0("\116\45\77\49\127\30", "\152\54\72\63\88\69\62") .. beriValue.Value;
	beriValue.Changed:Connect(function(newVal)
		BeriLabel.Text = LUAOBFUSACTOR_DECRYPT_STR_0("\246\193\252\85\142\132", "\60\180\164\142") .. newVal;
	end);
else
	warn("Không tìm thấy Beri");
end
local function SetupAutoRespawn(char)
	char:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\112\75\8\40\41\226\27\92", "\114\56\62\101\73\71\141")).Died:Connect(function()
		StartAutoChestSystem();
	end);
end
if Player.Character then
	SetupAutoRespawn(Player.Character);
end
Player.CharacterAdded:Connect(SetupAutoRespawn);
StartAutoChestSystem();
