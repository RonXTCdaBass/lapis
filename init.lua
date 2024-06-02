-- mods/lapis/init.lua
-- ===================
-- See LICENSE.txt for licensing and README.md for other information.

-- load support for intllib
local modpath = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator("lapis")

-- Lapis Lazuli Ore
minetest.register_node("lapis:stone_with_lapis", {
	description = S("Lapis Lazuli Ore"),
	tiles = {"default_stone.png^lapis_mineral_lapislazuli.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 5,
		items = {
			{
				items = {'lapis:lapis 2'},  --The first and second drops ever
			},
			{
				items = {'lapis:lapis'},    --The 3rd drops with a 1/2 chance
				rarity = 2,
			},
			{
				items = {'lapis:lapis'},    --The 4th drops with a 1/3 chance
				rarity = 3,
			},
			{
				items = {'lapis:lapis'},    --The 5th drops with a 1/8 chance
				rarity = 8,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

-- Lapis Item
minetest.register_craftitem("lapis:lapis", {
	description = S("Lapis Lazuli"),
	inventory_image = "lapis_lapislazuli.png",
})

-- Lapis Block
minetest.register_node("lapis:lapisblock", {
	description = S("Lapis Lazuli Block"),
	tiles = {"lapis_lapislazuliblock.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- Lapis Block Crafting
minetest.register_craft({
	output = 'lapis:lapisblock',
	recipe = {
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
	}
})

-- Lapis Items from Lapis Block Crafting
minetest.register_craft({
	output = 'lapis:lapis 9',
	recipe = {
		{'lapis:lapisblock'},
	}
})

-- Ore generation
-- -128 <-> -255
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lapis:stone_with_lapis",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	height_min     = -255,
	height_max     = -128,
})

-- -256 <-> -31000
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lapis:stone_with_lapis",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 4,
	height_min     = -31000,
	height_max     = -256,
})


-- Blue dye crafting
minetest.register_craft({
	output = 'dye:blue 2',
	recipe = {
		{'lapis:lapis'},
	}
})

-- NEW Stairs, Slab and more ...

stairs.register_stair(
	"lapis:lapisblock",
	"lapis:lapisblock",
	{cracky = 2, level = 2},
	{"lapis_lapislazuliblock.png"},
	S("Lapislazuli Stair"),
	minetest.registered_nodes["lapis:lapisblock"].sounds
)
stairs.register_slab( -- register a slab without adding inner and outer stairs
	"lapis:lapisblock",
	"lapis:lapisblock",
	{cracky = 2, level = 2},
	{"lapis_lapislazuliblock.png"},
	S("Lapislazuli Slab"),
	minetest.registered_nodes["lapis:lapisblock"].sounds
)

-- Connecting walls
if minetest.get_modpath("walls") and minetest.global_exists("walls") and walls.register ~= nil then
	walls.register("lapis:lapisblock_wall",      S("A Lapislazuli Wall"),      "lapis_lapislazuliblock.png",      "lapis:lapisblock",      minetest.registered_nodes["lapis:lapisblock"].sounds)
	walls.register("lapis:lapisblock_wall", S("A Lapislazuli Wall"), "lapis_lapislazuliblock.png", "lapis:lapisblock", minetest.registered_nodes["lapis:lapisblock"].sounds)
end

-- Lapislazuli Glass Pane Crafting
minetest.register_craft({
	output = 'xpanes:lapis_glass_pane_flat 16',
	recipe = {
		{'', '', ''},
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
	}
})

if minetest.get_modpath("xpanes") and minetest.global_exists("xpanes") and xpanes.register_pane ~= nil then
	xpanes.register_pane("lapis_glass_pane", {
		description = S("Lapislazuli Glass Pane"),
		textures = {
			{
				name        = "lapis_lapis_glass.png",
				align_style = "world",
				scale       = 2
			},
			"",
			"xpanes_edge_obsidian.png"
		},
		inventory_image = "([combine:32x32:-8,-8=lapis_lapis_glass.png:24,-8=lapis_lapis_glass.png:-8,24=lapis_lapis_glass.png:24,24=lapis_lapis_glass.png)^[resize:16x16^[multiply:#339^default_obsidian_glass.png",
		wield_image     = "([combine:32x32:-8,-8=lapis_lapis_glass.png:24,-8=lapis_lapis_glass.png:-8,24=lapis_lapis_glass.png:24,24=lapis_lapis_glass.png)^[resize:16x16^[multiply:#339^default_obsidian_glass.png",		use_texture_alpha = true,
		sounds = default.node_sound_glass_defaults(),
		groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
		recipe = {
			{"group:lapis_glass", "group:lapis_glass", "group:lapis_glass"},
			{"group:lapis_glass", "group:lapis_glass", "group:lapis_glass"}
		}
	})
end

if minetest.get_modpath("doors") and minetest.global_exists("doors") and doors.register_door ~= nil then
doors.register("door_lapis_glass", {
		tiles = {"lapis_door_lapis_glass.png"},
		description = S("Lapislazuli Glass Door"),
		inventory_image = "lapis_doors_item_lapis_glass.png",
		use_texture_alpha = true,
		groups = {node = 1, cracky=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		gain_open = 0.3,
		gain_close = 0.25,
		recipe = {
			{"xpanes:lapis_glass_pane_flat", "xpanes:lapis_glass_pane_flat"},
			{"xpanes:lapis_glass_pane_flat", "xpanes:lapis_glass_pane_flat"},
			{"xpanes:lapis_glass_pane_flat", "xpanes:lapis_glass_pane_flat"},
		},
})
end

minetest.after(0, function()
	print("[MOD] Lapis loaded")
end)
