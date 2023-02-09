--# selene: allow(undefined_variable) --Making an exception here so Selene doesn't complain about 'remodel' global variable
--[[
	This script pulls assets from a Roblox place file and stores them in the repository assets folder for use in a rojo fully managed workflow.
	This script does NOT run inside of Roblox Studio and is using normal Lua instead of Roblox's Luau. As a result, old keywords like ipairs and pairs
	must be used when iterating over arrays and new keywords such as 'continue' do not exist.

	The script is run by 'remodel' in the command line and does not have the full Roblox Lua API although it does contain the following
	commands to make it easier to use.

	Instance.new(className) --(0.5.0+) The second argument (parent) is not supported by Remodel.
	<Instance>.Name (read + write)
	<Instance>.ClassName (read only)
	<Instance>.Parent read + write)
	<Instance>:Destroy() (0.5.0+)
	<Instance>:Clone() (0.6.0+)
	<Instance>:GetChildren()
	<Instance>:GetDescendants() (0.8.0+)
	<Instance>:FindFirstChild(name) --The second argument (recursive) is not supported by Remodel.
	<DataModel>:GetService(name)
]]

local game = remodel.readPlaceFile("places/development.rbxlx")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local replicatedStorageContainers = {
	ReplicatedStorage.Rigs,
}

local function isScript(object)
	return object.ClassName == "LocalScript" or object.ClassName == "ModuleScript" or object.ClassName == "Script"
end

local function writeValidChildren(object, path)
	remodel.createDirAll(path)

	for _, child in ipairs(object:GetChildren()) do
		if not isScript(child) then remodel.writeModelFile(path .. child.Name .. ".rbxmx", child) end
	end
end

for _, container in ipairs(replicatedStorageContainers) do
	writeValidChildren(container, "assets/ReplicatedStorage/" .. container.Name .. "/")
end

writeValidChildren(game.Workspace, "assets/Workspace/")
writeValidChildren(Lighting, "assets/Lighting/")
