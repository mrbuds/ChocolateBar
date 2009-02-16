local ChocolateBar = LibStub("AceAddon-3.0"):GetAddon("ChocolateBar")
local Drag = ChocolateBar.Drag
local frameslist = {}
local Debug = ChocolateBar.Debug
local DragUpdate = CreateFrame("Frame")

local counter = 0
local delay = .2
local focus = nil
local choconame

local function ChangeFocus(newfocus)
	if focus.LoseFocus then
		focus:LoseFocus(choconame)
	end
	newfocus:Drag(choconame)
	focus = newfocus
end

local function MouseIsOver(frame)
  local x, y = GetCursorPosition();
  local s = frame:GetEffectiveScale();
  x, y = x/s, y/s;
  return ((x >= frame:GetLeft()) and (x <= frame:GetRight())
          and (y >= frame:GetBottom()) and (y <= frame:GetTop()));
end

local function GetFocus()
	for k, v in pairs(frameslist) do
		if MouseIsOver(v) then
			if focus ~= v then
				ChangeFocus(v)
			end
		end
	end
	if focus.UpdateDragChocolate then
		focus:UpdateDragChocolate()
	end
	return focus
end

local function OnDragUpdate(frame, elapsed)
	counter = counter + elapsed
	if counter >= delay then
		GetFocus()
		counter = 0
	end
	
end

function Drag:RegisterFrame(frame)
	local name = frame:GetName()
	if name and not frameslist[naem] then
		frameslist[name] = frame
	else
		Debug("Drag:RegisterFrame(frame) no name or already registred")
	end
end

function Drag:UnregisterFrame(frame)
end

function Drag:Start(bar, name)
	for k, v in pairs(frameslist) do
		v.dragshow = v:IsVisible() 
		v:Show()
	end
	choconame = name
	bar:Drag(name)
	focus = bar
	DragUpdate:SetScript("OnUpdate", OnDragUpdate)
end

function Drag:Stop(frame)
	for k, v in pairs(frameslist) do
		if not v.dragshow then
			v:Hide()
		end
	end
	DragUpdate:SetScript("OnUpdate", nil)
	focus:Drop(frame)
end

