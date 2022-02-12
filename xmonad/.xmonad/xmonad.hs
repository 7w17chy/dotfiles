{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances #-}

import qualified Codec.Binary.UTF8.String as UTF8
import Data.Monoid

import XMonad
import XMonad.Layout.NoBorders

--
-- Useful imports
--
import XMonad.Core as XMonad hiding
    (workspaces,manageHook,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook,clickJustFocuses,rootMask,clientMask)
import qualified XMonad.Core as XMonad
    (workspaces,manageHook,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook,clickJustFocuses,rootMask,clientMask)

import XMonad.Layout
import XMonad.Operations
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import Data.Bits ((.|.))
import Data.Default
import Data.Monoid
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras

import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Util.SpawnOnce
import XMonad.Layout.IndependentScreens

myLayout = tiled ||| (Mirror tiled) ||| Full 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = toRational (2 / (1 + sqrt 5 :: Double))

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myTerminal = "alacritty"

myFocusFollowsMouse = False
myClickJustFocuses = False

myModMask = mod4Mask

-- for a setup with 2 screens
--myWorkspaces = def { workspaces = withScreens 2 ["web", "a", "b", "c", "music", "chat", "misc" ] }
myWorkspaces = def { workspaces = withScreens 1 ["web", "a", "b", "c", "music", "chat", "misc" ] }

-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask              , xK_q     ), kill) -- %! Close the focused window

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_c     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_c     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ onCurrentScreen f i)
        | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  where
    help :: String
    help = "Google it!"
    helpCommand :: X ()
    helpCommand = spawn ("echo " ++ show help ++ " | xmessage -file -")

myStartupHook = do
  spawnOnce "$HOME/scripts/polybar_launch.sh"
  spawnOnce "nitrogen --restore"


main = do
xmonad $ desktopConfig {
focusedBorderColor = "#606060",
normalBorderColor  = "#2d2d2d",
terminal           = myTerminal,
focusFollowsMouse  = myFocusFollowsMouse,
clickJustFocuses   = myClickJustFocuses,
borderWidth        = 1,
modMask            = myModMask,
workspaces         = withScreens 2 ["web", "a", "b", "c", "music", "chat", "misc" ], -- withScreens 2 (workspaces desktopConfig),
keys               = \c -> myKeys c `M.union` keys XMonad.def c,
--layoutHook         = desktopLayoutModifiers $ noBorders $ myLayout,
layoutHook         = desktopLayoutModifiers $ myLayout,
--manageHook         = myManageHook <+> manageHook desktopConfig,
manageHook         = manageHook desktopConfig,
handleEventHook    = fullscreenEventHook <+> handleEventHook desktopConfig,
startupHook        = myStartupHook <+> startupHook desktopConfig
}

