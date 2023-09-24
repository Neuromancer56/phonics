------------Crafting

minetest.register_craft({
	output = "default:coal_lump 5",
	recipe = {
		{"phonics:c", "phonics:_o", "phonics:0a"},
		{"phonics:l", "",""},
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
	output = "default:ladder 9",
	recipe = {
		{"phonics:l", "phonics:a", "phonics:d"},
		{"phonics:0d", "phonics:er",""},
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
	output = "default:torch 9",
	recipe = {
		{"phonics:t", "phonics:_o", "phonics:r"},
		{"phonics:ch", "",""},
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
	output = "boats:boat",
	recipe = {
		{"phonics:b", "phonics:_o", "phonics:0a"},
		{"phonics:t", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "carts:rail 2",
	recipe = {
		{"phonics:r", "phonics:_a", "phonics:0i"},
		{"phonics:l", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "bucket:bucket_empty",
	recipe = {
		{"phonics:b", "phonics:u", "phonics:c"},
		{"phonics:0k", "phonics:e","phonics:t"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:apple",
	recipe = {
		{"phonics:a", "phonics:p", "phonics:0p"},
		{"phonics:l", "phonics:0e",""},
		{"","" ,""},
	}
})