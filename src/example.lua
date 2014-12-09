require("prettyprint")

local function some_function(arg) end

local some_table = {
	foo = "bar",
	nested = {
		1, 2, 3, "a", "b", "c", ["key"] = "value", [some_function] = "another_value"
	},
	fn = function() end,
}

print(some_table)

-- ignore table keys named "foo" and "key"
print.ignore = { "foo", "key" }

print(some_table)
