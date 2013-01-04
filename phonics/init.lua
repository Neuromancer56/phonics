
--Phonics by bacon and Neuromancer
--License code and textures WTFPL 
 
--For now you can left click the blue blocks and they make phonics sounds and light up.  

--Start by placing the blue phonics blocks and left clicking on them to hear their sounds.  They also light up.
--Next place a "sound out word" block (the one with a mouth on it) and then build a word by placing the blue blocks next to it.
--Left Click (punch) the mouth block to hear the word you built sounded out.

--This mod has a long way to go: 
--Plan for enhancements (being worked on):
--***TEST: punching a page start will not only blank the page, but reset the current_page_start so it can be written to again.
--***put a limit on how far away page finish can be from page start on x and z axis.

--Add a chat command allowing a teaching player to type in words that appear as phonics.  That way the learning player must either 
--read what the teacher types in chat, or sound out the phonics blocks that appear above the teacher's head.  Then it is just free play
--in whatever peak's the learner's interest.
--Chat command /ph will display a Sentence Block, plus what they typed with a sayWord block in front of every word.
--if the sentence block is deleted, the whole sentence is deleted.
--to display "ar" type a+r, to display long e, type "e_", to display silent e, type Se



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
--punch scroll blanks the page again.
--dig scroll deletes the page.

local page_start
local page_end
local message_index

phonics = {
	a={name="a", length=.4, gain=1, is_letter=1},
	_a={name="_a", length=.5, gain=1, is_letter=0},
	ar={name="ar", length=.93, gain=1, is_letter=0},
	au={name="au", length=.52, gain=1, is_letter=0},
	b={name="b", length=.35, gain=1, is_letter=1},
	c={name="c", length=.3, gain=1, is_letter=1},
	ch={name="ch", length=.17, gain=1, is_letter=0},
	d={name="d", length=.77, gain=1, is_letter=1},
	e={name="e", length=.65, gain=1, is_letter=1},
	_e={name="_e", length=.64, gain=1, is_letter=0},
	er={name="er", length=.65, gain=1, is_letter=0},
	f={name="f", length=.7, gain=1, is_letter=1},
	g={name="g", length=.14, gain=1, is_letter=1},
	h={name="h", length=.48, gain=1, is_letter=1},
	i={name="i", length=.65, gain=1, is_letter=1},
	_i={name="_i", length=.45, gain=1, is_letter=0},
	ing={name="ing", length=.67, gain=1, is_letter=0},
	j={name="j", length=.20, gain=1, is_letter=1},
	k={name="k", length=.3, gain=1, is_letter=1},
	l={name="l", length=.65, gain=1, is_letter=1},
	m={name="m", length=.65, gain=1, is_letter=1},
	n={name="n", length=.65, gain=1, is_letter=1},
	o={name="o", length=.65, gain=1, is_letter=1},
	_o={name="_o", length=.65, gain=1, is_letter=0},
	_oo={name="_oo", length=.65, gain=1, is_letter=0},
	oo={name="oo", length=.65, gain=1, is_letter=0},
	ou={name="ou", length=.6, gain=1, is_letter=0},
	p={name="p", length=.35, gain=1, is_letter=1},
	q={name="q", length=.15, gain=1, is_letter=1},
	r={name="r", length=.65, gain=1, is_letter=1},
	s={name="s", length=.65, gain=1, is_letter=1},
	sh={name="sh", length=.65, gain=1, is_letter=0},
	t={name="t", length=.3, gain=1, is_letter=1},
	th={name="th", length=.18, gain=1, is_letter=0},
	u={name="u", length=.65, gain=1, is_letter=1},	
	_u={name="_u", length=.92, gain=1, is_letter=0},	
	v={name="v", length=.65, gain=1, is_letter=1},
	w={name="w", length=.45, gain=1, is_letter=1},
	wh={name="wh", length=.23, gain=1, is_letter=0},
	x={name="x", length=.6, gain=1, is_letter=1},
	y={name="y", length=.84, gain=1, is_letter=1},		
	z={name="z", length=.65, gain=1, is_letter=1}
}

two_char_phonics = {
	ar= {name="ar"},
	au= {name="au"},
	ch= {name="ch"},
	er= {name="er"},
	oo= {name="oo"},
	ou= {name="ou"},
	sh= {name="sh"},
	th= {name="th"},
	wh= {name="wh"}	
}

three_char_phonics = {
	ing= {name="ing"}
}

