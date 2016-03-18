#!/bin/csh

#
# Display original data, model, and residual spectrum:

nmrDraw -in ft/test%03d.ft2 -hi 7.0e+5 \
        -broadcast `getGeom -left`  -nophase -group 1 &

sleep 3

nmrDraw -in sim/test%03d.ft2 -hi 7.0e+5 \
        -broadcast `getGeom -mid`   -nophase -group 1 &

sleep 3

nmrDraw -in dif/test%03d.ft2 -hi 7.0e+5 \
        -broadcast `getGeom -right` -nophase -group 1 &

