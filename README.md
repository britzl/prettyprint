prettyprint
===========

Lua print replacement that will print the contents of tables

Example
=======

	require("prettyprint.lua")

	local some_table = {
		foo = "bar",
		nested = {
			1, 2, 3, "a", "b", "c"
		},
		fn = function() end,
	}

	print(some_table)

Output:

	{
		fn = function: 0x7f9e5c80bb20
		nested =
		{
			1 = 1
			2 = 2
			3 = 3
			4 = "a"
			5 = "b"
			6 = "c"
		}
		foo = "bar"
	}
