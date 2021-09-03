import Test.Hspec
import Bezier 
import Test.QuickCheck
import Graphics.Gloss.Interface.IO.Display (Point)
import Data.Fixed


same :: [Point] -> Float -> Expectation
same l t=
    explicitBezier l t `shouldBe` bezier' l t


main :: IO ()
main = hspec $ do
    describe "Bezier.binomialTerm" $ do
        it "returns the correct list of binomial terms" $ do
            binomialTerm 1 `shouldBe` [1]
            binomialTerm 2 `shouldBe` [1, 1]
            binomialTerm 3 `shouldBe` [1, 2, 1]
            binomialTerm 4 `shouldBe` [1, 3, 3, 1]
    describe "Bezier.polynomialTerm" $ do 
        it "returns the correct list of polynomial terms" $ do
            polynomialTerm 1 0.5 `shouldBe` [1]
            polynomialTerm 2 0.5 `shouldBe` [0.5, 0.5]
            polynomialTerm 2 0.7 `shouldBe` [0.3, 0.7]
            polynomialTerm 3 0.7 `shouldBe` [0.3^2, 0.3*0.7, 0.7^2]
            polynomialTerm 4 0.7 `shouldBe` [0.3^3, 0.3^2*0.7, 0.3*0.7^2, 0.7^3]
    describe "Bezier.combinedTerm" $ do 
        it "returns the correct list of the combined mods of binomial and polynomial term" $ do
            combinedTerm 1 0.5 `shouldBe` [1]
            combinedTerm 2 0.5 `shouldBe` [0.5, 0.5]
            combinedTerm 3 0.7 `shouldBe` [0.3^2, 2 * 0.3*0.7, 0.7^2]
            combinedTerm 4 0.7 `shouldBe` [0.3^3, 3 * 0.3^2*0.7, 3 * 0.3*0.7^2, 0.7^3]
    describe "Bezier.explicitBezier" $ do
        it "returns the same results as Bezier.bezier'" $ do
            same [] 0.5
            same [(2,8), (2,3), (9,9)] 0.11
            same [(2,8), (2,8)] 0.324
            same [(1,1)] 0.5
            
            