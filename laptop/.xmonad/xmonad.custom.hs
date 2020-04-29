import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicBars
import XMonad.Layout.Gaps
import XMonad.Layout.LayoutModifier
import XMonad.Util.EZConfig
import XMonad.Actions.Navigation2D
import XMonad.Layout.Tabbed
import XMonad.Layout.BinarySpacePartition as BSP
import XMonad.Hooks.SetWMName
import XMonad.Util.Cursor
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.IndependentScreens
import XMonad.Layout.SubLayouts
import XMonad.Layout.NoBorders
import Data.Monoid

import qualified Data.Map as M
import qualified XMonad.StackSet as W

import Colors

myEmacs :: String
myEmacs = "emacsclient -c -n -e '(switch-to-buffer nil)'"

myTerminal :: String
myTerminal = "termite"

myScreenshot :: String
myScreenshot = "xfce4-screenshooter"

myLauncher :: String
myLauncher = "rofi -show drun -theme onedark"

myWorkspaces :: [String]
myWorkspaces = withScreens 2["1: term","2: web","3: code","4: media"] ++ map show ([5..9] :: [Integer])

myModMask :: KeyMask
myModMask = mod4Mask

outerGaps :: Int
outerGaps = 00

myGaps :: l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Gaps l a
myGaps = gaps [(U, outerGaps), (R, outerGaps), (L, outerGaps), (D, outerGaps)]

myBorderWidth :: Dimension
myBorderWidth = 0

myStartupHook :: X()
myStartupHook = do
  dynStatusBarStartup barCreator barDestroyer
  setWMName "LG3D"
  spawn     "bash ~/.xmonad/startup.sh"
  setDefaultCursor xC_left_ptr

myTabConfig :: Theme
myTabConfig = def
  {
      fontName              = "xft:Fira Code:size=15:antialias=true"
    , inactiveBorderColor   = base03
    , inactiveColor         = base03
    , inactiveTextColor     = base03
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = active
    , urgentBorderColor     = red
    , urgentTextColor       = yellow
    , decoHeight            = 0
  }

layouts = emptyBSP ||| tabbed shrinkText myTabConfig

myLayoutHook = smartBorders . avoidStruts $ layouts

myLogHook :: X()
myLogHook =
  multiPP activePP inactivePP

myManageHook = composeAll
  [
    isFullscreen --> doFullFloat
  ]

myEventHook :: Event -> X Data.Monoid.All
myEventHook = composeAll
  [
 dynStatusBarEventHook barCreator barDestroyer,
 fullscreenEventHook
 ]
defaults = def
  {
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    keys               = myKeys,
    handleEventHook    = myEventHook,
    startupHook        = myStartupHook,
    logHook            = myLogHook >> updatePointer (0.75, 0.75) (0.75, 0.75),
    layoutHook         = myLayoutHook,
    manageHook         = manageDocks <+> myManageHook
  }

main :: IO()
main = do
  xmonad $ docks
         $ navigation2DP def
          ("<Up>", "<Left>", "<Down>", "<Right>")
          [("M-",   windowGo),
          ("M-S-", windowSwap)] False
         $ ewmh
         $ defaults `additionalKeys` otherKeys

activePP :: PP
activePP = inactivePP
  {
    ppLayout = (\_ -> ""),
    ppVisible = (\_ -> "")
  }

inactivePP :: PP
inactivePP = def {
  ppCurrent = (\x -> xmobarColor xmobarCurrentWorkspaceColor "" $ wrap "[" "]" $ drop 2 x)
  ,ppTitle = xmobarColor xmobarTitleColor "" . shorten 50
  ,ppSep = "  "
  ,ppLayout = (\_ -> "")
  ,ppVisible = (\_ -> "")
  ,ppHidden = (\_ -> "")
  }

barCreator :: DynamicStatusBar
barCreator (S sid) = spawnPipe $ "xmobar -x " ++ show sid ++ " ~/.xmonad/xmobarrc.hs"

barDestroyer :: DynamicStatusBarCleanup
barDestroyer = return ()

myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X())
myKeys = \c -> mkKeymap c[
 ("M-[", spawn myEmacs),
 ("M-S-<Return>", spawn myTerminal),
 ("M-S-c", kill),
 ("M-p", spawn myLauncher),
 ("<XF86AudioMute>", spawn "pactl set-sink-mute 1 toggle"),
 ("<XF86AudioLowerVolume>", spawn "amixer -c 1 -q set Master 1%-"),
 ("<XF86AudioRaiseVolume>", spawn "amixer -c 1 -q set Master 1%+"),
 ("<XF86AudioPlay>", spawn "playerctl --all-players play-pause"),
 ("<XF86AudioPrev>", spawn "playerctl --all-players previous"),
 ("<XF86AudioNext>", spawn "playerctl --all-players next"),
 ("M-q", restart "xmonad" True),
 ("M-<Space>", sendMessage NextLayout)
 ]

otherKeys :: [((KeyMask, KeySym), X())]
otherKeys =
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to N workspace
  [((m .|. myModMask, k), windows $ onCurrentScreen f i)
      | (i, k) <- zip (workspaces' defaults) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
   ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

   ++

  -- Bindings for manage sub tabs in layouts please checkout the link below for reference
  -- https://hackage.haskell.org/package/xmonad-contrib-0.13/docs/XMonad-Layout-SubLayouts.html
  [
    -- Tab current focused window with the window to the left
    ((myModMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
    -- Tab current focused window with the window to the right
  , ((myModMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
    -- Tab current focused window with the window above
  , ((myModMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
    -- Tab current focused window with the window below
  , ((myModMask .|. controlMask, xK_j), sendMessage $ pullGroup D)

  -- Tab all windows in the current workspace with current window as the focus
  , ((myModMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
  -- Group the current tabbed windows
  , ((myModMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))

  -- Toggle through tabes from the right
  , ((myModMask, xK_Tab), onGroup W.focusDown')
  ]

  ++
  -- Some bindings for BinarySpacePartition
  -- https://github.com/benweitzman/BinarySpacePartition
  [
    ((myModMask .|. controlMask,               xK_Right ), sendMessage $ ExpandTowards R)
  , ((myModMask .|. controlMask .|. shiftMask, xK_Right ), sendMessage $ ShrinkFrom R)
  , ((myModMask .|. controlMask,               xK_Left  ), sendMessage $ ExpandTowards L)
  , ((myModMask .|. controlMask .|. shiftMask, xK_Left  ), sendMessage $ ShrinkFrom L)
  , ((myModMask .|. controlMask,               xK_Down  ), sendMessage $ ExpandTowards D)
  , ((myModMask .|. controlMask .|. shiftMask, xK_Down  ), sendMessage $ ShrinkFrom D)
  , ((myModMask .|. controlMask,               xK_Up    ), sendMessage $ ExpandTowards U)
  , ((myModMask .|. controlMask .|. shiftMask, xK_Up    ), sendMessage $ ShrinkFrom U)
  , ((myModMask,                               xK_r     ), sendMessage BSP.Rotate)
  , ((myModMask,                               xK_s     ), sendMessage BSP.Swap)
  -- , ((myModMask,                               xK_n     ), sendMessage BSP.FocusParent)
  -- , ((myModMask .|. controlMask,               xK_n     ), sendMessage BSP.SelectNode)
  -- , ((myModMask .|. shiftMask,                 xK_n     ), sendMessage BSP.MoveNode)
  ]
