# bezier

![example animation of a bezier curve](https://github.com/StefanGroth/bezier/blob/master/gif.gif)

Bézier curve visualization.
Click to add points. The visualization uses the first point as the starting point and the last point clicked as the end point. All other points clicked are the control points.

To build and run, use `stack run`.

# Takeaways

* [gloss](https://hackage.haskell.org/package/gloss-1.13.2.1) was a great start into GUI programming with Haskell. The API is very straight-forward and allows pure programming. Alas, it leaves some things to be desired like writing text or smoothing the visual output. But I can see myself using it again for small stuff.
* These limitations ultimately led me to stop this small project and continue with another library. I have to check out [threepenny-gui](https://hackage.haskell.org/package/threepenny-gui) and [hylogen](https://hackage.haskell.org/package/hylogen)
* When using [stack](https://docs.haskellstack.org/en/stable/README/), I should specify LTEs as resolves when I have to, because it does not automatically add all modules when just using `ghc-...`.
* The visualization becomes slow very fast for the recursive formulation. This is probably due to the fact that it descends two times. It's left path can not do tail recursion. I'm unsure if it's doing tail recursion for the right path.
* I tried to use [QuickCheck](https://hackage.haskell.org/package/QuickCheck) to test that both of my implemented Bézier curves are identical, but they differed. My assumption is that large exponents and factorials used in the explicit formulations lead to different rounding behavior than the recursive formulation.  
* It would also be interesting to have the sample points on the curve be equidistant, which might be a hard / impossible problem to solve. I should also look into composite Bézier curves and splines.
* I think Bézier curves were a good decision for a small starting project to become familiar with Haskell and gloss, and doing it in short bursts like this felt quite rewarding (draw points -> animate points -> animate Bézier curve -> direct formulation with some testing).
* BSD3 is very similar to the MIT license
* I will never remember how to do links in markdown and I need a better program to make gifs.


