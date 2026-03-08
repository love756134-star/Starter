local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")
local Torso = Character:WaitForChild("Torso")

local RootJoint = HRP:WaitForChild("RootJoint")
local Neck = Torso:WaitForChild("Neck")
local RightShoulder = Torso:WaitForChild("Right Shoulder")
local LeftShoulder = Torso:WaitForChild("Left Shoulder")
local RightHip = Torso:WaitForChild("Right Hip")
local LeftHip = Torso:WaitForChild("Left Hip")

local RootJointC0 = RootJoint.C0
local NeckC0 = Neck.C0
local RS_C0 = RightShoulder.C0
local LS_C0 = LeftShoulder.C0
local RH_C0 = RightHip.C0
local LH_C0 = LeftHip.C0

local RJ_Tilt = CFrame.new()
local Neck_Tilt = CFrame.new()
local RS_Tilt = CFrame.new()
local LS_Tilt = CFrame.new()
local RH_Tilt = CFrame.new()
local LH_Tilt = CFrame.new()

local LERP = 0.145
local DOT = 0.9

RunService.Heartbeat:Connect(function()
	local dir = HRP.CFrame:VectorToObjectSpace(Humanoid.MoveDirection)

	-- ===============================
	-- ? 앞으로 (기울기 제거)
	-- ===============================
	if dir:Dot(Vector3.new(0,0,-1)) > DOT then
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.new(), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.new(), LERP)
		RS_Tilt = RS_Tilt:Lerp(CFrame.new(), LERP)
		LS_Tilt = LS_Tilt:Lerp(CFrame.new(), LERP)
		RH_Tilt = RH_Tilt:Lerp(CFrame.new(), LERP)
		LH_Tilt = LH_Tilt:Lerp(CFrame.new(), LERP)

		-- ===============================
		-- ↗ 앞으로 + 오른쪽
		-- ===============================
	elseif dir:Dot(Vector3.new(1,0,-1).Unit) > DOT then
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.Angles(0, 0, math.rad(-dir.X)*25), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.Angles(0, 0, math.rad(dir.X)*15), LERP)

		-- ===============================
		-- ↖ 앞으로 + 왼쪽
		-- ===============================
	elseif dir:Dot(Vector3.new(-1,0,-1).Unit) > DOT then
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.Angles(0, 0, math.rad(-dir.X)*25), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.Angles(0, 0, math.rad(dir.X)*15), LERP)

		-- ===============================
		-- → 오른쪽
		-- ===============================
	elseif dir:Dot(Vector3.new(1,0,0)) > DOT then
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.Angles(0,0,math.rad(-dir.X)*35), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.Angles(0,0,math.rad(dir.X)*35), LERP)

		-- ===============================
		-- ← 왼쪽
		-- ===============================
	elseif dir:Dot(Vector3.new(-1,0,0)) > DOT then
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.Angles(0,0,math.rad(-dir.X)*35), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.Angles(0,0,math.rad(dir.X)*35), LERP)

		-- ===============================
		-- ↓ 뒤
		-- ===============================
	elseif dir:Dot(Vector3.new(0,0,1)) > DOT then
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.Angles(math.rad(-dir.Z)*10,0,0), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.Angles(math.rad(dir.Z)*10,0,0), LERP)

		-- ===============================
		-- 정지
		-- ===============================
	else
		RJ_Tilt = RJ_Tilt:Lerp(CFrame.new(), LERP)
		Neck_Tilt = Neck_Tilt:Lerp(CFrame.new(), LERP)
		RS_Tilt = RS_Tilt:Lerp(CFrame.new(), LERP)
		LS_Tilt = LS_Tilt:Lerp(CFrame.new(), LERP)
		RH_Tilt = RH_Tilt:Lerp(CFrame.new(), LERP)
		LH_Tilt = LH_Tilt:Lerp(CFrame.new(), LERP)
	end

	RootJoint.C0 = RootJointC0 * RJ_Tilt
	Neck.C0 = NeckC0 * Neck_Tilt
	RightShoulder.C0 = RS_C0 * RS_Tilt
	LeftShoulder.C0 = LS_C0 * LS_Tilt
	RightHip.C0 = RH_C0 * RH_Tilt
	LeftHip.C0 = LH_C0 * LH_Tilt
end)
