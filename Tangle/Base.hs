module Tangle.Base
( translate
, shift
, lcAlpha
, ucAlpha
, sevenBitPrintable
, test
) where

import Data.Char

lcAlpha = ['a'..'z']
ucAlpha = ['A'..'Z']

sevenBitPrintable = map chr [32..126]

translate i o = map trans
  where trans c = case lookup c $ zip i o of Just c' -> c'
                                             Nothing -> c

shift n lst = take l $ drop (l + n) $ cycle lst
  where l = length lst


test = mapM_ (\ (pass, msg) -> putStrLn $ (if pass then "+ " else "- ") ++ msg)

main = test examples
  where examples = [ ((ucTrans ohai)    == "OH HAI", "translate to upper case")
                   , ((lcTrans ohai)    == "oh hai", "translate to lower case") 
                   , ((noTrans ohai)    == ohai,     "null translate"         )
                   , ((shift 1 ohai)    == "h HaiO", "positive shift"         )
                   , ((shift (-1) ohai) == "iOh Ha", "negative shift"         ) ]
        ucTrans = translate lcAlpha ucAlpha
        lcTrans = translate ucAlpha lcAlpha
        noTrans = translate [] []
        ohai    = "Oh Hai"

