local selectedWeapon
return {
    {
        "Dropdown",
        "Select weapon",
        function(f, option)
            selectedWeapon = option
        end,
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
        function(f)
            print(selectedWeapon)
        end
    }
}