::
::  /lib/whitelist/hoon by ~hosted-fornet
::
/-  wl=whitelist
|%
++  handle-command
  |=  $:  comm=command:wl
          =whitelist:wl
          client-path=(unit path)
          =bowl:gall
      ==
  ^-  return:wl
  ?-    -.comm
      %add-whitelist
    ?-  -.wt.comm
        %public
      `whitelist(public %.y)
    ::
        %kids
      `whitelist(kids %.y)
    ::
        %users
      `whitelist(users (~(uni in users.whitelist) users.wt.comm))
    ::
    ==
  ::
      %remove-whitelist
    %^  clean-client-list  client-path  bowl
    ?-    -.wt.comm 
        %public
      whitelist(public %.n)
    ::
        %kids
      whitelist(kids %.n)
    ::
        %users
      whitelist(users (~(dif in users.whitelist) users.wt.comm))
    ::
    ==
  ==
::
++  clean-client-list
  |=  [client-path=(unit path) =bowl:gall =whitelist:wl]
  ^-  return:wl
  =/  to-kick=(set ship)
    %-  silt
    %+  murn  ~(tap in users.whitelist)
    |=  c=ship  ^-  (unit ship)
    ?:((is-allowed c whitelist bowl) ~ `c)
  =.  users.whitelist  (~(dif in users.whitelist) to-kick)
  :_  whitelist
  ?~  client-path  ~
  %+  turn  ~(tap in to-kick)
  |=(c=ship [%give %kick ~[u.client-path] `c])
::
++  is-allowed
  |=  [user=ship =whitelist:wl =bowl:gall]
  ^-  ?
  |^
  ?|  public.whitelist
      =(our.bowl user)
      ?&(kids.whitelist (is-kid bowl))
      (~(has in users.whitelist) user)
  ==
  ::
  ++  is-kid
    |=  =bowl:gall
    =(our.bowl (sein:title our.bowl now.bowl user))
  ::
  --
--  
