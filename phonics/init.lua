
--Phonics by bacon and Neuromancer
--License code and textures WTFPL 
--Requirements:
--Mouth block right click says the word it wants you to spell
--mouth block left click (punch) sounds out what you have spelled (to the right of it)
--if what you have spelled matches one of the spellings for the word the block is looking for
--it makes a firework sound (eventually launching blocks into the air as fireworks)
--if you have not spelled the word the mouth block is looking for, it makes a sad noise.
--as it says each sound the corresponding block lights up
--if you destroy mouth block, it destroys all letters to the right of it  (explode or fire burn)
--gray blocks are silent letters which are not sounded out 
-- this means we have to create sounds for words and an array of spellings for each word.
--someday have an NPC Tutor.
--maybe have it spell out the correct answer if you put a show answer block on top of it.
--if you don't want a word and want a new word, just destroy the mouth block.

minetest.register_node("phonics:SayWord", {
	description = "say word",
	tiles = {
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"mouthspeaking.jpg",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:a", {
	description = "a",
	tiles = {"a.jpg"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:c", {
	description = "c",
	tiles = {"c.jpg"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:c_active", {
	description = "c_active",
	tiles = {"c_active.png"},
	light_source = 44, 
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:a_active", {
	description = "a_active",
	tiles = {"a_active.png"},
	light_source = 44,
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

local phonics = {
	handler = {},
	{name="a", length=1.3, gain=1},
	{name="c", length=.3, gain=1}	
}

local play_sound = function(list, soundname)
		local gain = 1.0
		minetest.chat_send_all("number" .. soundname ..">" )
		--minetest.chat_send_all("list[1].name" .. list[1].name ..">" )
		--minetest.chat_send_all("list[number].name" .. list[number].name ..">" )
		local handler = minetest.sound_play(soundname, {gain=gain})
end

function revertnode(parms)  
 	posx = parms[1]
 	nodex= parms[2]
 	minetest.chat_send_all("nodex: " .. nodex ..">" )
 	
 	minetest.env:remove_node(posx,{name="phonics:"..nodex.."_active"})
 	minetest.env:place_node(posx,{name="phonics:"..nodex})
end

function activate_node(pos, nodename, duration)
 	minetest.env:remove_node(pos,{name="phonics:"..nodename})
 	minetest.env:place_node(pos,{name="phonics:"..nodename.."_active"}) 
 	play_sound(phonics, nodename) 
 	minetest.after(duration, revertnode, {pos, nodename})	
end

minetest.register_on_punchnode( function(pos, node, puncher)
if node.name == "phonics:c" 
 then 
	activate_node(pos, "c", .3)
end
if node.name == "phonics:a" 
 then 
 	activate_node(pos, "a", 1.1)
end

if node.name == "phonics:SayWord" 
 then 
 	pos.z = pos.z-2
 	minetest.env:punch_node(pos) 
 	--for xpos = -2000, 2000, 50 do end
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
	end
end --register_on_Punchnode
 
 )

print("Phonics Mod Loaded!")