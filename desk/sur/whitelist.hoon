::
::  Modified original from ~hosted-fornet
::
|%
+$  whitelist
  $:  public=?
      kids=?
      users=(set ship)
  ==
::
+$  target
  $%  [%public ~]
      [%kids ~]
      [%users users=(set ship)]
  ==
::
+$  command
  $%  [%add-whitelist wt=target]
      [%remove-whitelist wt=target]
  ==
::
+$  return
  $:  cards=(list card:agent:gall)
      =whitelist
  ==
::
+$  bean  [%command crumb=(unit path) =command]
--  
