return {
    {
        type = "dropdown",
        name = "Select weapon",
        options = {
            "G17",
            "Pump"
        }
    },
    {
        type = "button",
        name = "Craft selected weapon",
        description = "Generates free materials and then crafts the weapon",
        activated = function(f, dt)
            local selectedWeapon = f.farming.selectedWeapon
            print(selectedWeapon)
        end
    }
}