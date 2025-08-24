--[[
    @author: 21devx
    @date: 23/08/2025 - 19:30
    @description: Allows users to place parts in front of the camera without needing a viewportframe.
       - Renders Item's in higher resolution,
       - Easier to use,
       - Supports: Models, Parts, Unions, Meshs,
       - Lighweight,
       - Supports Tweens
]]
local CameraObject = {}
CameraObject.__index = CameraObject

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

function CameraObject.Init(Object)
	if Object:IsA("Model") or Object:IsA("BasePart") or Object:IsA("UnionOperation") or Object:IsA("MeshPart") then
		local self = setmetatable({}, CameraObject)
		self.__Object = Object
		self.__Offset = Instance.new("CFrameValue")
		self.__Offset.Value = CFrame.new(0, 0, -5)
		self.__Connection = nil
		return self
	end
end

function CameraObject:Activate()
	if not self.__Connection then
		self.__Connection = RunService.RenderStepped:Connect(function()
			local CurrentCamera = workspace.CurrentCamera
			local TargetCFrame = CurrentCamera.CFrame * self.__Offset.Value

			if self.__Object:IsA("Model") and self.__Object.PrimaryPart then
				self.__Object:SetPrimaryPartCFrame(TargetCFrame)
			elseif self.__Object:IsA("BasePart") or self.__Object:IsA("UnionOperation") or self.__Object:IsA("MeshPart") then
				self.__Object.CFrame = TargetCFrame
			end
		end)
	else
		warn("CameraObject is already active, did you forget to deactivate?")
	end
end

function CameraObject:Deactivate()
	if self.__Connection then
		self.__Connection:Disconnect()
		self.__Connection = nil
	end
end

return CameraObject
