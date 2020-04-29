module Constants where
import XMonad.Layout.Tabbed

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"
white = "#ffffff"
black = "#000000"
darkOrange = "#a34f1a"
darkOrangeBrighter = "#bd591a"
cyanBrighter = "#31b0a6"
otherYellow = "#ffc400"
darkYellow = "#b38900"

-- Fg is text color for xmobar
barFg = "#d4d4d4"
barBg = "#1c1c1c"

focusedBorder = "#8f8f8f"
normalBorder  = "#0f0f0f"

xmobarTitleColor = darkOrangeBrighter

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = cyanBrighter

active      = barBg
activeWarn  = red
inactive    = barBg
focusColor  = blue
unfocusColor = base02

myFont = "xft:Fira Code:size=10:antialias=true"

myTabConfig = def
    { fontName              = myFont
    , activeColor           = active
    , inactiveColor         = inactive
    , activeBorderColor     = activeWarn
    , inactiveBorderColor   = inactive
    , activeTextColor       = otherYellow
    , inactiveTextColor     = darkYellow
    , urgentTextColor       = ""
    , urgentBorderColor     = ""
    , urgentColor           = ""
  --  , activeBorderWidth     = 10
    }


{-
myTabConfig = def { activeColor = "#556064"
                  , inactiveColor = "#2F3D44"
                  , urgentColor = "#FDF6E3"
                  , activeBorderColor = "#454948"
                  , inactiveBorderColor = "#454948"
                  , urgentBorderColor = "#268BD2"
                  , activeTextColor = "#80FFF9"
                  , inactiveTextColor = "#1ABC9C"
                  , urgentTextColor = "#1ABC9C"
                  , fontName = "xft:Noto Sans CJK:size=10:antialias=true"
                  }

-}
