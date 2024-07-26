G.TricksterVouchers = {
    Chance = 2,
    SoulRate = 1,
    CanSelect = false
}

SMODS.Voucher { -- First Voucher
    key = 'Impostor',
    loc_txt = {
        name = 'Impostor',
        text = {
            '{C:attention}The Trickster{} has now a',
            '{C:green}#1# in 1{} chance to copy a',
            'random {C:legendary,E:1}Legendary{} Joker.',
            '{C:spectral}The Soul{} appears',
            '{C:attention}2X{} times more often.'
        },
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME and G.GAME.probabilities.normal or 1}}
    end,
    config = {},
    pos = {x = 0, y = 0},
    atlas = 'Vouchers',
    cost = 10,
    unlocked = true,
    discovered = false,
    redeem = function(self)
        G.TricksterVouchers.Chance = 1
        G.TricksterVouchers.SoulRate = 2
    end
}

SMODS.Voucher { -- Second Voucher
    key = 'Impersonator',
    loc_txt = {
        name = 'Impersonator',
        text = {
            'You can choose which',
            '{C:legendary,E:1}Legendary{} Joker',
            '{C:attention}The Trickster{} will copy.',
            '{C:spectral}The Soul{} appears',
            '{C:attention}4X{} times more often.'
        },
    },
    config = {},
    pos = {x = 1, y = 0},
    soul_pos = {x = 2, y = 0},
    atlas = 'Vouchers',
    cost = 10,
    unlocked = true,
    discovered = false,
    requires = {'v_Trick_Impostor'},
    redeem = function(self)
        G.TricksterVouchers.CanSelect = true
        G.TricksterVouchers.SoulRate = 4
    end
}