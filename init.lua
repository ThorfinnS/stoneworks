-- [MOD] StoneWorks [stoneworks] (1.2) by TumeniNodes

stoneworks = {}

-- Register stoneworks.
-- Node will be called stoneworks:arches_<subname>

function first2upper(in_)
	return (in_:gsub("^%l", in_.upper))
end

function mod_support(mod,subname, recipeitem, groups, images, description, junk, sounds)
	if subname==nil then
		local i=string.find(mod,':',2)
		if i~=nil then -- it's composite mod:node
			subname=string.sub(mod,i+1)
			mod=string.sub(mod,1,i-1)
		else
			minetest.log("warning","No node specified-"..mod)
			return
		end
	end
	local mod_path=minetest.get_modpath(mod)
	if mod_path then 
		if description=='' or description==nil then
		description=string.gsub(" "..string.gsub(subname,'_',' '), "%W%l", string.upper):sub(2)
		end
		if images=='' or images== nil then
			images={mod..'_'..subname..'.png'}
		end
		if recipeitem=='' or recipeitem==nil then
			recipeitem=mod..':'..subname
		end
		if groups=='woodlike' or groups=='w' then 
			groups={snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3}
		elseif groups=='stonelike' or groups=='s' or groups== nil or groups=='' then
			groups={cracky = 3}
		elseif groups=='sandstonelike' or groups=='ss' then
			groups={cracky = 2}
		elseif groups=='obsidianlike' or groups=='o' then
			groups={cracky = 1, level = 2}
		end
		if sounds=='woodlike' or sounds=='w' or sounds == 'wood' then
			sounds=default.node_sound_wood_defaults()
		elseif sounds=='stonelike' or sounds=='s' or sounds=='' or sounds==nil then
			sounds=default.node_sound_stone_defaults()
		end
		if(minetest.registered_items[mod..':'..subname] ~= nil) then
			minetest.log('....Registering nodes--'..mod..':'..subname)
			stoneworks.register_arches_and_thin_wall(mod..'_'..subname, recipeitem, groups, images, 
				description, junk, sounds)
		else
			minetest.log("warning","Not registered node-"..mod..':'..subname)
		end
	end
end

function cool_tree_support(in_)
	local cool_path = minetest.get_modpath(in_)
	if cool_path then
		local gif_=in_..'_wood.png'
		stoneworks.register_arches_and_thin_wall(in_, in_..':wood',
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			{gif_},
			first2upper(in_),
			in_,
			default.node_sound_wood_defaults())
	end
end


function baked_clay_support(in_)
	local baked_path = minetest.get_modpath('bakedclay')
	if baked_path then
		local gif_='baked_clay_'..in_..'.png'
		stoneworks.register_arches_and_thin_wall('bakedclay_'..in_, 'bakedclay:'..in_,
			{cracky = 3},
			{gif_},
			first2upper(in_)..' Baked Clay',
			in_,
			default.node_sound_stone_defaults())
	end
end


function stoneworks.reg_recipe(name_, rec, i, num)
	minetest.register_craft({
		output = name_,
		recipe = rec
	})
	if num>0 then
		minetest.register_craft({
			output=i..' '..tostring(num),
			recipe={{name_}}
		})
	end
end


function stoneworks.register_arches_and_thin_wall(subname, recipeitem, groups, images, 
	description, junk, sounds)
	

local function reg_node(namer,grouper,fixer)
-- out('namer',namer)
-- out('grouper',grouper)
	local a, desc = 1, description
	a=string.find(description, ' Arches')
	if a~= nil then
		desc=string.sub(description,1, a-1)
	end
	if grouper=='a' then
		groups.arches = 1
		desc=desc..' Arch'
	elseif grouper=='w' then
		groups.thin_wall = 1
		desc=desc..' Thin Wall'
	elseif grouper=='m' then
		desc=desc..' Mini'
	end
	minetest.register_node(namer, {
		description = desc,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		legacy_facedir_simple = true,
		groups = groups,
		is_ground_content = false,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = fixer
		}
	})
end

local i,n = "stoneworks:".. subname..'_mini',''
local fixer = {
	{-0.1875, -0.1875, -0.1875, 0.1875, 0.1875, 0.1875}
	}
