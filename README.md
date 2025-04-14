# About
Open source community script hub.

# How to add games
1. Go to the `/games` directory.
1. Add your game folder(ex: `/big-balls-game`).
2. Create a category folder(ex: `/main`).
3. Create a section(ex: `balls.luau`).
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
![image](https://github.com/user-attachments/assets/195262a6-d800-4ff8-9ca5-006f6b04b195)

