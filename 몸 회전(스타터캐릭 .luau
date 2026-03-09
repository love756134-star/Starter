local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local MAX_DISTANCE = 200
local BLACK_DISTANCE = 30

local highlights = {}

local function addHighlight(model)
	if not model:FindFirstChild("Humanoid") then return end
	if model == LocalPlayer.Character then return end
	if highlights[model] then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPHighlight"
	highlight.FillTransparency = 0.4
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = model

	highlights[model] = highlight
end

-- 기존 모델 검사
for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("Model") then
		addHighlight(obj)
	end
end

-- 새 모델 검사
workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("Model") then
		task.wait()
		addHighlight(obj)
	end
end)

RunService.RenderStepped:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	for model, highlight in pairs(highlights) do
		if model.Parent then
			local targetRoot = model:FindFirstChild("HumanoidRootPart")
			if targetRoot then

				local dist = (root.Position - targetRoot.Position).Magnitude

				-- 30 스터드 이내 → 검정
				if dist <= BLACK_DISTANCE then
					local color = Color3.new(0.576471, 0.576471, 0.576471)
					highlight.FillColor = color
					highlight.OutlineColor = color
				else
					local t = math.clamp(dist / MAX_DISTANCE, 0, 1)
					local color = Color3.new(1 - t, 0, t)

					highlight.FillColor = color
					highlight.OutlineColor = color
				end

			end
		end
	end
end)
