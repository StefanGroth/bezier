module Bezier
    ( 
        bezier,
        bezier',
        explicitBezier,
        binomialTerm,
        polynomialTerm,
        combinedTerm
    ) where

import qualified Graphics.Gloss.Data.Point.Arithmetic as Arith
import Control.Applicative
import Graphics.Gloss.Data.Point
import Math.Combinatorics.Exact.Binomial


someFunc :: IO ()
someFunc = putStrLn "someFunc"


bezier' :: [Point] -> Float -> Point 
bezier' [] _ = (0,0)
bezier' [point] _ = point 
bezier' points t = first Arith.+ last
    where   first = (1-t) Arith.* bezier' (init points) t
            last = t Arith.* bezier' (tail points) t

bezier :: [Point] -> Float -> Maybe Point 
bezier [] _ = Nothing 
bezier [point] _ = Just point 
bezier points t = Just $ bezier' points t 


binomialTerm :: Int -> [Float]
binomialTerm n = fromIntegral. choose (n-1) <$> [0..n-1]

polynomialTerm :: Int -> Float -> [Float]
polynomialTerm n t = (\i -> (1-t)^(n'-i) * t^i) <$> [0..n']
    where n' = n - 1

combinedTerm :: Int -> Float -> [Float]
combinedTerm n t = uncurry (*) <$> zip (binomialTerm n) (polynomialTerm n t)

explicitBezier :: [Point] -> Float -> Point 
explicitBezier points time = foldl (Arith.+) (0,0) applied

    where 
        n = length points
        t = time
        applied = uncurry (Arith.*) <$> zip (combinedTerm n t) points
