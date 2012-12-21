--
--Phonics by bacon and Neuromancer
--License code and textures WTFPL 
--code borrows heavilly from InfinityProject's firework mod.
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

minetest.register_abm({
		nodenames = {"phonics:a", "phonics:c"},
		interval = 8,
		chance = 1,	
		
		action = function(pos, node, active_object_count, active_object_count_wider)
--		if node.name == "fireworks:red" then
--				  minetest.env:remove_node(pos,{name="fireworks:red"})
--		elseif node.name == "fireworks:blue" then
--		          minetest.env:remove_node(pos,{name="fireworks:blue"})
--		elseif node.name == "fireworks:green" then
--				  minetest.env:remove_node(pos,{name="fireworks:green"})
--		elseif node.name == "fireworks:purple" then
--		          minetest.env:remove_node(pos,{name="fireworks:purple"})
--		elseif node.name == "fireworks:orange" then
--				  minetest.env:remove_node(pos,{name="fireworks:orange"})
--		elseif node.name == "fireworks:yellow" then
--		          minetest.env:remove_node(pos,{name="fireworks:yellow"})
--		elseif node.name == "fireworks:rainbow" then
--		          minetest.env:remove_node(pos,{name="fireworks:rainbow"})
--				  
--			end
		end
})

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
--minetest.register_node("fireworks:red", {
--	drawtype = "plantlike",
--	description = "Red",
--	tiles = {"fireworks_red.png"},
--	light_source = 14,  --**********
--	walkable = false,
--	is_ground_content = true,
--	pointable = false,
--	groups = {cracky=3,not_in_creative_inventory=1},
--	sounds = default.node_sound_stone_defaults(),
--})


minetest.register_node("phonics:a", {
	description = "a",
	tiles = {"a.jpg"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = {
        footstep = default.node_sound_stone_defaults(),
        dig = {name="a", gain= 1}, -- "__group" = group-based sound (default)
        dug = default.node_sound_stone_defaults(),
        },
})

minetest.register_node("phonics:c", {
	description = "c",
	tiles = {"c.jpg"},
		light_source = 14,  --**********
	is_ground_content = true,
	groups = {cracky=3},
		sounds = {
        footstep = default.node_sound_stone_defaults(),
        dig = {name="c", gain= 1}, -- "__group" = group-based sound (default)
        place = {name="c", gain= 1},
        dug = default.node_sound_stone_defaults(),
    },
})

--minetest.register_node("fireworks:red", {
--	drawtype = "plantlike",
--	description = "Red",
--	tiles = {"fireworks_red.png"},
--	light_source = 14,
--	walkable = false,
--	is_ground_content = true,
--	pointable = false,
--	groups = {cracky=3,not_in_creative_inventory=1},
--	sounds = default.node_sound_stone_defaults(),
--})



local phonics = {
	handler = {},
	{name="a", length=1.3, gain=1},
	{name="c", length=.3, gain=1}	
}
local play_sound = function(list, number)
		local gain = 1.0
		minetest.chat_send_all("number" .. number ..">" )
		--minetest.chat_send_all("list[1].name" .. list[1].name ..">" )
		--minetest.chat_send_all("list[number].name" .. list[number].name ..">" )
		local handler = minetest.sound_play(number, {gain=gain})
		--local handler = minetest.sound_play(number, {gain=gain})
end

function phonics_activate (pos, node)
	minetest.chat_send_all("pos.x" .. pos.x ..">" )
	minetest.chat_send_all("pos.y" .. pos.y ..">" )
	minetest.chat_send_all("pos.z" .. pos.z ..">" )
play_sound(phonics, node)
end

--if 
--  node.name == "phonics:a" 
--then
--end
--elseif
--  node.name == "phonics:c" 
--then
--end
--
--end --function

--minetest.env:remove_node(pos,{name="fireworks:firework_green"})

minetest.register_on_punchnode( function(pos, node, puncher)

--minetest.chat_send_all("number" .. descr ..">" )
--if node.name == "phonics:a" 
-- then phonics_activate(pos, node.description) --1
--end
--if node.name == "phonics:c" 
-- then phonics_activate(pos, node.description) --2
--end
--phonics_activate(pos, node.description)
if node.name == "phonics:SayWord" 
 then 
 	pos.z = pos.z-2
 	minetest.env:punch_node(pos) 
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
end

end
 
 )

print("Phonics Mod Loaded!")