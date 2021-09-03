module Bezier
    ( 
        bezier,
        bezier',
        explicitBezier
    ) where

import qualified Graphics.Gloss.Data.Point.Arithmetic as Arith
import Control.Applicative
import Graphics.Gloss.Data.Point
import Math.Combinatorics.Exact.Binomial


someFunc :: IO ()
someFunc = putStrLn "someFunc"


bezier' :: [Point] -> Float -> Point 
bezier' [point] _ = point 
bezier' points t = first Arith.+ last
    where   first = (1-t) Arith.* bezier' (init points) t
            last = t Arith.* bezier' (tail points) t

bezier :: [Point] -> Float -> Maybe Point 
bezier [] _ = Nothing 
bezier [point] _ = Just point 
bezier points t = Just $ bezier' points t 

explicitBezier :: [Point] -> Float -> Point 
explicitBezier points time = foldl (Arith.+) (0,0) applied
    where 
        n = length points
        t = time

        binomial :: [Float]
        binomial = fromIntegral. choose n <$> [0..n]
        
        polynomial :: [Float]
        polynomial = (\i -> (1-t)^(n-i) * t^i) <$> [0..n]

        mods :: [Float]
        mods = (*) <$> binomial <*> polynomial

        applied = (Arith.*) <$> mods <*> points
