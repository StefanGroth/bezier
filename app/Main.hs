
import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.Pure.Game

import Bezier

import Data.Fixed

width :: Int
width = 300
height :: Int
height = 300
offset :: Int
offset = 100


window :: Display
window = InWindow "My Window" (width, height) (offset, 0)

background :: Color
background = black

data Points = Points 
    {
        locs :: [Point],
        t :: Float  
    } deriving Show

render :: Points -> Picture
render points =
    pictures $ map mkCircle locations ++ showAnim 10 bezierPoint ++ [color red $ line $ bezierPoints locations samplePoints] 
    where        
        mkCircle :: Point -> Picture
        mkCircle (x, y) = translate x y $ color white $ circleSolid 10
        
        bezierPoint = bezier locations (t points)  

        showAnim :: Float -> Maybe Point -> [Picture] 
        showAnim size Nothing = []
        showAnim size (Just (x, y)) = [translate x y $ color red $ circleSolid size]

        locations = locs points
        
        samples :: Int
        samples = 50
        
        samplePoints :: [Float]
        samplePoints = [0, 1.0/fromIntegral samples .. 1.0]

        bezierPoints :: [Point] -> [Float] -> [Point]
        bezierPoints [] _ = []
        bezierPoints locs ts = explicitBezier locs <$> ts

initialState :: Points
initialState = Points { 
    locs = [],
    t = 0
}

fps :: Int
fps = 60

handleKeys :: Event -> Points -> Points
handleKeys (EventKey (MouseButton LeftButton) Down _ (x, y)) points =
    points { locs = locs points ++ [(x,y)] }
handleKeys _ game = game


duration :: Float
duration = 5

main :: IO ()
main = play window background fps initialState render handleKeys update 
    where 
        update :: Float -> Points -> Points
        update secs points = points { t = mod' (t points + (secs / duration)) 1 }
