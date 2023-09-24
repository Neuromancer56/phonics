------------Crafting
minetest.register_craft({
	output = "default:apple",
	recipe = {
		{"phonics:a", "phonics:p", "phonics:0p"},
		{"phonics:l", "phonics:0e",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:axe_steel",
	recipe = {
		{"phonics:a", "phonics:x", "phonics:0e"},
		{"", "",""},
		{"","" ,""},
	}
})

--doesn't work 
minetest.register_craft({
	output = "beds:fancy_bed",
	recipe = {
		{"phonics:b", "phonics:e", "phonics:d"},
		{"", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "boats:boat 2",
	recipe = {
		{"phonics:b", "phonics:_o", "phonics:0a"},
		{"phonics:t", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "bucket:bucket_empty 2",
	recipe = {
		{"phonics:b", "phonics:u", "phonics:c"},
		{"phonics:0k", "phonics:e","phonics:t"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "carts:cart 3",
	recipe = {
		{"phonics:c", "phonics:ar", "phonics:t"},
		{"", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:coal_lump 10",
	recipe = {
		{"phonics:c", "phonics:_o", "phonics:0a"},
		{"phonics:l", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:dirt 49",
	recipe = {
		{"phonics:d", "phonics:er", "phonics:t"},
		{"", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:door 5",
	recipe = {
		{"phonics:d", "phonics:_o", "phonics:0o"},
		{"phonics:r", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:black 10",
	recipe = {
		{"phonics:b", "phonics:l", "phonics:a"},
		{"phonics:c", "phonics:0k",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:brown 10",
	recipe = {
		{"phonics:b", "phonics:r", "phonics:ou"},
		{"phonics:n", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:cyan 10",
	recipe = {
		{"phonics:s", "phonics:_i", "phonics:a"},
		{"phonics:n", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:dark_green 10",
	recipe = {
		{"phonics:d", "phonics:ar", "phonics:k"},
		{"", "phonics:g","phonics:r"},
		{"phonics:_e","phonics:0e" ,"phonics:n"},
	}
})

minetest.register_craft({
	output = "dye:dark_grey 10",
	recipe = {
		{"phonics:d", "phonics:ar", "phonics:k"},
		{"", "phonics:g","phonics:r"},
		{"phonics:_a","phonics:0y" ,""},
	}
})

minetest.register_craft({
	output = "dye:green 10",
	recipe = {
		{"phonics:g", "phonics:r", "phonics:_e"},
		{"phonics:0e", "phonics:n",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:blue 10",
	recipe = {
		{"phonics:b", "phonics:l", "phonics:_oo"},
		{"", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:red 10",
	recipe = {
		{"phonics:r", "phonics:e", "phonics:d"},
		{"", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:fence 33",
	recipe = {
		{"phonics:f", "phonics:e", "phonics:n"},
		{"phonics:s", "phonics:0e",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "doors:gate_wood 10",
	recipe = {
		{"phonics:g", "phonics:_a", "phonics:t"},
		{"phonics:0e", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:glass 33",
	recipe = {
		{"phonics:g", "phonics:l", "phonics:a"},
		{"phonics:s", "phonics:0s",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:ladder 9",
	recipe = {
		{"phonics:l", "phonics:a", "phonics:d"},
		{"phonics:0d", "phonics:er",""},
		{"","" ,""},
	}
})

--minetest.clear_craft({output = "default:pick_steel"}) 
minetest.register_craft({
	output = "default:pick_steel",
	recipe = {
		{"phonics:p", "phonics:i", "phonics:c"},
		{"phonics:0k", "",""},
		{"","" ,""},
	}
})


minetest.register_craft({
	output = "default:pine_tree 10",
	recipe = {
		{"phonics:p", "phonics:_i", "phonics:n"},
		{"phonics:0e", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "carts:rail 20",
	recipe = {
		{"phonics:r", "phonics:_a", "phonics:0i"},
		{"phonics:l", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:stick 49",
	recipe = {
		{"phonics:s", "phonics:t", "phonics:i"},
		{"phonics:c", "phonics:0k",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:stone 49",
	recipe = {
		{"phonics:s", "phonics:t", "phonics:_o"},
		{"phonics:n", "phonics:0e",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:sword_steel",
	recipe = {
		{"phonics:s", "phonics:0w", "phonics:_o"},
		{"phonics:r", "phonics:d",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:apple_tree 10",
	recipe = {
		{"phonics:t", "phonics:r", "phonics:_e"},
		{"phonics:0e", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:torch 20",
	recipe = {
		{"phonics:t", "phonics:_o", "phonics:r"},
		{"phonics:ch", "",""},
		{"","" ,""},
	}
})











