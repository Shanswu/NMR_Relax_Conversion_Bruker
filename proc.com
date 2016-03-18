#!/bin/csh

#
# Script to convert and process a 2D spectral series:
#
# 1. Adjust the "tauList" and "dirList" values in this script. 
#
# 2. Prepare the usual conversion and processing scripts,
#    but adjusted to take input and output names from the
#    command-line:
#
#    fid.com inName outName tau
#    ft2.com inName outName
#
# The general-purpose script "seriesT.com" is used to adjust the
# header of the result files so that they can be treated as 3D data.
 
set tauList = (8 64 136 232 336 472 664 800)
set dirList = (1  2   3   4   5   6   7   8)

#
#---------------------------------------------------------------------

if (!(-e fid)) then
   mkdir fid
endif

if (!(-e ft)) then
   mkdir ft
endif

set n = $#tauList
set i = 1

while ($i <= $#tauList)
   set rawName = $dirList[$i]/ser.Z
   set fidName = (`printf fid/test%03d.fid $i`)
   set ftName  = (`printf ft/test%03d.ft2 $i`)
   set tau     = $tauList[$i]

   echo Raw: $rawName FID: $fidName FT: $ftName TAU: $tau

   fid.com $rawName $fidName $tau
   ft2.com $fidName $ftName

   echo ""

   @ i++ 
end 

seriesT.com ft/test*ft2
