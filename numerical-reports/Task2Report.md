# Numerical Stability Analysis for Stiff ODEs

## Introduction

This report examines the numerical stability challenges associated with solving stiff ordinary differential equations (ODEs). We focus on the following first-order linear ODE:

```
dy/dt = -50*y + sin(t)
y(0) = 1
```

This ODE models a system with a rapid decay component (-50*y) and a sinusoidal forcing function (sin(t)). The rapid decay term makes this a stiff ODE, characterized by widely varying time scales.

## Parameters

- **Initial time (t₀)**: 0
- **Final time (t_f)**: 2
- **Initial condition (y₀)**: 1
- **Primary step size (h)**: 0.04
- **Additional test step sizes**: 0.02, 0.05

## Methods Implemented

1. **Runge-Kutta Methods**
   - RK2 (Midpoint Method)
   - RK4 (Classical Fourth-Order Method)

2. **Multi-step Methods**
   - Adams-Bashforth (2-step) - Explicit
   - Adams-Moulton (2-step) - Implicit

3. **Basic Methods for Comparison**
   - Explicit Euler
   - Implicit Euler

## Analysis and Discussion

### 1. Runge-Kutta Methods Behavior

#### RK2 (Midpoint Method)
- **Behavior**: With h = 0.04, the RK2 method shows significant instability. The solution rapidly oscillates with growing amplitude, completely deviating from the true solution.
- **Stability**: The RK2 method is unstable for this problem with h = 0.04 because the step size exceeds the stability limit. For this stiff ODE with λ = -50, the stability condition is approximately h < 0.056 (h|λ| < 2.8).
- **Explanation**: Despite being more accurate than Euler, RK2 still has limited stability for stiff problems. The instability manifests as growing oscillations due to the method amplifying errors at each step.

#### RK4 Method
- **Behavior**: With h = 0.04, RK4 performs better than RK2 but still shows some instability, especially for longer time periods.
- **Stability**: While RK4 has a larger stability region than RK2, it's still not sufficient for extremely stiff problems without using very small step sizes.
- **Explanation**: RK4's instability is less severe due to its larger stability region (approximately h|λ| < 2.8), but it still struggles with this stiff ODE at the given step size.

### 2. Multi-step Methods Behavior

#### Adams-Bashforth (2-step)
- **Behavior**: With h = 0.04, this explicit multi-step method is highly unstable, showing large oscillations that grow rapidly.
- **Stability**: It's unstable for this problem because its stability region is smaller than even Euler's method.
- **Explanation**: The Adams-Bashforth method uses information from previous steps to predict the next value, but for stiff problems, this can amplify errors quickly when the step size is too large relative to the eigenvalues of the system.

#### Adams-Moulton (2-step)
- **Behavior**: This implicit multi-step method shows much better stability than Adams-Bashforth.
- **Stability**: It's stable for h = 0.04 due to its larger stability region.
- **Explanation**: The Adams-Moulton method's implicit nature gives it better stability properties, allowing it to handle stiff ODEs more effectively without requiring extremely small step sizes.

### 3. Step Size Impact

- **Decreasing h to 0.02**: All methods become more stable. Even the explicit methods (Euler, RK2, Adams-Bashforth) show improved behavior as the step size falls within their stability regions.
- **Increasing h to 0.05**: The explicit methods become more unstable with larger oscillations, while implicit methods remain relatively stable.
- **Stability regions**: The impact of step size directly relates to the stability region of each method. For the explicit methods, the product h|λ| needs to be within specific bounds (with λ = -50):
  - Explicit Euler: h < 0.04 (h|λ| < 2)
  - RK4: h < 0.056 (h|λ| < 2.8)
  - Adams-Bashforth (2-step): h < 0.02 (h|λ| < 1)

### 4. Explicit vs. Implicit Methods

- **Explicit Methods**: Calculate the next value using only the current state (and possibly previous states for multi-step methods). Examples are Euler explicit, RK methods, and Adams-Bashforth.
  - *Advantage*: Computationally simpler (no need to solve equations at each step)
  - *Disadvantage*: Limited stability regions, requiring very small step sizes for stiff problems

- **Implicit Methods**: Require solving an equation to find the next value, involving the next value itself. Examples are Euler implicit and Adams-Moulton.
  - *Advantage*: Much better stability properties (often unconditionally stable)
  - *Disadvantage*: Computationally more expensive as they require solving an equation at each step

For stiff ODEs, the choice of method is critical:
- Explicit methods require extremely small step sizes to remain stable, making them inefficient
- Implicit methods can use larger step sizes while maintaining stability, making them preferable despite the increased computational cost per step

### 5. Stability Condition

For our specific ODE dy/dt = -50y + sin(t), we can analytically determine the stability conditions by analyzing the linearized system (focusing on λ = -50):

#### Explicit Euler:
- Stability condition: |1 + hλ| < 1
- For λ = -50: |1 - 50h| < 1
- This gives: -1 < 1 - 50h < 1
- Which simplifies to: h < 0.04

With our test step size h = 0.04, we have h|λ| = 2, which is exactly at the stability boundary for Explicit Euler, explaining why we see oscillations beginning to grow.

#### RK4:
- Approximate stability condition: h|λ| < 2.8
- For λ = -50: h < 0.056

Our experimental observations match these theoretical predictions:
- At h = 0.02, all methods are stable as predicted
- At h = 0.04, Explicit Euler is on the stability boundary, RK2 shows mild instability, and implicit methods remain stable
- At h = 0.05, explicit methods show significant instability while implicit methods remain stable

## Conclusion

This analysis demonstrates why stiff ODEs present significant challenges for numerical methods. The large negative eigenvalue (-50) forces explicit methods to use impractically small step sizes to remain stable. Implicit methods, while more computationally expensive per step, allow for much larger step sizes while maintaining stability, making them the preferred choice for stiff systems.

The stability analysis confirms that the behavior we observe in our numerical experiments closely matches theoretical predictions based on the stability regions of each method. This illustrates the fundamental trade-off in numerical ODE solving: stability versus computational efficiency.

For this particular stiff ODE, the implicit methods (Implicit Euler and Adams-Moulton) provide the most stable solutions across all tested step sizes, while explicit methods require step sizes smaller than 0.04 to achieve stability.