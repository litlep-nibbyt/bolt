::
::  Modified original from /sur/whitelist.hoon by ~hosted-fornet
::
|%
+$  blacklist  [%blacklist users=(set ship)]
+$  whitelist  [%whitelist users=(set ship)]
 
+$  lizst  
  $%  blacklist
      whitelist
  ==
::
+$  return
  $:  cards=(list card:agent:gall)
      nu=lizst
  ==
::
+$  bean  
  $%  [%toggle-kids ~]
      [%toggle-which ~]
      [%add-users users=(set ship)]
      [%remove-users users=(set ship) crumb=(unit path)]
  ==
--  
