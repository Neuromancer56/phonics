
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
--remove activated nodes from creative inventory.


phonics = {
	--handler = {},
	a={name="a", length=.4, gain=1, is_letter=1},
	a_={name="a_", length=.5, gain=1, is_letter=0},
	ar={name="ar", length=.93, gain=1, is_letter=0},
	au={name="au", length=.52, gain=1, is_letter=0},
	b={name="b", length=.35, gain=1, is_letter=1},
	c={name="c", length=.3, gain=1, is_letter=1},
	ch={name="ch", length=.17, gain=1, is_letter=0},
	d={name="d", length=.77, gain=1, is_letter=1},
	e={name="e", length=.65, gain=1, is_letter=1},
	e_={name="e_", length=.64, gain=1, is_letter=0},
	er={name="er", length=.65, gain=1, is_letter=0},
	f={name="f", length=.7, gain=1, is_letter=1},
	g={name="g", length=.14, gain=1, is_letter=1},
	h={name="h", length=.48, gain=1, is_letter=1},
	i={name="i", length=.65, gain=1, is_letter=1},
	i_={name="i_", length=.45, gain=1, is_letter=0},
	ing={name="ing", length=.67, gain=1, is_letter=0},
	j={name="j", length=.20, gain=1, is_letter=1},
	k={name="k", length=.3, gain=1, is_letter=1},
	l={name="l", length=.65, gain=1, is_letter=1},
	m={name="m", length=.65, gain=1, is_letter=1},
	n={name="n", length=.65, gain=1, is_letter=1},
	o={name="o", length=.65, gain=1, is_letter=1},
	o_={name="o_", length=.65, gain=1, is_letter=0},
	oo_={name="oo_", length=.65, gain=1, is_letter=0},
	oo={name="oo", length=.65, gain=1, is_letter=0},
	ou={name="ou", length=.6, gain=1, is_letter=0},
	p={name="p", length=.13, gain=1, is_letter=1},
	q={name="q", length=.15, gain=1, is_letter=1},
	r={name="r", length=.65, gain=1, is_letter=1},
	s={name="s", length=.65, gain=1, is_letter=1},
	sh={name="sh", length=.65, gain=1, is_letter=0},
	t={name="t", length=.3, gain=1, is_letter=1},
	th={name="th", length=.18, gain=1, is_letter=0},
	u={name="u", length=.65, gain=1, is_letter=1},	
	u_={name="u_", length=.92, gain=1, is_letter=0},	
	v={name="v", length=.65, gain=1, is_letter=1},
	w={name="w", length=.45, gain=1, is_letter=1},
	wh={name="wh", length=.23, gain=1, is_letter=0},
	x={name="x", length=.6, gain=1, is_letter=1},
	y={name="y", length=.84, gain=1, is_letter=1},		
	z={name="z", length=.65, gain=1, is_letter=1}
}

local words = {
	cat={spellings={ {c},{a},{t} } }
}

for key,value in pairs(phonics) do
	minetest.register_node("phonics:"..key, {
	description = key,
	tiles = {key..".jpg"},
	is_ground_content = true,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
	})
	minetest.register_node("phonics:"..key.."_active", {
	description = key.."_active",
	tiles = {key.."_active.png"},
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=3, choppy=3, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	})	
	if  phonics[key].is_letter ==1 then	
		minetest.register_node("phonics:"..key.."_silent", {
		description = "Silent "..key,
		tiles = {key.."_silent.png"},
		is_ground_content = true,
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	 	})	
	end
end
--current_word =

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
		--minetest.chat_send_all("pos1.x:" .. mpos.x ..">" )
		--minetest.chat_send_all("axis:" .. axis ..">" )
		local delay = phonics[nodename_suffix]
		if  delay ~=nil and nodename_prefix =="phonics"  then 		
			local lpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
              lpos.x = mpos.x 
              lpos.y = mpos.y 
              lpos.z = mpos.z 	
			minetest.after(cumulative_delay, activate_node, {lpos, nodename_suffix, phonics[nodename_suffix].length}) 
			cumulative_delay = cumulative_delay + phonics[nodename_suffix].length 
		end
	until nodename_prefix ~="phonics"	
end

minetest.register_on_punchnode( function(pos, node, puncher)
--activated nodes cannot be dug.  Need to not activate when punched by item that has wear.
	hit_with = puncher:get_wielded_item()
	wear=hit_with:get_wear()
--if we have punched a phonics node in the phonics table then activate it.	
for key,value in pairs(phonics) do  
if node.name == "phonics:"..key
 then 
 	if wear == 0 then
		activate_node({pos, key, phonics[key].length})
	end
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
