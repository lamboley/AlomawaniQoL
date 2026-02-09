---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetLocale = GetLocale

local L = AlomawaniQoL.L

if GetLocale() == "frFR" then
    -- Shared
    L["Requires /reload to take effect."] = "Nécessite /reload pour prendre effet."

    -- Tab names
    L["General"] = "Général"
    L["System"] = "Système"
    L["Social"] = "Social"
    L["Gameplay"] = "Gameplay"
    L["Interface"] = "Interface"

    -- Section labels
    L["Graphics"] = "Graphismes"
    L["Audio"] = "Audio"
    L["Chat"] = "Chat"
    L["Roleplay"] = "Jeu de rôle"
    L["Battle Pet"] = "Mascotte de combat"
    L["Merchant"] = "Marchand"
    L["Bank"] = "Banque"
    L["Scale"] = "Échelle"

    -- Toggle names
    L["Enable Debug"] = "Activer le débogage"
    L["Max Out Camera Distance"] = "Distance de caméra maximale"
    L["Use Perfect Pixel"] = "Utiliser le pixel parfait"
    L["Use Custom Height"] = "Utiliser une hauteur personnalisée"
    L["Mute Annoying Sound"] = "Couper les sons agaçants"
    L["Disable Chat Clamping"] = "Désactiver le verrouillage du chat"
    L["Disable Right Click Targeting"] = "Désactiver le ciblage par clic droit"
    L["Faster Auto Loot"] = "Auto-butin plus rapide"
    L["Add Voice Line When Dead"] = "Ajouter une réplique vocale à la mort"
    L["Print Quote From Thich Nhat Hanh"] = "Afficher une citation de Thich Nhat Hanh"
    L["Keep A Battle Pet Summoned"] = "Garder une mascotte invoquée"
    L["Pet Name"] = "Nom de la mascotte"
    L["Repair Gear Automatically"] = "Réparer l'équipement automatiquement"
    L["Use Guild Bank For Repair"] = "Utiliser la banque de guilde pour les réparations"
    L["Sell Junk Automatically"] = "Vendre la camelote automatiquement"
    L["Disable Damage Text"] = "Désactiver le texte de dégâts"
    L["Hide Tooltip While In Combat"] = "Masquer l'infobulle en combat"
    L["Hide Player Portrait When Heal"] = "Masquer le portrait du joueur en soin"
    L["ObjectiveTracker Scale"] = "Échelle du suivi d'objectifs"
    L["Deposit Gold In Warband Bank"] = "Déposer l'or dans la banque de compte"
    L["Gold To Keep In Inventory"] = "Or à garder dans l'inventaire"

    -- Descriptions
    L["Set the UI Scale based on the vertical resolution (UIScale = 768 / verticalResolution). "] = "Définir l'échelle de l'interface en fonction de la résolution verticale (UIScale = 768 / résolutionVerticale). "
    L["If the UI is too small when using the option above, you can set a custom vertical resolution here. "] = "Si l'interface est trop petite avec l'option ci-dessus, vous pouvez définir une résolution verticale personnalisée ici. "
    L["Voice line are from Ilgynoth, Yshaarj, Xalatath and Yoggsaron"] = "Les répliques vocales proviennent d'Ilgynoth, Y'shaarj, Xal'atath et Yogg-Saron"
    L["The name of the battle pet to be summoned"] = "Le nom de la mascotte de combat à invoquer"
    L["Custom height must be between 480-4320"] = "La hauteur personnalisée doit être entre 480 et 4320"
end

