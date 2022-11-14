::
::  Pokes for %simple agent 
::

|%
+$  poak
  $%  [%send to=ship =payload]
  ==

+$  payload
  $%  [%inc (unit @)]
      [%dec (unit @)]
      [%watch-self ~]
      [%watch ~]
  ==
--
