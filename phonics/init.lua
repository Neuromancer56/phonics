
--Phonics by bacon and Neuromancer
--License code and textures WTFPL 
 
--For now you can left click the blue blocks and they make phonics sounds and light up.  

--Start by placing the blue phonics blocks and left clicking on them to hear their sounds.  They also light up.
--Next place a "sound out word" block (the one with a mouth on it) and then build a word by placing the blue blocks next to it.
--Left Click (punch) the mouth block to hear the word you built sounded out.

--This mod has a long way to go: 
--Plan for enhancements (being worked on):
--Left Clicking (punching) on the mouth block left click says a word it wants you to spell 
--followed by sounding out what you have spelled to the right of it.
--if what you have spelled matches one of the spellings for the mouth the block is looking for it makes a
---firework sound (eventually launching blocks into the air as fireworks)
--if you have not spelled the word the mouth block is looking for, it makes a sad noise.
--if you destroy mouth block, it destroys all letters to the right of it  (explode or fire burn)
--gray blocks are silent letters which are not sounded out 
-- this means we have to create sounds for words and an array of spellings for each word.
--if you don't want a word and want a new word, just destroy the mouth block.
--maybe have it spell out the correct answer if you put a show answer block on top of the mouth block.
--if you place a word block, a word is automatically generated to the right of the word block and you are expected to read it.
--you can click individual blocks to help you sound it out
--you can also left click the word block to get the answer (it will sound out the word and then say the word.)
--Create blocks with pictures of the thing that the word describes so that someone learning the language as a second language could also benefit.
--someday have an NPC Tutor.

--TODO:
----use phonics table and a loop to register all the nodes


local phonics = {
	--handler = {},
	a={name="a", length=1.2, gain=1},
	c={name="c", length=.3, gain=1},
	i={name="i", length=2.0, gain=1},
	l={name="l", length=2.0, gain=1},
	m={name="m", length=2.0, gain=1},
	o={name="o", length=2.0, gain=1},
	t={name="t", length=.3, gain=1},
	x={name="x", length=.6, gain=1}		
}

local words = {
	cat={spellings={"cat"}}
}

--current_word 

minetest.register_node("phonics:SayWord", {
	description = "say word",
	tiles = {
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"SpeakingMouth64.png",
	"SpeakingMouth64.png",
	"SpeakingMouth64.png",},
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
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:c", {
	description = "c",
	tiles = {"c.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:i", {
	description = "i",
	tiles = {"i.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:l", {
	description = "l",
	tiles = {"l.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:m", {
	description = "m",
	tiles = {"m.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:o", {
	description = "o",
	tiles = {"o.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:t", {
	description = "t",
	tiles = {"t.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:x", {
	description = "x",
	tiles = {"x.jpg"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:a_active", {
	description = "a_active",
	tiles = {"a_active.png"},
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:c_active", {
	description = "c_active",
	tiles = {"c_active.png"},
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:i_active", {
	description = "i_active",
	tiles = {"i_active.png"},
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:l_active", {
	description = "l_active",
	tiles = {"l_active.png"},
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:m_active", {
	description = "m_active",
	tiles = {"m_active.png"},
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:o_active", {
	description = "o_active",
	tiles = {"o_active.png"},
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("phonics:t_active", {
	description = "t_active",
	tiles = {"t_active.png"},
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("phonics:x_active", {
	description = "x_active",
	tiles = {"x_active.png"},
	light_source = 20, 
	is_ground_content = true,
	groups = {cracky=1},
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
 	local pos3 = parms[1]
 	local node3= parms[2]
 	minetest.env:remove_node(pos3,{name="phonics:"..node3.."_active"})
 	minetest.env:place_node(pos3,{name="phonics:"..node3})
end

function activate_node(anparms)
	local pos2 = anparms[1]
	local nodename = anparms[2]
	local duration = anparms[3]
 	minetest.env:remove_node(pos2,{name="phonics:"..nodename})
 	minetest.env:place_node(pos2,{name="phonics:"..nodename.."_active"}) 
 	play_sound(phonics, nodename) 
 	local np = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
              np.x = pos2.x 
              np.y = pos2.y 
              np.z = pos2.z 
 	minetest.after(duration, revertnode, {np, nodename})		
end

function sound_out_word(pos1, axis, direction)
	local cumulative_delay = 0
	local mpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      mpos.x = pos1.x 
      mpos.y = pos1.y 
      mpos.z = pos1.z 
	repeat
		if axis == "x" then
			mpos.x=mpos.x+direction
		end	
		if axis == "z" then
				mpos.z=mpos.z+direction
		end	
		local nodename = minetest.env:get_node(mpos).name 
		local nodenamearray = split(nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		minetest.chat_send_all("pos1.x:" .. mpos.x ..">" )
		minetest.chat_send_all("axis:" .. axis ..">" )
		local delay = phonics[nodename_suffix]
		if  delay ~=nil and nodename_prefix =="phonics"  then 		
			local duration = 1			
			local lpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
              lpos.x = mpos.x 
              lpos.y = mpos.y 
              lpos.z = mpos.z 	
			minetest.after(cumulative_delay, activate_node, {lpos, nodename_suffix, duration})
			cumulative_delay = cumulative_delay + phonics[nodename_suffix].length 
		end
	until nodename_prefix ~="phonics"	
end

minetest.register_on_punchnode( function(pos, node, puncher)
--activated nodes cannot be dug.  Need to not activate when punched by item that has wear.
	hit_with = puncher:get_wielded_item()
	wear=hit_with:get_wear()
if node.name == "phonics:a" 
 then 
 	if wear == 0 then
		activate_node({pos, "a", 1.1})
	end
end
if node.name == "phonics:c" 
 then 
 	if wear == 0 then  
		activate_node({pos, "c", .4})
	end
end
if node.name == "phonics:i" 
 then 
 	if wear == 0 then  
		activate_node({pos, "i", 2.0})
	end
end
if node.name == "phonics:l" 
 then 
 	if wear == 0 then  
		activate_node({pos, "l", 2.0})
	end
end
if node.name == "phonics:m" 
 then 
 	if wear == 0 then  
		activate_node({pos, "m", 2.0})
	end
end
if node.name == "phonics:o" 
 then 
 	if wear == 0 then  
		activate_node({pos, "o", 1.4})
	end
end
if node.name == "phonics:x" 
 then 
 	if wear == 0 then  
		activate_node({pos, "x", .6})
	end
end
if node.name == "phonics:t" 
 then 
 	if wear == 0 then  
		activate_node({pos, "t", .3})
	end
end

if node.name == "phonics:SayWord" 
 then 
 	--if current_word =
    sound_out_word(pos, "x", 1)
    sound_out_word(pos, "x", -1)
    sound_out_word(pos, "z", 1)
    sound_out_word(pos, "z", -1)
end
end 
 )

print("Phonics Mod Loaded!")
 	--minetest.env:punch_node(pos) 
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
