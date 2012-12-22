
--Phonics by bacon and Neuromancer
--License code and textures WTFPL 
--Requirements (being worked on):

--use chat to find out what is happening with sound out word.
--fix you can no longer dig a phonics node because it is changing state while you are digging it.  (if using pickaxe like super pickaxe then just delete it)
--use phonics table and a loop to register all the nodes


--mouth block left click (punch) says the word it wants you to spell followed by sounding out what you have spelled (to the right of it)
--if what you have spelled matches one of the spellings for the mouth the block is looking for it makes a
---  firework sound (eventually launching blocks into the air as fireworks)
--if you have not spelled the word the mouth block is looking for, it makes a sad noise.
--(done)as it says each sound the corresponding block lights up
--if you destroy mouth block, it destroys all letters to the right of it  (explode or fire burn)
--gray blocks are silent letters which are not sounded out 
-- this means we have to create sounds for words and an array of spellings for each word.
--if you don't want a word and want a new word, just destroy the mouth block.
--maybe have it spell out the correct answer if you put a show answer block on top of the mouth block.

--if you place a word block, a word is automatically generated to the right of the word block and you are expected to read it.
--you can click individual blocks to help you sound it out
--you can also left click the word block to get the answer (it will sound out the word and then say the word.)

--someday have an NPC Tutor.

local phonics = {
	handler = {},
	{name="a", length=1.3, gain=1},
	{name="c", length=.3, gain=1}	
}

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
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:a_active", {
	description = "a_active",
	tiles = {"a_active.png"},
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})


function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

local play_sound = function(list, soundname)
		local gain = 1.0
		--minetest.chat_send_all("list[number].name" .. list[number].name ..">" )
		local handler = minetest.sound_play(soundname, {gain=gain})
end

function revertnode(parms)  
 	posx = parms[1]
 	nodex= parms[2]
 --	minetest.chat_send_all("nodex: " .. nodex ..">" )
 	
 	minetest.env:remove_node(posx,{name="phonics:"..nodex.."_active"})
 	minetest.env:place_node(posx,{name="phonics:"..nodex})
end

function activate_node(pos, nodename, duration)
 	minetest.env:remove_node(pos,{name="phonics:"..nodename})
 	minetest.env:place_node(pos,{name="phonics:"..nodename.."_active"}) 
 	play_sound(phonics, nodename) 
 	minetest.after(duration, revertnode, {pos, nodename})	
end

function sound_out_word(pos, axis, direction)
	minetest.chat_send_all("soundoutword" )
	repeat
		minetest.chat_send_all("B4 pos.x: " .. pos.x ..">" )
		minetest.chat_send_all("B4 pos.z: " .. pos.z ..">" )
		if axis == "x" then
				pos.x=pos.x+direction
				minetest.chat_send_all("xDirection: " .. direction ..">" )
		end	
		if axis == "z" then
				pos.z=pos.z+direction
				minetest.chat_send_all("zDirection: " .. direction ..">" )
		end	
		minetest.chat_send_all("pos.x: " .. pos.x ..">" )
		minetest.chat_send_all("pos.z: " .. pos.z ..">" )
		nodename = minetest.env:get_node(pos).name 
		nodenamearray = split(nodename, ":")
		nodename_prefix = nodenamearray[1]
		nodename_suffix = nodenamearray[2]	
		if  nodename_prefix =="phonics" then		
--			activate_node(pos, nodename_suffix, duration)						
		end
	until nodename_prefix ~="phonics"	
end

minetest.register_on_punchnode( function(pos, node, puncher)
if node.name == "phonics:c" 
 then 
	activate_node(pos, "c", .4)
end
if node.name == "phonics:a" 
 then 
 	activate_node(pos, "a", 1.1)
end
if node.name == "phonics:SayWord" 
 then 
 	minetest.chat_send_all("SayWordPunched " )
--    sound_out_word(pos, "x", 1)
--    sound_out_word(pos, "x", -1)
--    sound_out_word(pos, "z", 1)
    sound_out_word(pos, "z", -1)
	end
end --what is this end for (register on punchnode?   Isn't that what the ) is for?

 )

print("Phonics Mod Loaded!")
 	--minetest.env:punch_node(pos) 
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
