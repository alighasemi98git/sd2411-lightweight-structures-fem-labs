# SD2411: Lightweight Structures and FEM — Computer Labs

This repository contains MATLAB codes and related files developed for the **SD2411 Lightweight Structures and FEM** course computer labs. The work focuses on beam theory, finite element method (FEM) implementation, and the comparison of analytical, numerical, and commercial FE software (ANSYS) results.

---

## Labs

### **Lab 1 – Your Own FE-Code**

* Develop a MATLAB finite element code for beam analysis.
* Implement bending, torsion (St. Venant), and Euler/torsion buckling calculations.
* Verify the code against analytical solutions (concentrated loads, distributed loads, torques).
* Extend the code to calculate critical buckling loads and corresponding modes.

### **Lab 2 – Cantilever with Thin-Walled Cross-Section**

* Analyze a thin-walled cantilever beam under point loading.
* Perform calculations using three approaches:

  1. Analytical methods (shear flow, shear centre, displacements, buckling).
  2. MATLAB FE-code (from Lab 1).
  3. ANSYS shell-element modelling.
* Compare displacements, stresses, strain energy, and buckling loads/modes across the three approaches.
* Discuss similarities, discrepancies, and sources of error.

---

## Structure

```
├── lab1-fe-code/          # MATLAB implementation of FE beam code
│   ├── mainbeam.m
│   ├── assemble.m
│   ├── elk.m
│   ├── elksigma.m
│   ├── elq.m
│   ├── bending.m
│   └── buckle.m
│
├── lab2-thinwalled/       # MATLAB simulations for cantilever thin-walled beam
│   ├── analytical_calcs.m
│   ├── fe_simulation.m
│   └── comparison_plots.m
│
└── README.md              # This file
```

---

## Requirements

* MATLAB R2020a or later.
* Basic knowledge of FEM, beam theory, and MATLAB programming.
* ANSYS (for Lab 2, comparison studies).

---

## Notes

* All codes are educational and follow the course lab instructions.
* Results may differ depending on mesh density, boundary condition setup, and parameter choices.
* Contributions and improvements (e.g., adding tapered beam analysis, vibration analysis) are welcome.

---

**Course:** SD2411 Lightweight Structures and FEM
**Institution:** KTH Royal Institute of Technology
