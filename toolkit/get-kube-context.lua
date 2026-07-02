#!/usr/bin/env lua

local ICON_UNSET = "\xef\x8b\xbe"

local function strip_yaml_quotes(s)
	local inner = s:match('^"(.*)"$') or s:match("^'(.*)'$")
	return inner or s
end

local function read_kube_current_context()
	local home = os.getenv("HOME")
	if not home then
		error("HOME environment variable not set")
	end
	local config_path = home .. "/.kube/config"

	local file = io.open(config_path, "r")
	if not file then
		print(ICON_UNSET .. " ")
		os.exit(0)
	end

	local content = file:read("*all")
	file:close()

	local ctx = content:match("^current%-context:%s*(.-)%s*$", 1)
	if not ctx then
		ctx = content:match("\ncurrent%-context:%s*(.-)%s*\n")
	end

	if ctx then
		ctx = strip_yaml_quotes(ctx)
	end

	if ctx and ctx ~= "" then
		return ctx
	end

	return nil
end

local status, result = pcall(read_kube_current_context)
if status then
	if result == nil then
		print(ICON_UNSET .. " ")
	else
		print("󱃾  [" .. result .. "]")
	end
else
	io.stderr:write(result .. "\n")
	os.exit(1)
end
