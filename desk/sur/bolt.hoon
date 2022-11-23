::
::  Modified original from /sur/whitelist.hoon by ~hosted-fornet
::
|%
+$  bean
  $%  [%add-white users=(set ship)]
      [%add-black users=(set ship)]
      [%remove-white users=(set ship)]
      [%remove-black users=(set ship)]
      [%toggle-kids switch=?]
      [%toggle-white switch=?]
  ==
--
