module Main where

import Utils
import Sample

main :: IO ()
main = do
  writePlutusScript "gift" "./compiled/gift.plutus" gift
  writePlutusScript "burn" "./compiled/burn.plutus" burn