# About
Open source community script hub.

# How to add games
1. Add your game(ex: `/big-balls-game`) to the `/games` directory.
2. Then create a category folder(ex: `/main`).
3. Create a section inside the category folder(ex: `combat.luau`).
4. Write cheats to your section:
```luau
return {
    {
        "Dropdown", -- Cheat type
        "Select balls size", -- Label text
        function(f, option) -- Callback
            f.main.balls = option
        end,
        -- Dropdown options
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
![image](https://github.com/user-attachments/assets/1c42aa96-16ba-43f2-b609-3e9b378c0264)

