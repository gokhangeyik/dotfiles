#!/usr/bin/env lua

local lyaml = require("lyaml")
local io = require("io")

local function read_kube_current_context()
	local home = os.getenv("HOME")
	if not home then
		error("HOME environment variable not set")
	end
	local config_path = home .. "/.kube/config"

	local file, err = io.open(config_path, "r")
	if not file then
		error("Failed to open " .. config_path .. ": " .. (err or "unknown error"))
	end

	local content = file:read("*all")
	file:close()

	local success, parsed = pcall(function()
		return lyaml.load(content)
	end)
	if not success then
		error("Failed to parse YAML: " .. tostring(parsed))
	end

	if parsed and parsed["current-context"] then
		return parsed["current-context"]
	else
		error("No 'current-context' found in " .. config_path)
	end
end

local status, result = pcall(read_kube_current_context)
if status then
	if result == "" then
		print(" ")
		return
	end
	print("󱃾 " .. result)
else
	io.stderr:write(result .. "\n")
	os.exit(1)
end
