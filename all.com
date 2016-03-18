#!/bin/csh

#
# all.com: Example relaxation curve analysis (requires Gnuplot)
#          See README for details.

#
# Erase existing results.
# Convert and process spectra.
# (Peak pick a representative spectrum with NMRDraw).
# Extract the evolution curves for each peak by pseudo-3D fitting.
# Display the results of the pseudo-3D fit.
# Fit each evolution curve to a relaxation expression.
# Optional: display the evolution curves interactively.

clean.com
proc.com

fit.com
view3.com

model.com

showEvolve.tcl
