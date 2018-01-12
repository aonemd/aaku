import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed

myLayoutHook = noBorders (Full ||| tabbed shrinkText defaultTheme)
myTerminalEmulator = "termite"
myModKey = mod4Mask

main = do
    xmonad $ defaultConfig { layoutHook = myLayoutHook
                           , terminal = myTerminalEmulator
                           , modMask = myModKey }