reg_node(i,'m',fixer)
minetest.register_craft({
	type = "shapeless",
	output = i.. ' 54',
	recipe = {recipeitem,recipeitem}
})


local namer="stoneworks:thin_wall_high_arch" .. subname
local fixer={
	{-0.5, -0.0625, -0.1875, 0.5, 0.5, 0.1875},
	{0.0625, -0.125, -0.1875, 0.5, -0.0625, 0.1875},
	{-0.5, -0.125, -0.1875, -0.0625, -0.0625, 0.1875},
	{-0.5, -0.1875, -0.1875, -0.1875, -0.125, 0.1875},
	{0.1875, -0.1875, -0.1875, 0.5, -0.125, 0.1875},
	{0.3125, -0.3125, -0.1875, 0.5, -0.1875, 0.1875},
	{-0.5, -0.3125, -0.1875, -0.3125, -0.1875, 0.1875},
	{-0.5, -0.4375, -0.1875, -0.375, -0.25, 0.1875},
	{0.375, -0.4375, -0.1875, 0.5, -0.25, 0.1875},
	{0.4375, -0.5, -0.1875, 0.5, -0.3125, 0.1875},
	{-0.5, -0.5, -0.1875, -0.4375, -0.3125, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{i,i,i},{i,i,i},{i,n,i}},i,8)
local hi=namer


namer="stoneworks:thin_wall_low_arch" .. subname
fixer={
	{-0.5, -0.0625, -0.1875, 0.5, 0.125, 0.1875},
	{0.0625, -0.125, -0.1875, 0.5, -0.0625, 0.1875},
	{-0.5, -0.125, -0.1875, -0.0625, -0.0625, 0.1875},
	{-0.5, -0.1875, -0.1875, -0.1875, -0.125, 0.1875},
	{0.1875, -0.1875, -0.1875, 0.5, -0.125, 0.1875},
	{0.3125, -0.3125, -0.1875, 0.5, -0.1875, 0.1875},
	{-0.5, -0.3125, -0.1875, -0.3125, -0.1875, 0.1875},
	{-0.5, -0.4375, -0.1875, -0.375, -0.25, 0.1875},
	{0.375, -0.4375, -0.1875, 0.5, -0.25, 0.1875},
	{0.4375, -0.5, -0.1875, 0.5, -0.3125, 0.1875},
	{-0.5, -0.5, -0.1875, -0.4375, -0.3125, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{i,i,i},{i,n,i}},i,5)
local lo=namer


namer="stoneworks:arches_lower_wall" .. subname
fixer={
	-- {-0.5, -0.5, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,i,i},{i,i,i},{i,i,i}},i,9)
local f1=namer


namer="stoneworks:arches_low_wall" .. subname
fixer={
	-- {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1},{f1}},i,18)
local f2=namer


namer="stoneworks:thin_wall_lower" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.5, -0.125, 0.1875}
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{i,i,i}},i,3)
local w1=namer
stoneworks.reg_recipe(f1,{{w1,w1,w1}},i,0)


namer="stoneworks:thin_wall_low" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.5, 0.125, 0.1875}
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{w1},{w1}},i,6)
stoneworks.reg_recipe(namer,{{i,i,i},{i,i,i}},i,0)
local w2=namer


namer="stoneworks:thin_wall_high" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{w1},{w1},{w1}},i,9)
stoneworks.reg_recipe(namer,{{w2},{w1}},i,0)
stoneworks.reg_recipe(namer,{{w1},{w2}},i,0)
local w3=namer


namer="stoneworks:thin_wall_lower_quad" .. subname
fixer={
	{-0.1875, -0.5, -0.5, 0.1875, -0.125, 0.5},
	{-0.5, -0.5, -0.1875, 0.5, -0.125, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{n,i,n},{i,i,i},{n,i,n}},i,5)
local q1=namer


namer="stoneworks:thin_wall_low_quad" .. subname
fixer={
	{-0.1875, -0.5, -0.5, 0.1875, 0.125, 0.5},
	{-0.5, -0.5, -0.1875, 0.5, 0.125, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{q1},{q1}},i,10)
local q2=namer


