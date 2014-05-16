----------------------------------------
-- print() replacement
-- Using print() with a single argument will pretty print tables
-- Using print() with multiple arguments will use the standard print() function
-- 
-- @author Björn Ritzl
-- @license Apache License 2.0
-- @github https://github.com/britzl/prettyprint
----------------------------------------

-- keep the original print()
local _print = print

local indentation = ""

--- 
-- Pretty print a table and it's contents (recursively)
-- @param #table value The table to print
local function print_table(value)
	_print(indentation .. "{")
	indentation = indentation .. "\t"
	for name,data in pairs(value) do
		if type(name) == "string" then
			name = '"'..name..'"'
		else
			name = tostring(name)
		end
		local dt = type(data)
		if dt == "table" then
			_print(indentation .. name .. " =")
			print_table(data)
		elseif dt == "string" then
			_print(indentation .. name .. ' = "' .. tostring(data) .. '"')
		else
			_print(indentation .. name .. " = " .. tostring(data))
		end
	end
	indentation = indentation:sub(1,#indentation-1)
	_print(indentation .. "}")
end

--- 
-- Improved print() function
-- If a single argument is passed and it's a table it will be pretty printed,
-- otherwise the argument(s) will be passed to the normal print() function
local function improved_print(...)
	local arg_count = select('#',...)
	if arg_count == 1 and type(select(1, ...)) == "table" then
		print_table(select(1, ...))
	else
		_print(...)
	end
end

-- replace print() with improved print function that will pretty print tables
print = improved_print