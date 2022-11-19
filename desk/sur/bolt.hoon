::
::  Modified original from /sur/whitelist.hoon by ~hosted-fornet
::
|%
+$  blacklist  [%blacklist users=(set ship)]
+$  whitelist  [%whitelist users=(set ship)]
 
+$  lizst  
  $%  whitelist
      blacklist
  ==

::
+$  bean  
  $%  [%toggle-kids ~]
      [%toggle-which ~]
      [%add-white users=(set ship)]
      [%add-black users=(set ship)]
      [%remove-white users=(set ship) crumb=(unit path)]
      [%remove-black users=(set ship) crumb=(unit path)]
  ==
--  
