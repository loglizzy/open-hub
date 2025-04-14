# About
Open source community script hub.

# How to add games
1. Add your game(ex: `/big-balls-game`) to the `/games` directory.
2. Then create a category folder(ex: `/main`).
3. Create a section inside the category folder(ex: `combat.luau`).
4. Write your code inside that section script:
```luau
return {
    {
        "Dropdown",
        "Select balls size",
        function(f, option)
            f.main.balls = option
        end,
        {
            options = {"Big", "Small"}
        }
    },
    {
        "Button",
        "Analyse balls",
        function(f)
            if f.main.balls == "Big" then
                print("Yuumy")
            else
                print(":(")
            end
        end
    }
}
```

## Structure chart
![image](https://github.com/user-attachments/assets/5bf008a3-bcc6-4c46-a302-794dceb7c53b)
