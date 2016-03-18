#!/bin/csh

#
# Usual "fid.com" script, adjusted to take input, output, and tau
# values from the command-line.
#
# This version assumes that the raw spectrometer format data
# has been compressed with the "compress" command.

if ($#argv != 3) then
   echo "Adjusted conversion script. Usage:"
   echo "   fid.com inName outName tau"
   exit
endif

set inName  = $argv[1]
set outName = $argv[2]
set tau     = $argv[3]

zcat $inName | bruk2pipe -tau $tau -aswap \
  -xN           1536    -yN         300  \
  -xT            768    -yT         150  \
  -xMODE     Complex    -yMODE  Complex  \
  -xSW       9259.25    -ySW    1557.63  \
  -xOBS   600.140778    -yOBS  60.81855  \
  -xCAR         4.75    -yCAR     116.5  \
  -xLAB           HN    -yLAB         N  \
  -ndim            2    -aq2D    States  \
  -out $outName -verb -ov

