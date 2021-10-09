
--Mirdain

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "3"
MacroBook = "7"
MacroSet = "1"

--Uses Items Automatically
AutoItem = false

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','ACC','DT','PDL','SB') -- ACC effects WS and TP modes

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set Mode to Damage Taken as Default
state.OffenseMode:set('DT')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()
	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {
		main={ name="Verethragna", augments={'Path: A',}},
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		left_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	--Used to swap into movement gear when the player is detected movement when not engaged
	sets.Movement = {
		feet="Hermes' Sandals",
	}

	-- Set to be used if you get 
	sets.Cursna_Recieved = {
	    left_ring="Saida Ring",
		right_ring="Saida Ring",
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
		main={ name="Verethragna", augments={'Path: A',}},
		ammo="Ginsen",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Anch. Gaiters +3",
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP,{
		ammo="Staunch Tathlum +1",
		head="Ken. Jinpachi +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode.TP,{
	    head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP,{
	    ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
	})

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	-- MNK gets 35 Native Subtle Blow
	-- Cap is 75% - 50% in either I or II
	sets.OffenseMode.SB = {
		ammo="Ginsen",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, -- 12% SB I
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}}, -- 10% SB I
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1", -- 15% SB II
		left_ear="Sherida Earring", -- 5% SB II
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring", -- 5%  SB II
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	} -- 57% SB I + 25% SB II = Cap

	sets.Precast = {}
	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb", -- 2
		head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6',}}, --13
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','HP+47',}}, --9
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+17','"Fast Cast"+6','STR+9',}}, --6
		feet={ name="Herculean Boots", augments={'"Fast Cast"+6',}}, --6
		neck="Voltsurge Torque", --4
		waist="Kasiri Belt",
		left_ear="Etiolation Earring", --1
		right_ear="Loquac. Earring", --2
		left_ring="Prolix Ring", --3
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=1},
		back={ name="Segomo's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}, --10
	} -- FC 64

	sets.Precast.Enmity = {
	    ammo="Sapience Orb", -- 2
	    left_ear="Cryptic Earring", -- 4
		right_ear="Friomisi Earring", --2
		left_ring="Petrov Ring", -- 4
	}
	sets.Midcast = {}

	sets.JA = {}
	sets.JA["Hundred Fists"] = {legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}}}
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Precast.Enmity
	sets.JA["Focus"] = {}
	sets.JA["Dodge"] = {}
	sets.JA["Chakra"] = {}
	sets.JA["Boost"] = {}
	sets.JA["Counterstance"] = {}
	sets.JA["Chi Blast"] = {}
	sets.JA["Mantra"] = {}
	sets.JA["Footwork"] = {}
	sets.JA["Perfect Counter"] = {}
	sets.JA["Impetus"] = {}
	sets.JA["Inner Strength"] = {}

	--Default WS set base
	sets.WS = { -- VS Base with Impetus Down
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, -- Need Aug'd
		body="Ken. Samue +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1", -- Need Aug a Herc Feet
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	sets.WS.SB = set_combine( sets.WS, { -- This maximize SB
		-- Belt SB II - 25%
		-- Legs and Feet over cap 
	})

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = set_combine(sets.WS,{})

	sets.WS.PDL = set_combine(sets.WS,{})

	--WS Sets
	sets.WS["Combo"] = set_combine(sets.WS,{})
	sets.WS["Shoulder Tackle"] = set_combine(sets.WS,{})
	sets.WS["One Inch Punch"] = set_combine(sets.WS,{})
	sets.WS["Backhand Blow"] = set_combine(sets.WS,{})
	sets.WS["Raging Fists"] = set_combine(sets.WS,{
		neck="Mnk. Nodowa +2",
		feet="Ken. Sune-Ate +1",
	})
	sets.WS["Spinning Attack"] = set_combine(sets.WS,{})
	sets.WS["Howling Fist"] = set_combine(sets.WS,{
		neck="Mnk. Nodowa +2",
		feet="Ken. Sune-Ate +1",
	})
	sets.WS["Dragon Kick"] = set_combine(sets.WS,{
		feet="Anch. Gaiters +3",
	})
	sets.WS["Asuran Fists"] = set_combine(sets.WS,{})
	sets.WS["Tornado Kick"] = set_combine(sets.WS,{
		feet="Anch. Gaiters +3",
	})
	sets.WS["Victory Smite"] = set_combine(sets.WS,{})
	sets.WS["Shijin Spiral"] = set_combine(sets.WS,{
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	})

	--Impetus set has priority over any other modes
	sets.Impetus = {
		body="Bhikku Cyclas +1",
	}

	-- Impetus for the DT stance (need more PDT)
	sets.Impetus.DT = {
	    head="Malignance Chapeau",
		body="Bhikku Cyclas +1",
		right_ring="Defending Ring",
	}

	sets.Boost = {
		waist="Ask Sash",
	}

	sets.Charm =  set_combine(sets.OffenseMode.DT, {
	    main="Ark Tabar",
	})

	sets.TreasureHunter = {
		head="Malignance Chapeau",
	    body={ name="Herculean Vest", augments={'"Dual Wield"+4','Pet: Mag. Acc.+22 Pet: "Mag.Atk.Bns."+22','"Treasure Hunter"+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+11','"Subtle Blow"+2','"Treasure Hunter"+2',}},
	}

	organizer_items  = {		
		item1 = "Echo Drops",
		item2 = "Remedy",
		item3 = "Holy Water",
	}	
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}
	if spell.type == 'WeaponSkill' then
		if buffactive.Impetus then
			equipSet = sets.Impetus
		end	
	end
	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return choose_gear()
end

-- Called when the pet dies or is summoned
function pet_change_custom(pet,gain)
	equipSet = {}

	return equipSet
end

-- Called during a pet midcast
function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

-- Called after the performs an action
function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return choose_gear()
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return choose_gear()
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return choose_gear()
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Custom Function
function choose_gear()
	equipSet = {}
	if player.status == "Engaged" then
		if buffactive['Impetus'] then
			if state.OffenseMode.value == "DT" then
				equipSet = sets.Impetus.DT
			else
				equipSet = sets.Impetus
			end
		end	
	end
	if buffactive['Boost'] then
		equipSet = set_combine(equipSet, sets.Boost)
	end
	return equipSet
end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	-- Sub job has least priority
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	-- Mantra Max priority
	if player.hpp < 51 and ja_recasts[15] == 0 then
		buff = "Chakra"
	elseif not buffactive.Impetus and ja_recasts[31] == 0 then
		buff = "Impetus"
	elseif not buffactive.Footwork and ja_recasts[21] == 0 then
		buff = "Footwork"
	elseif not buffactive.Mantra and ja_recasts[19] == 0 then
		buff = "Mantra"
	elseif not buffactive.Dodge and ja_recasts[14] == 0 then
		buff = "Dodge"
	elseif not buffactive.Focus and ja_recasts[13] == 0 then
		buff = "Focus"
	end

	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

-- This function is called when the job file is unloaded
function user_file_unload()

end