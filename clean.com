#!/bin/csh

set fileList = (autoFit.com modelExp.com axt.tab nlin.tab \
                apod.x apod.y apod.z hdr.out)

set listList = (nlin.spec.list series.list sim.spec.list apod.list)
set dirList  = (fid ft sim dif txt mod gnu plot)

foreach name ($fileList)
   if (-e $name) then
      /bin/rm $name
   endif
end

foreach name ($listList)
   if (-e $name) then
      /bin/rm $name
   endif
end

foreach dir ($dirList)
   if (-e $dir) then
      /bin/rm -rf $dir
   endif
end
