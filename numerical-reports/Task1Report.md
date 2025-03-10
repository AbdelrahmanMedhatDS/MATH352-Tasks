# Analysis of Numerical Methods for Stiff ODEs

## Introduction

This report presents the implementation and analysis of three numerical methods for solving a stiff ordinary differential equation (ODE). The methods compared are Forward Euler, Modified Euler (Heun's Method), and Backward Euler. The specific ODE under consideration is:

$$\frac{dy}{dt} = -50y + \sin(t)$$

with initial condition $y(0) = 1$.

This equation represents a system with a rapid decay component ($-50y$) coupled with a sinusoidal forcing function ($\sin(t)$). The large negative coefficient makes this a stiff ODE, presenting significant challenges for certain numerical methods.

## Analysis of Numerical Solutions

### Forward Euler Behavior

The Forward Euler method updates the solution using the formula:

$$y_{n+1} = y_n + h f(t_n, y_n)$$

where $f(t, y) = -50y + \sin(t)$ and $h = 0.04$ is the step size.

**Observations**: With the given step size of $h=0.04$, the Forward Euler solution exhibits unstable behavior. The solution rapidly oscillates with increasing amplitude as time progresses. This instability manifests as wild oscillations that grow exponentially, completely failing to capture the true solution behavior.

**Explanation**: This instability occurs because the Forward Euler method has limited stability regions for stiff problems. For this ODE, the product $\lambda h = -50 \times 0.04 = -2$ falls outside the stability region of the Forward Euler method, which requires $|-2| < 1$ for stability. Since $|-2| = 2 > 1$, the method becomes unstable, producing the observed oscillations.

### Modified Euler Behavior

The Modified Euler method (Heun's Method) is a second-order Runge-Kutta method using the formula:

$$k_1 = f(t_n, y_n)$$
$$k_2 = f(t_n + h, y_n + h k_1)$$
$$y_{n+1} = y_n + \frac{h}{2}(k_1 + k_2)$$

**Observations**: While the Modified Euler method shows slightly better stability characteristics compared to Forward Euler, it still exhibits unstable behavior for our stiff ODE with $h=0.04$. The oscillations may initially appear less severe, but they ultimately grow over time.

**Explanation**: The Modified Euler method has a larger stability region than Forward Euler, but for stiff problems with large negative eigenvalues, it still requires a very small step size to remain stable. For our problem, the step size $h=0.04$ is still too large for stability with the Modified Euler method.

### Backward Euler Behavior

The Backward Euler method uses the implicit formula:

$$y_{n+1} = y_n + h f(t_{n+1}, y_{n+1})$$

For our linear ODE, this can be solved algebraically:

$$y_{n+1} = \frac{y_n + h \sin(t_{n+1})}{1 - h\lambda}$$

where $\lambda = -50$.

**Observations**: The Backward Euler method demonstrates stable behavior for all tested step sizes. The solution decays rapidly at first, then settles into a small-amplitude oscillation tracking the forcing function.

**Explanation**: The Backward Euler method is unconditionally stable for problems with negative real eigenvalues, making it particularly well-suited for stiff ODEs. This stability comes from its implicit nature, which means it accounts for the future state when calculating the next step. This implicit characteristic allows the Backward Euler method to handle the rapid decay component of the ODE without introducing numerical instabilities, regardless of the step size.

## Impact of Step Size

The step size $h$ significantly impacts both the stability and accuracy of each method:

**Forward Euler**:
- For $h > 0.04$: Increased instability with even larger oscillations
- For $h = 0.02$: Still unstable but with less severe oscillations
- For $h < 0.04$: Gradually improves stability as $h$ decreases
- For $h \leq 0.04$ (theoretical stability limit): Becomes stable

**Modified Euler**:
- Larger step sizes: Unstable behavior similar to Forward Euler
- Smaller step sizes: Improved stability and accuracy
- The stability region is larger than Forward Euler but still limited for stiff problems

**Backward Euler**:
- Remains stable regardless of step size (unconditionally stable)
- Very large step sizes: Stable but with reduced accuracy
- Smaller step sizes: Improved accuracy while maintaining stability

As the step size decreases, all methods converge to more accurate solutions, but at the cost of increased computational effort.

## Explicit vs. Implicit Methods

**Explicit Methods** (Forward Euler, Modified Euler):
- Calculate the next value $y_{n+1}$ based solely on previously known values
- Easier to implement and computationally less expensive per step
- Have limited stability regions, especially problematic for stiff ODEs
- Require very small step sizes for stability with stiff problems, often making them computationally inefficient

**Implicit Methods** (Backward Euler):
- Calculate $y_{n+1}$ using information from both the current and future states
- Require solving an equation at each step, making them computationally more expensive per step
- Have much larger (often unlimited) stability regions
- Can use larger step sizes while maintaining stability, potentially making them more efficient for stiff problems despite the higher cost per step

For stiff ODEs, implicit methods are generally preferred because they allow for larger step sizes while maintaining stability, which often compensates for their higher computational cost per step.

## Stability Condition for Forward Euler

To determine the stability condition for the Forward Euler method applied to the linear ODE $\frac{dy}{dt} = \lambda y$:

1. The Forward Euler update formula is $y_{n+1} = y_n + h\lambda y_n = (1 + h\lambda)y_n$

2. After $n$ steps: $y_n = (1 + h\lambda)^n y_0$

3. For stability, we need $|y_n|$ to remain bounded as $n$ increases, which requires $|1 + h\lambda| < 1$

4. For our problem with $\lambda = -50$:
   - The stability condition becomes $|1 - 50h| < 1$
   - This simplifies to $0 < h < \frac{2}{50} = 0.04$

5. Experimental verification: 
   - With $h = 0.04$, we're exactly at the stability boundary, explaining the observed oscillations
   - With $h < 0.04$, Forward Euler should be stable
   - With $h > 0.04$, Forward Euler will be unstable

The theoretical stability condition perfectly matches our experimental observations. For $h = 0.04$, we have $|1 + \lambda h| = |1 - 50 \times 0.04| = |1 - 2| = |-1| = 1$, which is right at the stability boundary, explaining the persistent oscillations without growth or decay.

## Conclusion

This investigation highlights the challenges of solving stiff ODEs using numerical methods:

1. **Forward Euler** is simple but requires extremely small step sizes for stability with stiff problems, making it computationally inefficient.

2. **Modified Euler** provides better accuracy for non-stiff problems but still struggles with stability for stiff ODEs.

3. **Backward Euler** demonstrates superior stability characteristics for stiff problems, allowing for larger step sizes while maintaining stability.

The analysis confirms that for stiff ODEs, implicit methods like Backward Euler are generally preferred due to their unconditional stability. While they may be more computationally intensive per step, they often allow for larger step sizes, potentially reducing the overall computational cost compared to explicit methods that require very small step sizes to maintain stability.

This exercise effectively illustrates the importance of choosing appropriate numerical methods based on the characteristics of the ODE being solved, particularly when dealing with stiff problems.