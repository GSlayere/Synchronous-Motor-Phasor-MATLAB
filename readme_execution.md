# 🔄 Synchronous Motor Phasor Visualization in MATLAB

This MATLAB project visualizes the phasor diagram of a synchronous motor to help understand how **field excitation** affects the **power factor** — a critical concept in electrical engineering.

## What It Does

Based on user inputs, this script:
- Calculates and plots:
  - 🟦 Terminal Voltage (V)
  - 🟥 Back EMF (Eb)
  - 🟩 Resultant Voltage (Er)
  - 🟪 Armature Current (Ia)
- Simulates different excitation conditions:
  - Under-excited (lagging power factor)
  - Over-excited (leading power factor)
  - Unity power factor
- Helps visualize the vector relationships between V, Eb, Er, and Ia

##  Why This Project?

As electrical engineering students, we often learn phasor theory theoretically. This tool provides **a visual learning experience** by combining electrical equations with MATLAB simulation.

##  How to Run

1. Open `phasor_diagram_motor.m` in MATLAB.
2. Run the script and enter values as prompted.
   - Example inputs:
     Enter V: 1000
     Enter Eb: 1200
     Angle of Eb (deg): -30
     Ra: 0.2
     Xl: 0.6
     Xa: 0.8

3. View the generated phasor plot showing motor behavior.

##  Collaborators

- Bibek Neupane(https://github.com/GSlayere)

## Tools Used

- MATLAB
- Complex numbers and vector math
- Phasor analysis of synchronous machines