local words = {
	cat={spellings={ {c},{a},{t} } }
}


for key,value in pairs(phonics) do
	minetest.register_node("phonics:"..key, {
	description = key,
	tiles = {"phonics_"..key..".jpg"},
	is_ground_content = true,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
	on_punch = function(pos, node, puncher) 
--		minetest.chat_send_all("phonic.on_punch:" .. pos.x ..">" )
		hit_with = puncher:get_wielded_item()
		wear=hit_with:get_wear()
 		if wear == 0 then       
			activate_node({pos, key, phonics[key].length})
		end
	end,	
	})
	minetest.register_node("phonics:"..key.."_active", {
	description = key.."_active",
	tiles = {"phonics_"..key.."_active.png"},
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=3, choppy=3, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	})	
	if  phonics[key].is_letter ==1 then	
		minetest.register_node("phonics:0"..key, {
		description = "Silent "..key,
		tiles = {"phonics_0"..key..".png"},
		is_ground_content = true,
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	 	})	
	end
end


minetest.register_node("phonics:question_mark", {
	description = "Question Mark",
	tiles = {
	"question_mark.png",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
--	on_punch = function(pos, node, puncher)      
--	end
})
minetest.register_node("phonics:exclamation_point", {
	description = "Exclamation Point",
	tiles = {
	"exclamation_point.png",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
--	on_punch = function(pos, node, puncher)      
--	end
})
minetest.register_node("phonics:period", {
	description = "Period",
	tiles = {
	"period.png",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
--	on_punch = function(pos, node, puncher)      
--	end
})

minetest.register_node("phonics:SayWord", {
	description = "say word",
	tiles = {
	"white.jpg",
	"white.jpg",
	"SpeakingMouth64.png",
	"SpeakingMouth64.png",
	"SpeakingMouth64.png",
	"SpeakingMouth64.png",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_punch = function(pos, node, puncher) 
		sound_out_word(pos, "x", 1)
	    sound_out_word(pos, "x", -1)
	    sound_out_word(pos, "z", 1)
	    sound_out_word(pos, "z", -1)       
	end
})




minetest.register_node("phonics:PaperStart", {
	description = "Paper Start",
	tiles = {
	"white.jpg",
	"white.jpg",
	"nicubunu_Scroll.png",
	"nicubunu_Scroll.png",
	"nicubunu_Scroll.png",
	"nicubunu_Scroll.png",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos)        
		get_page_start_loc(pos)
	end,
	on_punch = function(pos, node, puncher)        
		clear_page(pos)
	end,		
	on_dig = function(pos_dig,node)
		replace_page(pos_dig, "x", 1, "air")
	    replace_page(pos_dig, "x", -1, "air")
	    replace_page(pos_dig, "z", 1, "air")
	    replace_page(pos_dig, "z", -1, "air")
	    replace_column(pos_dig, "air")
	end
})

function clear_page(pos)
	local clear_pos = {} --needed this because the node being passed to revertnode was incremented (must have been by reference
      clear_pos.x = pos.x 
      clear_pos.y = pos.y 
      clear_pos.z = pos.z 

	replace_page(clear_pos, "x", 1, "phonics:BlankPaper")
	replace_page(clear_pos, "x", -1, "phonics:BlankPaper")
	replace_page(clear_pos, "z", 1, "phonics:BlankPaper")
	replace_page(clear_pos, "z", -1, "phonics:BlankPaper")
	replace_column(clear_pos, "phonics:BlankPaper")
	page_start = pos
	page_end = pos
end
	    
minetest.register_node("phonics:PaperFinish", {
	description = "Paper Finish",
	tiles = {
	"white.jpg",
	"white.jpg",
	"finish_line_flag_pin_th.png",
	"finish_line_flag_pin_th.png",
	"finish_line_flag_pin_th.png",
	"finish_line_flag_pin_th.png",},
	is_ground_content = true,
		paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos)
		blank_page(pos)
	end
})
minetest.register_node("phonics:BlankPaper", {
	description = "Blank Paper",
	tiles = {
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"white.jpg",
	"white.jpg",},
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
		local handler = minetest.sound_play("phonics_"..soundname, {gain=gain})
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
--see if there are any sounds next to mouth on this axis.  (or if there is a BlankPage before it.) If not, do nothing.  
	local test_pos = {} 
      test_pos.x = pos1.x 
      test_pos.y = pos1.y 
      test_pos.z = pos1.z 
	if axis == "x" then
		test_pos.x=test_pos.x+direction
	end	
	if axis == "z" then
		test_pos.z=test_pos.z+direction
	end	
	local test_nodename = minetest.env:get_node(test_pos).name 
	local test_nodenamearray = split(test_nodename, ":")
	local test_nodename_prefix = test_nodenamearray[1]
	local test_nodename_suffix = test_nodenamearray[2]
	--see if blank page before it		
	if axis == "x" then
		test_pos.x=test_pos.x-(direction*2)
	end	
	if axis == "z" then
		test_pos.z=test_pos.z-(direction*2)
	end			
	local b4_nodename = minetest.env:get_node(test_pos).name 			
	if b4_nodename ~="phonics:BlankPaper" then	
	   	if test_nodename_prefix ~="phonics" or test_nodename_suffix == "BlankPaper" then 
	   		return
	    end
	end
    
    local row_count = 1
    repeat  --go to next row 1 time    	      
		repeat  --continue sounding on this row until you reach blank paper or a non phonics node
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
			local delay = phonics[nodename_suffix]
			if  delay ~=nil and nodename_prefix =="phonics"  then 		
				local lpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
	              lpos.x = mpos.x 
	              lpos.y = mpos.y 
	              lpos.z = mpos.z 	
				minetest.after(cumulative_delay, activate_node, {lpos, nodename_suffix, phonics[nodename_suffix].length}) 
				cumulative_delay = cumulative_delay + phonics[nodename_suffix].length 
			end
		until nodename_prefix ~="phonics" or nodename_suffix == "BlankPaper"
--if I will find a BlankPaper in this row, then dont look in next row
		local find_blank_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      	find_blank_pos.x = mpos.x 
      	find_blank_pos.y = mpos.y 
      	find_blank_pos.z = mpos.z 	
		repeat
			--is this node BlankPaper?
			local find_blank_nodename = minetest.env:get_node(find_blank_pos).name 
			local find_blank_nodenamearray = split(find_blank_nodename, ":")
			local find_blank_nodename_prefix = find_blank_nodenamearray[1]
			local find_blank_nodename_suffix = find_blank_nodenamearray[2]			
			if find_blank_nodename_suffix == "BlankPaper" then
				return
			end			
			--if not, increment pointer and repeat search
			if axis == "x" then
				find_blank_pos.x=find_blank_pos.x+direction
			end	
			if axis == "z" then
					find_blank_pos.z=find_blank_pos.z+direction
			end			
		until find_blank_nodename_prefix ~="phonics"--prefix not phonics

--we're not done, so search next row for more phonics to sound out
		local new_row_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      	new_row_pos.x = mpos.x 
      	new_row_pos.y = mpos.y 
      	new_row_pos.z = mpos.z 	
		new_row_pos.y=new_row_pos.y-1		
		if nodename_suffix == "BlankPaper" then 
			return
		end
		repeat  --go to the beginning of the new row				
			if axis == "x" then
				new_row_pos.x=new_row_pos.x-direction
			end	
			if axis == "z" then
					new_row_pos.z=new_row_pos.z-direction
			end	
			local new_row_nodename = minetest.env:get_node(new_row_pos).name 
			local new_row_nodenamearray = split(new_row_nodename, ":")
			local new_row_nodename_prefix = new_row_nodenamearray[1]
			local new_row_nodename_suffix = new_row_nodenamearray[2]
			mpos.x = new_row_pos.x 
			mpos.y = new_row_pos.y
			mpos.z = new_row_pos.z
		until new_row_nodename_prefix ~="phonics"
		row_count= row_count +1
	until row_count >2 or nodename_suffix == "BlankPaper"
end

function write_message_to_page(message)
	local start_page_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
    start_page_pos.x = page_start.x 
    start_page_pos.y = page_start.y 
    start_page_pos.z = page_start.z 	
	local start_message_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      start_message_pos.x = page_start.x 
      start_message_pos.y = page_start.y 
      start_message_pos.z = page_start.z 
	write_message_to_page_on_axis(start_message_pos, "x", 1, message)
	write_message_to_page_on_axis(start_message_pos, "x", -1, message)
	write_message_to_page_on_axis(start_message_pos, "z", 1, message)
	write_message_to_page_on_axis(start_message_pos, "z", -1, message)	
end

function write_message_to_page_on_axis(pos, axis, direction,message)
	local page_position = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
    page_position.x = pos.x 
    page_position.y = pos.y 
    page_position.z = pos.z 
    message_index = 1
    --if the first node after the PageStart node is not a phonic, skip everything.
    local first_position = {}    
    first_position.x = pos.x 
    first_position.y = pos.y 
    first_position.z = pos.z 
    if axis=="x" then
    	first_position.x = first_position.x +direction
    end
    if axis=="z" then
    	first_position.z = first_position.z +direction
    end
    local first_nodename = minetest.env:get_node(first_position).name 
	local firstnamearray = split(first_nodename, ":")
	local firstname_prefix = firstnamearray[1]
	if firstname_prefix == "phonics" then  --we have phonics on this axis		      
		repeat
			local current_nodename = minetest.env:get_node(page_position).name 
			local nodenamearray = split(current_nodename, ":")
			local nodename_prefix = nodenamearray[1]
			local nodename_suffix = nodenamearray[2]
			write_page_row(page_position, axis, direction,message)
			page_position.y = page_position.y-1
		until nodename_prefix ~="phonics" or message_index > string.len(message)		
	end
end


function write_page_row(pos, axis, direction, message)
	local replace_pointer = {} --needed this because the node being passed to revertnode was incremented (must have been by reference
	replace_pointer.x = pos.x 
    replace_pointer.y = pos.y 
    replace_pointer.z = pos.z 
	local nodename = minetest.env:get_node(replace_pointer).name 
	if nodename=="phonics:PaperStart" then
		if axis == "x" then
			replace_pointer.x=replace_pointer.x+direction
			new_nodename ="phonics:SayWord" 
			minetest.env:add_node(replace_pointer, {name=new_nodename})	
			replace_pointer.x=replace_pointer.x+direction
		end	
		if axis == "z" then
			replace_pointer.z=replace_pointer.z+direction
			new_nodename ="phonics:SayWord"
			minetest.env:add_node(replace_pointer, {name=new_nodename})	
			replace_pointer.z=replace_pointer.z+direction
		end	
	end	
--1get me node at current location
--2if node prefix is phonics then replace node with next phonic in the message
--3(and have some code behind the scenes automatically bump the message_index)
--4increment the replace pointer
--5repeat 1-4 until node prefix at current location is not phonics	
	repeat
		local nodename = minetest.env:get_node(replace_pointer).name 
		local nodenamearray = split(nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		if nodename_prefix =="phonics"  then 			
			if new_nodename =="phonics:BlankPaper" then
			--if we had a space between words then inject sayword block into stream
				new_nodename ="phonics:SayWord"
				minetest.env:add_node(replace_pointer, {name=new_nodename})				
			else
				new_nodename = get_next_phonic_in_message(message)
				minetest.env:add_node(replace_pointer, {name=new_nodename})			
			end	
			if axis == "x" then
				replace_pointer.x=replace_pointer.x+direction
			end	
			if axis == "z" then
				replace_pointer.z=replace_pointer.z+direction
			end				
		end
	until nodename_prefix ~="phonics" or message_index > string.len(message)	
end

function get_next_phonic_in_message(message)
--and have some code behind the scenes automatically bump the message_index	
	string.len(message)
	if message_index <= string.len(message) then
		local current_char_in_message = string.sub(message,message_index,message_index)	
		phonic_builder = current_char_in_message
		--if currentchar=" " then just set cpim to blankPaper and skip all the char business"
		if current_char_in_message==" " then 
			current_phonic_in_message = "phonics:BlankPaper"
		elseif current_char_in_message=="." then 
			current_phonic_in_message = "phonics:period"
		elseif current_char_in_message=="?" then 
			current_phonic_in_message = "phonics:question_mark"			
		elseif current_char_in_message=="!" then 
			current_phonic_in_message = "phonics:exclamation_point"						
		else
			if current_char_in_message == "0" or current_char_in_message == "_" then			
				message_index = message_index +1
				current_char_in_message = string.sub(message,message_index,message_index)		
				phonic_builder = phonic_builder..current_char_in_message
			end	
			char_after_current_char = string.sub(message,message_index+1,message_index+1)
			third_char = string.sub(message,message_index+2,message_index+2)
			two_chars = current_char_in_message..char_after_current_char
			three_chars = two_chars..third_char		 
			if two_char_phonics[two_chars] ~= nil then										
				phonic_builder = phonic_builder..char_after_current_char
				message_index = message_index +1
			end	
			if three_char_phonics[three_chars] ~= nil then						
				phonic_builder = phonic_builder..string.sub(message,message_index+1,message_index+2)
				message_index = message_index +2
			end			
			current_phonic_in_message = "phonics:"..phonic_builder
		end
		message_index = message_index +1	
	else
		current_phonic_in_message = "phonics:BlankPaper"
	end 	
	return current_phonic_in_message			
end

function replace_page(pos, axis, direction,new_nodename)
	local replace_row_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      replace_row_pos.x = pos.x 
      replace_row_pos.y = pos.y 
      replace_row_pos.z = pos.z 
	repeat
		local current_nodename = minetest.env:get_node(replace_row_pos).name 
		local nodenamearray = split(current_nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		replace_page_row(replace_row_pos, axis, direction,new_nodename)
		replace_row_pos.y = replace_row_pos.y-1
	until nodename_prefix ~="phonics"	
end

function replace_column(pos, new_nodename)
	replace_column_pos= pos
	repeat
		local current_nodename = minetest.env:get_node(replace_column_pos).name 
		local nodenamearray = split(current_nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		if nodename_prefix =="phonics" then	
			if new_nodename =="air" then					
				minetest.env:add_node(replace_column_pos, {name=new_nodename})			
			end
			if new_nodename =="phonics:BlankPaper" and current_nodename ~="phonics:PaperStart" then					
				minetest.env:add_node(replace_column_pos, {name=new_nodename})			
			end
		end
		replace_column_pos.y = replace_column_pos.y-1
	until nodename_prefix ~="phonics"
end

function replace_page_row(pos, axis, direction, new_nodename)
	local replace_pointer = {} --needed this because the node being passed to revertnode was incremented (must have been by reference
	replace_pointer.x = pos.x 
    replace_pointer.y = pos.y 
    replace_pointer.z = pos.z 	
	repeat
		if axis == "x" then
			replace_pointer.x=replace_pointer.x+direction
		end	
		if axis == "z" then
			replace_pointer.z=replace_pointer.z+direction
		end	
		local nodename = minetest.env:get_node(replace_pointer).name 
		local nodenamearray = split(nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		if  nodename_prefix =="phonics"  then 		
			minetest.env:add_node(replace_pointer, {name=new_nodename})
		end
	until nodename_prefix ~="phonics"	
end

function get_page_start_loc(pos)
	page_start = pos
end

function blank_page(pos)
	page_end = pos
	if page_start ~= nil and math.abs(page_start.x-page_end.x) <20 and math.abs(page_start.y-page_end.y) <20 and math.abs(page_start.z-page_end.z) <20 then 
		if page_end.y <= page_start.y then  --if the page end block was placed at or below page start block
			if page_end.x == page_start.x then
				buildwall(page_start.z, pos.z, page_start.y, pos.y, "x", pos.x, "phonics:BlankPaper")	
			end
			if page_end.z == page_start.z then  
				buildwall(page_start.x, pos.x, page_start.y, pos.y, "z", pos.z, "phonics:BlankPaper")	
			end	
		end	
	end 
end

function buildwall(hstart, hend, ystart, yend, haxis, haxis_fixed, nodename)	
	repeat
	buildrow(hstart, hend, ystart, haxis, haxis_fixed, nodename)
	ystart = ystart -1
	until ystart < yend
end

function buildrow(hstart, hend, y, haxis, haxis_fixed, nodename)
	local hpos = math.min(hstart, hend)
	local hmax = math.max(hstart, hend)
	local current_pos={}
	current_pos.y = y
	repeat
		if haxis =="x" then
			current_pos.z = hpos
			current_pos.x = haxis_fixed		
		end
		if haxis =="z" then
			current_pos.x = hpos
			current_pos.z = haxis_fixed		
		end	
		if minetest.env:get_node(current_pos).name ~= "phonics:PaperStart" then   --leave paperstart node there.
			minetest.env:add_node(current_pos, {name=nodename})
		end
		hpos = hpos +1
	until hpos> hmax
end

minetest.register_chatcommand("w", {
	params = "<message>",
	description = "Write phonics message on a page",
	privs = {shout=true},
	func = function(name, param)
		if page_start == nil or page_end == nil then minetest.chat_send_player(name, "You need to create a page first") return end
		write_message(string.lower(param))
	end,		})
	
function write_message(param)
	write_message_to_page(param)		
end	
 
print("Phonics Mod Loaded!")
 	--minetest.env:punch_node(pos) 
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
