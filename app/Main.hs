import Lib
import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.Pure.Game

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

newtype Points = Points 
    {
        locs :: [Point]
    } deriving Show

render :: Points -> Picture
render points =
    pictures $ map mkCircle $ locs points
    where        
        mkCircle :: Point -> Picture
        mkCircle (x, y) = translate x y $ color white $ pictures [circleSolid 10, mkText x y]
        mkText x y = translate 15 (-5) $ scale 0.15 0.15 $ Text ("(" ++ show x ++ ", " ++ show y ++ ")")


initialState :: Points
initialState = Points { 
    locs = []    
}

fps :: Int
fps = 60

handleKeys :: Event -> Points -> Points
handleKeys (EventKey (MouseButton LeftButton) Down _ (x, y)) points =
    points { locs = (x,y) : locs points }
handleKeys _ game = game


main :: IO ()
main = play window background fps initialState render handleKeys update 
    where 
        update _ points = points
