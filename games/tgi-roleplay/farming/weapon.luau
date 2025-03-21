return {
    {
        "Dropdown",
        "Select weapon",
        {
            options = {
                "G17",
                "Pump"
            }
        }
    },
    {
        "Button",
        "Craft selected weapon",
        "Generates free materials and then crafts the weapon",
        function(f, state)
            local selectedWeapon = f.farming.selectedWeapon
            print(selectedWeapon)
        end
    }
}