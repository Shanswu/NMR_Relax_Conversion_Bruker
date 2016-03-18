#!/bin/csh

autoFit.tcl -specName ft/test%03d.ft2 -series -inTab relax.master.tab -time 

