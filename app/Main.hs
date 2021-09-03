import Lib
import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.Pure.Game

import qualified Graphics.Gloss.Data.Point.Arithmetic as Arith
import Control.Applicative

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
        anim :: Maybe Point 
    } deriving Show

render :: Points -> Picture
render points =
    pictures $ map mkCircle (locs points) ++ showAnim (anim points)
    where        
        mkCircle :: Point -> Picture
        mkCircle (x, y) = translate x y $ color white $ pictures [circleSolid 10, mkText x y]
        mkText x y = translate 15 (-5) $ scale 0.15 0.15 $ Text ("(" ++ show x ++ ", " ++ show y ++ ")")
        
        showAnim :: Maybe Point -> [Picture] 
        showAnim Nothing = []
        showAnim (Just (x, y)) = [translate x y $ color red $ circleSolid 10]

initialState :: Points
initialState = Points { 
    locs = [],
    anim = Nothing 
}


bezier :: [Point] -> Float -> Maybe Point 
bezier [] _ = Nothing 
bezier [point] _ = Just point 
bezier points t = (Arith.+) <$> first <*> last
    where   first = ((1-t) Arith.*) <$> bezier (init points) t
            last = (t Arith.*) <$> bezier (tail points) t

fps :: Int
fps = 60

handleKeys :: Event -> Points -> Points
handleKeys (EventKey (MouseButton LeftButton) Down _ (x, y)) points =
    points { locs = (x,y) : locs points, anim = Just (x, y) }
handleKeys _ game = game




main :: IO ()
main = play window background fps initialState render handleKeys update 
    where 
        update _ points = points
