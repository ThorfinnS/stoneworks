-- [MOD] StoneWorks [stoneworks] (1.2) by TumeniNodes

stoneworks = {}

-- Register stoneworks.
-- Node will be called stoneworks:arches_<subname>


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

function reg_node(namer,grouper,fixer)
	local a,b, desc
	a,b=string.find(description, ' Arches')
	desc=string.sub(description,1, a)
	if grouper=='a' then
		groups.arches = 1
		desc=desc..'Arch'
	elseif grouper=='w' then
		groups.thin_wall = 1
		desc=desc..'Thin Wall'
	else
		desc=desc..'Mini'
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

local i,n = "stoneworks:mini_" .. subname,''
local fixer = {
	{-0.1875, -0.1875, -0.1875, 0.1875, 0.1875, 0.1875}
	}
reg_node(i,'i',fixer)
minetest.register_craft({
	type = "shapeless",
	output = i.. ' 54',
	recipe = {recipeitem,recipeitem}
})

-- stoneworks.reg_dressed(subname, i, recipeitem, groups, images, description, sounds)


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
	{-0.5, -0.5, -0.5, 0.5, -0.125, 0.5},
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{i,i,i},{i,i,i},{i,i,i}},i,9)
local f1=namer


namer="stoneworks:arches_low_wall" .. subname
fixer={
	{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
}
reg_node(namer,'a',fixer)
stoneworks.reg_recipe(namer,{{f1,f1}},i,18)
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
stoneworks.reg_recipe(namer,{{w1},{q1},{q1}},i,11)
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