namer="stoneworks:thin_wall_high_quad" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
	{-0.1875, -0.5, -0.5, 0.1875, 0.5, 0.5},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{q1},{q1},{q1}},i,15)
stoneworks.reg_recipe(namer,{{q2},{q1}},i,0)
stoneworks.reg_recipe(namer,{{q1},{q2}},i,0)


namer="stoneworks:thin_wall_high_low_quad" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.5, 0.125, 0.1875},
	{-0.1875, -0.5, -0.5, 0.1875, 0.5, 0.5},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{w1},{q1},{q1}},i,13)
stoneworks.reg_recipe(namer,{{w1},{q2}},i,0)


namer="stoneworks:thin_wall_lower_T" .. subname
fixer={
	{-0.1875, -0.5, -0.5, 0.1875, -0.125, 0.1875},
	{-0.5, -0.5, -0.1875, 0.5, -0.125, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{i,i,i},{n,i,n}},i,4)
local t1=namer


namer="stoneworks:thin_wall_low_T" .. subname
fixer={
	{-0.1875, -0.5, -0.5, 0.1875, 0.125, 0.1875},
	{-0.5, -0.5, -0.1875, 0.5, 0.125, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{t1},{t1}},i,8)
local t2=namer


namer="stoneworks:thin_wall_high_T" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
	{-0.1875, -0.5, -0.5, 0.1875, 0.5, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{t2},{t1}},i,12)
stoneworks.reg_recipe(namer,{{t1},{t2}},i,0)
stoneworks.reg_recipe(namer,{{t1},{t1},{t1}},i,0)


namer="stoneworks:thin_wall_lower_corner" .. subname
fixer={
	{-0.1875, -0.5, -0.1875, 0.5, -0.125, 0.1875},
	{-0.1875, -0.5, -0.1875, 0.1875, -0.125, 0.5},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{i,n},{i,i}},i,3)
local c1=namer


namer="stoneworks:thin_wall_low_corner" .. subname
fixer={
	{-0.1875, -0.5, -0.1875, 0.5, 0.125, 0.1875},
	{-0.1875, -0.5, -0.1875, 0.1875, 0.125, 0.5},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{c1},{c1}},i,6)
local c2=namer


namer="stoneworks:thin_wall_high_corner" .. subname
fixer={
	{-0.5, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
	{-0.1875, -0.5, -0.5, 0.1875, 0.5, 0.1875},
}
reg_node(namer,'w',fixer)
stoneworks.reg_recipe(namer,{{c1},{c1},{c1}},i,9)
stoneworks.reg_recipe(namer,{{c2},{c1}},i,0)
stoneworks.reg_recipe(namer,{{c1},{c2}},i,0)


namer="stoneworks:arches_low_quad" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, -0.0625},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, -0.1875},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, -0.3125},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{0.375, -0.4375, -0.5, 0.5, -0.25, -0.375},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, -0.4375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375},
	{0.0625, -0.125, 0.0625, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, 0.1875, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, -0.3125, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, -0.375, -0.25, 0.5},
	{0.375, -0.4375, 0.375, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, -0.4375, -0.3125, 0.5},
	{0.3125, -0.3125, 0.3125, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, 0.4375, 0.5, -0.3125, 0.5},
	{-0.5, -0.1875, 0.1875, -0.1875, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, -0.0625, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,n,i},{n,f1,n},{i,n,i}},i,13)
local qa1=namer


namer="stoneworks:arches_low_corner" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, -0.0625},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, -0.1875},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{0.375, -0.4375, -0.5, 0.5, -0.25, -0.375},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, -0.4375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, 0.5, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, 0.5, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, 0.5, -0.3125, 0.5},
	{0.375, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, -0.5, 0.5, 0, 0.5},
	{-0.5, -0.1875, 0.1875, 0.5, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, 0.5, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{n,i},{i,qa1}},i,15)


namer="stoneworks:arches_low_T" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, -0.0625},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, -0.1875},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, -0.3125},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{0.375, -0.4375, -0.5, 0.5, -0.25, -0.375},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, -0.4375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, -0.3125, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, -0.375, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, -0.4375, -0.3125, 0.5},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, -0.5, 0.5, 0, 0.5},
	{-0.5, -0.1875, 0.1875, -0.1875, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, -0.0625, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,qa1}},i,14)


