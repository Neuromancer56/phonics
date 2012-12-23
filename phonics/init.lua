
--Phonics by bacon and Neuromancer
--License code and textures WTFPL 
--Requirements (being worked on):

--This mod has a long way to go.  For now you can left click the blue blocks and they make phonics sounds and light up.  Here's the plan:
--fix sound out word.
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
--Create blocks with pictures of the thing that the word describes so that someone learning the language as a second language could also benefit.
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

minetest.register_node("phonics:c_active", {
	description = "c_active",
	tiles = {"c_active.png"},
	light_source = 20, 
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
	local delay = 0
	repeat
		if axis == "x" then
			pos1.x=pos1.x+direction
		end	
		if axis == "z" then
				pos1.z=pos1.z+direction
		end	
		local nodename = minetest.env:get_node(pos1).name 
		local nodenamearray = split(nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]	
		if  nodename_prefix =="phonics" then		
			local duration = 1			
			local lpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
              lpos.x = pos1.x 
              lpos.y = pos1.y 
              lpos.z = pos1.z 	
			--activate_node({pos1, nodename_suffix, duration})
			minetest.after(delay, activate_node, {lpos, nodename_suffix, duration})
			delay = delay +1 
--may need to pause here between each activation as well						
		end
	until nodename_prefix ~="phonics"	
end

minetest.register_on_punchnode( function(pos, node, puncher)
--activated nodes cannot be dug.  Need to not activate when punched by item that has wear.
	hit_with = puncher:get_wielded_item()
	wear=hit_with:get_wear()
	--print (temp["wear"])

if node.name == "phonics:c" 
 then 
 	if wear == 0 then  
		activate_node({pos, "c", .4})
	end
end
if node.name == "phonics:a" 
 then 
 	if wear == 0 then
		activate_node({pos, "a", 1.1})
	end
end
if node.name == "phonics:SayWord" 
 then 
    --sound_out_word(pos, "x", 1)
    --sound_out_word(pos, "x", -1)
    --sound_out_word(pos, "z", 1)
    sound_out_word(pos, "z", -1)
end
end 
 )

print("Phonics Mod Loaded!")
 	--minetest.env:punch_node(pos) 
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
