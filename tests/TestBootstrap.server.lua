local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TestEZ = require(ReplicatedStorage.TestEZ)

local unitTests = { ReplicatedStorage.UnitTests }
local results = TestEZ.TestBootstrap:run(unitTests, TestEZ.Reporters.TextReporter)

--This is needed for 'run-in-roblox' to work properly
if #results.errors > 0 or results.failureCount > 0 then
	error("Tests failed")
end