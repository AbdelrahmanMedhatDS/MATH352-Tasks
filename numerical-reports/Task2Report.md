# Numerical Solution of an Ordinary Differential Equation (ODE)

## **1. Introduction**

This report presents the numerical solution of the ordinary differential equation:

\[
\frac{dy}{dt} = -50y + \sin(t), \quad y(0) = 1
\]

using multiple numerical methods, including **Euler methods, Runge-Kutta methods, and Multi-Step methods**. The goal is to compare their stability and accuracy.

## **2. Methodology**

### **2.1 Implemented Methods**

- **Euler Methods:**
  - Forward Euler: \( y\_{n+1} = y_n + h f(t_n, y_n) \)
  - Modified Euler (Heun's Method): \( y*{n+1} = y_n + \frac{h}{2} \left[ f(t_n, y_n) + f(t*{n+1}, y\_{pred}) \right] \)
  - Backward Euler: \( y*{n+1} = \frac{y_n + h \sin(t*{n+1})}{1 + 50h} \)
- **Runge-Kutta Methods:**
  - Second-Order Runge-Kutta (Midpoint Method)
  - Fourth-Order Runge-Kutta (RK4)
- **Multi-Step Methods:**
  - Adams-Bashforth (Explicit)
  - Adams-Moulton (Implicit)

### **2.2 Parameters Used**

- Initial Condition: \( y_0 = 1 \)
- Time Interval: \( t_0 = 0 \) to \( t_f = 2 \)
- Step Sizes Tested: \( h = 0.04, 0.02, 0.1 \)

## **3. Results & Analysis**

### **3.1 Forward Euler Behavior**

- For \( h = 0.04 \), the method shows **oscillations** and instability as time progresses.
- For \( h = 0.1 \), the solution **diverges** completely, confirming instability.
- For \( h = 0.02 \), the method is **more stable but still less accurate**.

### **3.2 Modified Euler & Backward Euler Behavior**

- Modified Euler improves accuracy but still struggles with larger step sizes.
- Backward Euler remains stable regardless of \( h \), making it suitable for stiff problems.

### **3.3 Runge-Kutta Methods**

- **Second-Order (Midpoint Method):**
  - Provides better accuracy than Euler’s methods.
  - Still struggles with very large step sizes.
- **Fourth-Order (RK4):**
  - Extremely accurate and stable.
  - Even for larger \( h \), it maintains high precision.

### **3.4 Multi-Step Methods**

- **Adams-Bashforth (Explicit):**
  - More accurate than single-step methods but can be unstable if \( h \) is too large.
- **Adams-Moulton (Implicit):**
  - Provides stability similar to Backward Euler but with higher accuracy.

### **3.5 Step Size Impact**

- Smaller \( h \) improves accuracy but increases computation time.
- Larger \( h \) causes instability in explicit methods (Forward Euler, Adams-Bashforth).
- Implicit methods (Backward Euler, Adams-Moulton) remain stable.

## **4. Stability Condition for Forward Euler**

The stability condition for Forward Euler applied to \( \frac{dy}{dt} = \lambda y \) is:

\[
|1 + h \lambda| < 1
\]
Applying \( \lambda = -50 \), we get:

\[
0 < h < 0.04
\]

This aligns with experimental results where instability was observed for \( h \geq 0.04 \).

## **5. Conclusion**

- **Euler methods are simple but can be unstable.**
- **Runge-Kutta methods, especially RK4, provide excellent accuracy and stability.**
- **Multi-step methods improve efficiency but require more storage.**
- **Implicit methods like Backward Euler and Adams-Moulton are best for stiff problems.**
