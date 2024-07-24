--- STEAMODDED HEADER
--- MOD_NAME: The Trickster
--- MOD_ID: Trickster
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: This mod adds the Trickster Joker
--- BADGE_COLOR: F7433A
--- PREFIX: Trick
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.0


load(NFS.read(SMODS.current_mod.path .. 'util/atlas.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'util/localization.lua'))()
function SMODS.current_mod.process_loc_text()
    TRICK_localize()
end

local JokerNames = {'Caino','Triboulet','Yorick','Chicot','Perkeo'}

local function random1to5()
    return math.ceil(5*pseudorandom(pseudoseed('Trick')))
end

local function randomValue()
    return pseudorandom(pseudoseed('Trick'))
end

local function legendarySwitch(card)
    if randomValue() < G.GAME.probabilities.normal/2 then
        local JokerNumber = random1to5()
        card.ability.extra.legendary = JokerNames[JokerNumber]
        card.ability.extra.sprite_pos.x = JokerNumber
    else
        -- WILL SET TO NONE
        card.ability.extra.legendary = "None"
        card.ability.extra.sprite_pos.x = 0
    end
    card.children.center:set_sprite_pos(card.ability.extra.sprite_pos)
end

SMODS.Joker { -- The Trickster
    key = 'Trickster',
    loc_txt = {
        ['default'] = {
            name = 'The Trickster',
            text = {'{C:green}#1# in #2#{} chance to copy', 'a random {C:legendary,E:1}Legendary','Joker each round','{C:inactive}(Currently: #3#)'},
        },
    },
    loc_vars = function(self, info_queue, card)
        if card and card.ability and card.ability.extra and card.ability.extra.legendary then
            if card.ability.extra.legendary == 'None' then
                info_queue[#info_queue + 1] = {key = 'Trick_None', set = 'Other'}
            elseif card.ability.extra.legendary == 'Caino' then
                info_queue[#info_queue + 1] = {key = 'Trick_caino', set = 'Other', vars = {card.ability.extra.CAextra, card.ability.extra.CAxmult}}
            elseif card.ability.extra.legendary == 'Triboulet' then
                info_queue[#info_queue + 1] = {key = 'Trick_triboulet', set = 'Other', vars = {card.ability.extra.TRextra}}
            elseif card.ability.extra.legendary == 'Yorick' then
                info_queue[#info_queue + 1] = {key = 'Trick_yorick', set = 'Other', vars = {card.ability.extra.YOextra_xmult, card.ability.extra.YOextra_discards, card.ability.extra.YOcurrent_discards, card.ability.extra.YOxmult}}
            elseif card.ability.extra.legendary == 'Chicot' then
                info_queue[#info_queue + 1] = {key = 'Trick_chicot', set = 'Other'}
            elseif card.ability.extra.legendary == 'Perkeo' then
                info_queue[#info_queue + 1] = {key = 'Trick_perkeo', set = 'Other'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'Trick_None', set = 'Other'}
        end
        return {vars = {card.ability.extra.odds * (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.prob, card.ability.extra.legendary}}
    end,
    config = {extra = {
        odds = 1, prob = 2, legendary = 'None', sprite_pos = {x = 0, y = 0},
        -- Caino variables
        CAextra = 1,
        CAxmult = 1,
        -- Triboulet variables
        TRextra = 2,
        -- Yorick variables
        YOextra_xmult = 1,
        YOextra_discards = 23,
        YOcurrent_discards = 23,
        YOxmult = 1
    }},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    cost = 9,
    atlas = 'JokerAtlas',
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    set_sprites = function(self, card, front)
        if card.ability then
            card.children.center:set_sprite_pos(card.ability.extra.sprite_pos)
        end
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            legendarySwitch(card)
        end
        local LegendaryName = card.ability.extra.legendary

        -- UPGRADES
        
        -- CAINO'S UPGRADE GLASS
        if context.cards_destroyed and not context.blueprint then
            local faces = 0
            for k, v in ipairs(context.glass_shattered) do
                if v:is_face() then
                    faces = faces + 1
                end
            end
            if faces > 0 then
                if LegendaryName == "Caino" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card.ability.extra.CAxmult = card.ability.extra.CAxmult + faces*card.ability.extra.CAextra
                                    return true
                                end
                            }))
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.CAxmult}}})
                            return true
                        end
                    }))
                else
                    card.ability.extra.CAxmult = card.ability.extra.CAxmult + faces * card.ability.extra.CAextra
                end
            end
        end
        -- CAINO'S UPGRADE NOT GLASS
        if context.remove_playing_cards and not context.blueprint then
            local face_cards = 0
            for k, val in ipairs(context.removed) do
                if val:is_face() then
                    face_cards = face_cards + 1 
                end
            end
            if face_cards > 0 then
                card.ability.extra.CAxmult = card.ability.extra.CAxmult + face_cards * card.ability.extra.CAextra
                if LegendaryName == "Caino" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.CAxmult}}})
                            return true
                    end}))
                end
            end
        end
        -- YORICK'S UPGRADE
        if context.discard and not context.blueprint then
            if card.ability.extra.YOcurrent_discards <= 1 then
                card.ability.extra.YOcurrent_discards = card.ability.extra.YOextra_discards
                card.ability.extra.YOxmult = card.ability.extra.YOxmult + card.ability.extra.YOextra_xmult
                if LegendaryName == "Yorick" then
                    return {
                        delay = 0.2,
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.YOxmult}},
                        colour = G.C.RED
                    }
                end
            else
                card.ability.extra.YOcurrent_discards = card.ability.extra.YOcurrent_discards - 1
            end
        end

        -- ABILITIES
        if LegendaryName == "Caino" then
            if context.joker_main and card.ability.extra.CAxmult > 1 then
                return{
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.CAxmult}},
                    Xmult_mod = card.ability.extra.CAxmult
                }
            end
        end
        if LegendaryName == "Triboulet" then
            if context.individual and context.cardarea == G.play then
                if (context.other_card:get_id() == 12 or context.other_card:get_id() == 13) then
                    return {
                        x_mult = card.ability.extra.TRextra,
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
        if LegendaryName == "Yorick" then
            if context.joker_main and card.ability.extra.YOxmult > 1 then
                return{
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.YOxmult}},
                    Xmult_mod = card.ability.extra.YOxmult
                }
            end
        end
        if LegendaryName == "Chicot" then
            if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                G.GAME.blind:disable()
                play_sound('timpani')
                card_eval_status_text(card,'extra',nil, nil, nil, {message = localize('ph_boss_disabled')})
            end
        end
        if LegendaryName == "Perkeo" then
            if context.ending_shop then
                if G.consumeables.cards[1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo')), nil)
                            card:set_edition({negative = true}, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                end
            end
        end
    end
}