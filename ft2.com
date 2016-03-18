#!/bin/csh

#
# Usual "ft2.com" script, adjusted to take input, output
# values from the command-line.
#

if ($#argv != 2) then
   echo "Adjusted processing script. Usage:"
   echo "   ft2.com inName outName"
   exit
endif

set inName  = $argv[1]
set outName = $argv[2]

nmrPipe -in $inName \
| nmrPipe -fn POLY -time                            \
| nmrPipe -fn GM -g1 10 -g2 15 -c 0.5               \
| nmrPipe -fn ZF -zf 2 -auto                        \
| nmrPipe -fn FT -verb                              \
| nmrPipe -fn EXT -x1 5.8ppm -xn 9.8ppm -sw         \
| nmrPipe -fn PS -p0 -88.2 -p1 1.2 -di              \
| nmrPipe -fn TP                                    \
| nmrPipe -fn GM -g1 3 -g2 8 -c 0.5                 \
| nmrPipe -fn ZF -zf 2 -auto                        \
| nmrPipe -fn FT -verb                              \
| nmrPipe -fn PS -p0 0.0 -p1 0.0 -di                \
| nmrPipe -fn TP                                    \
| nmrPipe -fn POLY -auto                            \
   -verb -ov -out $outName


