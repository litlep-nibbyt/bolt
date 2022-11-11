::
::  Modified original from /lib/whitelist.hoon by ~hosted-fornet
::
|%
+$  blacklist  [%blacklist kids=? users=(set ship)]
+$  whitelist  [%whitelist kids=? users=(set ship)]
+$  lizst  
  $%  blacklist
      whitelist
  ==
::
+$  target
  $%  [%kids ~]
      [%users users=(set ship)]
  ==
::
+$  command
  $%  [%add =target]
      [%remove =target]
  ==
::
+$  return
  $:  cards=(list card:agent:gall)
      =lizst
  ==
::
+$  bean  
  $%  [%command crumb=(unit path) =command]
      [%toggle ~]
  ==
--  