namer="stoneworks:arches_high_quad" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, -0.0625},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, -0.1875},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, -0.3125},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{0.375, -0.4375, -0.5, 0.5, -0.25, -0.375},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, -0.4375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375},
	{0.0625, -0.125, 0.0625, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, 0.1875, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, -0.3125, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, -0.375, -0.25, 0.5},
	{0.375, -0.4375, 0.375, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, -0.4375, -0.3125, 0.5},
	{0.3125, -0.3125, 0.3125, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, 0.4375, 0.5, -0.3125, 0.5},
	{-0.5, -0.1875, 0.1875, -0.1875, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, -0.0625, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1},{qa1}},i,22)
local qa2=namer


namer="stoneworks:arches_high_corner" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, -0.0625},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, -0.1875},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{0.375, -0.4375, -0.5, 0.5, -0.25, -0.375},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, -0.4375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, 0.5, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, 0.5, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, 0.5, -0.3125, 0.5},
	{0.375, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, -0.5, 0.5, 0, 0.5},
	{-0.5, -0.1875, 0.1875, 0.5, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, 0.5, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{n,i},{i,qa2}},i,24)


namer="stoneworks:arches_low" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, 0.5},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, 0.5},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, 0.5},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, 0.5},
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{lo,lo,lo}},i,15)
stoneworks.reg_recipe(namer,{{i,qa1,i}},i,0)


namer="stoneworks:arches_high_T" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, -0.0625},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, -0.1875},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, -0.3125},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{0.375, -0.4375, -0.5, 0.5, -0.25, -0.375},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, -0.4375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, -0.3125, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, -0.375, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, -0.4375, -0.3125, 0.5},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, -0.5, 0.5, 0, 0.5},
	{-0.5, -0.1875, 0.1875, -0.1875, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, -0.0625, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,qa2}},i,23)


namer="stoneworks:arches_low_cove" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5}, --top slice
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5}, --2nd slice
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5}, --3rd slice
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5}, --4th slice
	{0.375, -0.4375, -0.5, 0.5, -0.3125, 0.5}, --5th slice
	{0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},--6th slice
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1},{w1}},i,12)


namer="stoneworks:arches_low_cove_corner_outside" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1},{i}},i,10)
local cco=namer

namer="stoneworks:arches_low_cove_corner_inside" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.125, 0.5},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, 0.5, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, 0.5, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, 0.5, -0.3125, 0.5},
	{0.375, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, -0.5, 0.5, 0, 0.5},
	{-0.5, -0.1875, 0.1875, 0.5, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, 0.5, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,f1},{i,w1}},i,14)
local cci=namer


namer="stoneworks:arches_high_cove" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},--1
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},--2
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},--3
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},--4
	{0.375, -0.4375, -0.5, 0.5, -0.3125, 0.5},--5
	{0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},--6
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1},{f1},{w1}},i,21)
stoneworks.reg_recipe(namer,{{f2},{w1}},i,0)


namer="stoneworks:arches_high_cove_corner_outside" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, -0.0625},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, -0.1875},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, -0.3125},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, -0.375},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, -0.4375}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1},{f1},{i}},i,19)
stoneworks.reg_recipe(namer,{{f2},{i}},i,0)
stoneworks.reg_recipe(namer,{{f1},{cco}},i,0)

namer="stoneworks:arches_high_cove_corner_inside" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{-0.5, -0.3125, 0.3125, 0.5, -0.1875, 0.5},
	{-0.5, -0.4375, 0.375, 0.5, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{-0.5, -0.5, 0.4375, 0.5, -0.3125, 0.5},
	{0.375, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{0.4375, -0.5, -0.5, 0.5, 0, 0.5},
	{-0.5, -0.1875, 0.1875, 0.5, -0.125, 0.5},
	{-0.5, -0.125, 0.0625, 0.5, -0.0625, 0.5}
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,f2},{i,w1}},i,14)
stoneworks.reg_recipe(namer,{{f1},{cci}},i,0)


