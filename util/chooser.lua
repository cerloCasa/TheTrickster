local card_highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
    if self.area and self.area.config.type == "title" then
        self.highlighted = is_highlighted
    else
        card_highlight_ref(self, is_highlighted)
    end
end
local can_highlight_ref = CardArea.can_highlight
function CardArea:can_highlight(card)
    if self.config.type == 'title' then
        return true
    end
    return can_highlight_ref(self, card)
end

G.FUNCS.Trick_Select = function(e)
    if G.Trick_CardArea.highlighted[1] then
        G.OVERLAY_MENU:remove()
        G.OVERLAY_MENU = nil
        G.SETTINGS.paused = false
        e.config.ref_table.card:juice_up()
        e.config.ref_table.card.ability.extra.legendary = G.Trick_CardArea.highlighted[1].ability.extra.legendary
    end
end

function UI_JokerSelect(card)
    G.Trick_CardArea = CardArea(G.ROOM.T.x + G.ROOM.T.w / 2, G.ROOM.T.h, 5.09 * G.CARD_W, 1.03 * G.CARD_H, {card_limit = 5, type = 'title', highlight_limit = 1})
    local center_keys = {'Caino','Triboulet','Yorick','Chicot','Perkeo'}
    for i,center in ipairs(center_keys) do
        local legendary_joker = copy_card(card, nil, nil, nil, true)
        legendary_joker.ability.extra.legendary = center
        legendary_joker.ability.extra.sprite_pos.x = i
        legendary_joker.children.center:set_sprite_pos(legendary_joker.ability.extra.sprite_pos)
        G.Trick_CardArea:emplace(legendary_joker)
    end

    return{
        -- ROOT NODE
        n = G.UIT.ROOT,
        config = {r = 0.1, align = "cm", minw = 4, minh = 4, padding = 0.2, colour = G.C.BLACK, outline = 2, outline_colour = G.C.BLUE},
        nodes = {
            {
                -- COLUMN NODE
                n = G.UIT.C,
                config = {r = 0.1, align = "cm", padding = 0.2, colour = G.C.BLACK},
                nodes = {
                    {
                        n = G.UIT.R, config = { align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK},
                        nodes = {
                            { n = G.UIT.T, config = { text = 'CHOOSE WHICH JOKER THE TRICKSTER WILL COPY', scale = .5, colour = G.C.UI.TEXT_LIGHT, shadow = true} } }
                    },

                    {
                        n = G.UIT.R, config = { align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK},
                        nodes = {{n = G.UIT.O, config = {object = G.Trick_CardArea}}}
                    },
                    
                    {
                        n = G.UIT.R, config = { ref_table = {card = card}, align = "cm", padding = 0.2, r = 0.1, hover = true, colour = G.C.BLUE, button = "Trick_Select", shadow = true },
                        nodes = {
                            { n = G.UIT.T, config = { text = 'SELECT', scale = 0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = 'set_button_pip', focus_args = { button = 'x', set_button_pip = true } } }
                        }
                    },
                }
            }
        }
    }
end