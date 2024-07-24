function TRICK_localize()
    G.localization.descriptions.Other['Trick_None'] = {
        name = 'No Legendary active',
        text = {
            'Currently this Joker',
            'has no abilities'
        },
    }
    G.localization.descriptions.Other['Trick_caino'] = {
        name = 'Canio',
        text = {
            "This Joker gains {X:mult,C:white} X#1# {} Mult",
            "when a {C:attention}face{} card",
            "is destroyed",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
        },
    }
    G.localization.descriptions.Other['Trick_triboulet'] = {
        name = "Triboulet",
        text = {
            "Played {C:attention}Kings{} and",
            "{C:attention}Queens{} each give",
            "{X:mult,C:white} X#1# {} Mult when scored"
        },
    }
    G.localization.descriptions.Other['Trick_yorick'] = {
        name = "Yorick",
        text = {
            "This Joker gains",
            "{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}",
            "cards discarded",
            "{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)"
        },
    }
    G.localization.descriptions.Other['Trick_chicot'] = {
        name = "Chicot",
        text = {
            "Disables effect of",
            "every {C:attention}Boss Blind"
        },
    }
    G.localization.descriptions.Other['Trick_perkeo'] = {
        name = "Perkeo",
        text = {
            "Creates a {C:dark_edition}Negative{} copy of",
            "{C:attention}1{} random {C:attention}consumable{}",
            "card in your possession",
            "at the end of the {C:attention}shop",
        },
    }
end