namer="stoneworks:arches_high" .. subname
fixer={
	{-0.5, -0.0625, -0.5, 0.5, 0.5, 0.5},
	{0.0625, -0.125, -0.5, 0.5, -0.0625, 0.5},
	{-0.5, -0.125, -0.5, -0.0625, -0.0625, 0.5},
	{-0.5, -0.1875, -0.5, -0.1875, -0.125, 0.5},
	{0.1875, -0.1875, -0.5, 0.5, -0.125, 0.5},
	{0.3125, -0.3125, -0.5, 0.5, -0.1875, 0.5},
	{-0.5, -0.3125, -0.5, -0.3125, -0.1875, 0.5},
	{-0.5, -0.4375, -0.5, -0.375, -0.25, 0.5},
	{0.375, -0.4375, -0.5, 0.5, -0.25, 0.5},
	{0.4375, -0.5, -0.5, 0.5, -0.3125, 0.5},
	{-0.5, -0.5, -0.5, -0.4375, -0.3125, 0.5},
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{hi,hi,hi}},i,24)
stoneworks.reg_recipe(namer,{{i,qa2,i}},i,0)


--turn back to blocks
minetest.register_craft({
	type = "shapeless",
	output = recipeitem,
	recipe = {f1,f1,f1}
})

minetest.register_craft({
	type = "shapeless",
	output = recipeitem,
	recipe = {w3,w3,w3}
})

end




-- Register arches and thin_wall
stoneworks.register_arches_and_thin_wall("wood", "default:wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_wood.png"},
		"Wooden Arches",
		"Wooden Thin Wall",
		default.node_sound_wood_defaults())

stoneworks.register_arches_and_thin_wall("junglewood", "default:junglewood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_junglewood.png"},
		"Junglewood Arches",
		"Junglewood Thin Wall",
		default.node_sound_wood_defaults())

stoneworks.register_arches_and_thin_wall("pine_wood", "default:pine_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_pine_wood.png"},
		"Pine Wood Arches",
		"Pine Wood Thin Wall",
		default.node_sound_wood_defaults())

stoneworks.register_arches_and_thin_wall("acacia_wood", "default:acacia_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_acacia_wood.png"},
		"Acacia Wood Arches",
		"Acacia Wood Thin Wall",
		default.node_sound_wood_defaults())

stoneworks.register_arches_and_thin_wall("aspen_wood", "default:aspen_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_aspen_wood.png"},
		"Aspen Wood Arches",
		"Aspen Wood Thin Wall",
		default.node_sound_wood_defaults())

