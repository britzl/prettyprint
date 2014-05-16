prettyprint
===========

Lua print replacement that will print the contents of tables

Example
=======

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

Output:

	{
		"fn" = function: 0x7f962b431130
		"nested" =
		{
			1 = 1
			2 = 2
			3 = 3
			4 = "a"
			5 = "b"
			6 = "c"
			"key" = "value"
			function: 0x7f962b430ca0 = "another_value"
		}
		"foo" = "bar"
	}
