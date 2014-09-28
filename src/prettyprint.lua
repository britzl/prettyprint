----------------------------------------
-- print() replacement that will pretty print tables
--
-- @module prettyprint
-- @author Björn Ritzl
-- @license Apache License 2.0
-- @github https://github.com/britzl/prettyprint
----------------------------------------


local pp = {
	print = print,
	indentation = "\t"
}


local function improved_print(...)
	-- keep track of printed tables to avoid infinite loops
	-- when tables refer to each other
	local printed_tables = {}

	local current_indentation = ""

	local function indent_more()
		current_indentation = current_indentation .. pp.indentation
	end

	local function indent_less()
		current_indentation = current_indentation:sub(1, #current_indentation - #pp.indentation)
	end

	local function prindented(s)
		pp.print(current_indentation .. s)
	end

	local function print_table(value)
		prindented("{")
		indent_more()
		for name,data in pairs(value) do
			if type(name) == "string" then
				name = '"'..name..'"'
			else
				name = tostring(name)
			end
			local dt = type(data)
			if dt == "table" then
				prindented(name .. " = [".. tostring(data) .. "]")
				if not printed_tables[data] then
					printed_tables[data] = true
					print_table(data)
				end
			elseif dt == "string" then
				prindented(name .. ' = "' .. tostring(data) .. '"')
			else
				prindented(name .. " = " .. tostring(data))
			end
		end
		indent_less()
		prindented("}")
	end

	-- iterate through each of the arguments and print them one by one
	local args = { ... }
	table.remove(args, 1)
	local s = ""
	for _, v in pairs(args) do
		if type(v) == "table" then
			pp.print(s)
			s = ""
			print_table(v)
		else
			s = s .. tostring(v) .. "\t"
		end
	end
	pp.print(s)
end

print = setmetatable(pp, {
	__call = improved_print,
	__AUTHOR = "Björn Ritzl",
	__DESCRIPTION = "print() replacement that will pretty-print tables",
	__URL = "https://github.com/britzl/prettyprint",
})