stoneworks.register_arches_and_thin_wall("brick", "default:brick",
		{cracky = 3},
		{"default_brick.png"},
		"Brick Arches",
		"Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("clay", "default:clay",
		{cracky = 3},
		{"default_clay.png"},
		"Clay Arches",
		"Clay Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("stone", "default:stone",
		{cracky = 3},
		{"default_stone.png"},
		"Stone Arches",
		"Stone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("stonebrick", "default:stonebrick",
		{cracky = 3},
		{"default_stone_brick.png"},
		"Stone Brick Arches",
		"Stone Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("stone_block", "default:stone_block",
		{cracky = 3},
		{"default_stone_block.png"},
		"Stone Block Arches",
		"Stone Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("cobble", "default:cobble",
		{cracky = 3},
		{"default_cobble.png"},
		"Cobblestone Arches",
		"Cobblestone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("mossycobble", "default:mossycobble",
		{cracky = 3},
		{"default_mossycobble.png"},
		"Mossy Cobblestone Arches",
		"Mossy Cobblestone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_cobble", "default:desert_cobble",
		{cracky = 3},
		{"default_desert_cobble.png"},
		"Desert Cobble Arches",
		"Desert Cobble Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_stone", "default:desert_stone",
		{cracky = 3},
		{"default_desert_stone.png"},
		"Desertstone Arches",
		"Desertstone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_stonebrick", "default:desert_stonebrick",
		{cracky = 3},
		{"default_desert_stone_brick.png"},
		"Desertstone Brick Arches",
		"Desertstone Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_stone_block", "default:desert_stone_block",
		{cracky = 3},
		{"default_desert_stone_block.png"},
		"Desertstone Block Arches",
		"Desertstone Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_sandstone", "default:desert_sandstone",
		{crumbly = 1, cracky = 3},
		{"default_desert_sandstone.png"},
		"Desert Sandstone Arches",
		"Desert Sandstone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_sandstone_brick", "default:desert_sandstone_brick",
		{cracky = 2},
		{"default_desert_sandstone_brick.png"},
		"Desert Sandstone Brick Arches",
		"Desert Sandstone Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("desert_sandstone_block", "default:desert_sandstone_block",
		{cracky = 2},
		{"default_desert_sandstone_block.png"},
		"Desert Sandstone Block Arches",
		"Desert Sandstone Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("sandstone", "default:sandstone",
		{crumbly = 1, cracky = 3},
		{"default_sandstone.png"},
		"Sandstone Arches",
		"Sandstone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("sandstonebrick", "default:sandstonebrick",
		{cracky = 2},
		{"default_sandstone_brick.png"},
		"Sandstone Brick Arches",
		"Sandstone Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("sandstone_block", "default:sandstone_block",
		{cracky = 2},
		{"default_sandstone_block.png"},
		"Sandstone Block Arches",
		"Sandstone Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("silver_sandstone", "default:silver_sandstone",
		{crumbly = 1, cracky = 3},
		{"default_silver_sandstone.png"},
		"Silver Sandstone Arches",
		"Silver Sandstone Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("silver_sandstone_brick", "default:silver_sandstone_brick",
		{cracky = 2},
		{"default_silver_sandstone_brick.png"},
		"Silver Sandstone Brick Arches",
		"Silver Sandstone Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("silver_sandstone_block", "default:silver_sandstone_block",
		{cracky = 2},
		{"default_silver_sandstone_block.png"},
		"Silver Sandstone Block Arches",
		"Silver Sandstone Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("obsidian", "default:obsidian",
		{cracky = 1, level = 2},
		{"default_obsidian.png"},
		"Obsidian Arches",
		"Obsidian Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("obsidianbrick", "default:obsidianbrick",
		{cracky = 1, level = 2},
		{"default_obsidian_brick.png"},
		"Obsidian Brick Arches",
		"Obsidian Brick Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("obsidian_block", "default:obsidian_block",
		{cracky = 1, level = 2},
		{"default_obsidian_block.png"},
		"Obsidian Block Arches",
		"Obsidian Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("bronzeblock", "default:bronzeblock",
		{cracky = 1, level = 2},
		{"default_bronze_block.png"},
		"Bronze Block Arches",
		"Bronze Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("coalblock", "default:coalblock",
		{cracky = 1, level = 2},
		{"default_coal_block.png"},
		"Coal Block Arches",
		"Coal Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("copperblock", "default:copperblock",
		{cracky = 1, level = 2},
		{"default_copper_block.png"},
		"Copper Block Arches",
		"Copper Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("diamondblock", "default:diamondblock",
		{cracky = 1, level = 2},
		{"default_diamond_block.png"},
		"Diamond Block Arches",
		"Diamond Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("goldblock", "default:goldblock",
		{cracky = 1, level = 2},
		{"default_gold_block.png"},
		"Gold Block Arches",
		"Gold Block Thin Wall",
		default.node_sound_stone_defaults())

--[[stoneworks.register_arches_and_thin_wall("ironblock", "default:ironblock",
		{cracky = 1, level = 2},
		{"default_iron_block.png"},
		"Iron Block Arches",
		"Iron Block Thin Wall",
		default.node_sound_stone_defaults())]]--

stoneworks.register_arches_and_thin_wall("meseblock", "default:meseblock",
		{cracky = 1, level = 2},
		{"default_mese_block.png"},
		"Mese Block Arches",
		"Mese Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("steelblock", "default:steelblock",
		{cracky = 1, level = 2},
		{"default_steel_block.png"},
		"Steel Block Arches",
		"Steel Block Thin Wall",
		default.node_sound_stone_defaults())

stoneworks.register_arches_and_thin_wall("tinblock", "default:tinblock",
		{cracky = 1, level = 2},
		{"default_tin_block.png"},
		"Tin Block Arches",
		"Tin Block Thin Wall",
		default.node_sound_stone_defaults())

