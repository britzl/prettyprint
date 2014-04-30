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

--- Pretty print a value
-- If the value is a table it's content will be printed as well (recursively)
local function pretty_print(value)
	local t = type(value)
	if t == "nil" then
		_print(indentation .. "nil")
	elseif t ~= "table" then
		_print(indentation .. value)
	else
		_print(indentation .. "{")
		indentation = indentation .. "\t"
		for name,data in pairs(value) do
			if type(data) == "table" then
				_print(indentation .. name .. " =")
				pretty_print(data)
			else
				_print(indentation .. name .. " = " .. tostring(data))
			end
		end
		indentation = indentation:sub(1,#indentation-1)
		_print(indentation .. "}")
	end
end

--- Improved print() function
-- If multiple arguments are passed they will be printed using the normal
-- print() function.
-- If a single argument is passed it will be pretty printed if it's a table
local function improved_print(...)
	if select('#',...) > 1 then
		_print(...)
	else
		pretty_print(select(1, ...))
	end
end

-- replace print() with improved print function that will pretty print tables
print = improved_print