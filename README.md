# About
Open source community script hub.
Uses the [Finity](https://localsmail.gitbook.io/finity-docs) GUI Lib + Github free API to dynamically load games cheats.

# How to add games
I recommend to clone the repo in your local machine and use something like Github Desktop to pull the changes you make.
1. Go to the `/games` directory.
1. Add your game folder(ex: `/big-balls-game`).
2. Inside your new game, create a category folder(ex: `/main`).
3. Now add a cheats section to it(ex: `balls.luau`).
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
5. Pull request the modified files and wait until i accept your changes

## Structure chart
![image](https://github.com/user-attachments/assets/195262a6-d800-4ff8-9ca5-006f6b04b195)