if minetest.settings:get_bool("cool_trees_support") ~= false then
	minetest.log('LOADING Cool Trees Support for Stoneworks')
	cool_tree_support('birch')
	cool_tree_support('cherrytree')
	cool_tree_support('chestnuttree')
	cool_tree_support('clementinetree')
	cool_tree_support('ebony')
	cool_tree_support('jacaranda')
	cool_tree_support('larch')
	cool_tree_support('lemontree')
	cool_tree_support('mahogany')
	cool_tree_support('palm')
	minetest.log('LOADED Cool Trees Support for Stoneworks')
end

if minetest.settings:get_bool("bakedclay_support") ~= false then
	minetest.log('LOADING Baked Clay Support for Stoneworks')
	baked_clay_support('black')
	baked_clay_support('blue')
	baked_clay_support('brown')
	baked_clay_support('cyan')
	baked_clay_support('dark_green')
	baked_clay_support('dark_grey')
	baked_clay_support('green')
	baked_clay_support('grey')
	baked_clay_support('magenta')
	baked_clay_support('orange')
	baked_clay_support('pink')
	baked_clay_support('red')
	baked_clay_support('violet')
	baked_clay_support('white')
	baked_clay_support('yellow')
	minetest.log('LOADED Baked Clay Support for Stoneworks')
end

if minetest.settings:get_bool("darkage_support") ~= false then
	minetest.log('LOADING Darkage Support for Stoneworks')
	local mod,w,s,o='darkage','woodlike','stonelike','obsidianlike'
-- mod_support(modname, subname, recipeitem, groups, images, description, junk, sounds)
	mod_support(mod,'basalt_brick','',{cracky = 3, stone = 2})
	-- mod_support("default:stonebrick",'',s,'default_stone_brick.png')
	mod_support("darkage:stone_brick")
	mod_support("darkage:gneiss")
	mod_support(mod,"marble",'',{cracky = 3, stone = 1})
	mod_support(mod,"cobble_with_plaster","darkage:cobble_with_plaster",{cracky=3, not_cuttable=1},
		{"darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_D.png)", "darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_B.png)", 
		"darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_C.png)", "darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_A.png)", 
		"default_cobble.png", "darkage_chalk.png"},'Cobblestone With Plaster','',s)
	mod_support(mod,"ors_brick","",{cracky = 3, stone = 2},'','Old Red Sandstone Brick')
	mod_support(mod,"chalked_bricks","darkage:chalked_bricks",{cracky = 2, stone = 1})
	mod_support(mod,"chalked_bricks_with_plaster","darkage:chalked_bricks_with_plaster",{cracky=3, not_cuttable=1},{"darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_D.png)", "darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_B.png)", 
		"darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_C.png)", "darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_A.png)", 
		"darkage_chalked_bricks.png", "darkage_chalk.png"})
	minetest.log('LOADED Darkage Support for Stoneworks')
end



minetest.register_node("stoneworks:highironfence", {
	description = "StoneWorks high ironfence",
	drawtype = "nodebox",
	tiles = {"stoneworks_ironfence_side.png", "stoneworks_ironfence_side.png",
		"stoneworks_ironfence_side.png", "stoneworks_ironfence_side.png",
		"stoneworks_ironfence.png", "stoneworks_ironfence.png"},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	groups = {cracky=3, stone=2},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.0625, 0.5, 0.5, 0},
		}
	}
})

minetest.register_node("stoneworks:lowironfence", {
	description = "StoneWorks low ironfence",
	drawtype = "nodebox",
	tiles = {"stoneworks_ironfence_side.png", "stoneworks_ironfence_side.png",
		"stoneworks_ironfence_side.png", "stoneworks_ironfence_side.png",
		"stoneworks_ironfence.png", "stoneworks_ironfence.png"},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	groups = {cracky=3, stone=2},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.875, -0.0625, 0.5, -0.5, 0},
		}
	}
})

minetest.register_node("stoneworks:highlowironfence", {
	description = "StoneWorks Highlow ironfence",
	drawtype = "nodebox",
	tiles = {"stoneworks_ironfence_side.png", "stoneworks_ironfence_side.png",
		"stoneworks_ironfence_side.png", "stoneworks_ironfence_side.png",
		"stoneworks_ironfence.png", "stoneworks_ironfence.png"},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	groups = {cracky=3, stone=2},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.875, -0.0625, 0.5, 1, 0},
		}
	}
})
