::
::  based on /lib/whitelist/hoon by ~hosted-fornet
::
/-  *bolt
|%
++  handle-command
  |=  $:  comm=command
          =lizst
          client-path=(unit path)
          =bowl:gall
      ==
  ^-  return
  ?-    -.comm
::
      %add
    ?-  -.target.comm
        %kids
      `lizst(kids %.y)
    ::
        %users
      `lizst(users (~(uni in users.lizst) users.target.comm))
    ::
    ==
  ::
      %remove
    %^  clean-subs  client-path  bowl
    ?-    -.target.comm 
    ::
        %kids
      lizst(kids %.n)
    ::
        %users
      lizst(users (~(dif in users.lizst) users.target.comm))
    ::
    ==
  ==
::
++  clean-subs
  |=  [client-path=(unit path) =bowl:gall =lizst]
  ^-  return
  =/  to-kick=(set ship)
    %-  silt
    %+  murn  ~(tap in users.lizst)
    |=  c=ship  ^-  (unit ship)
    ?:((is-allowed c lizst bowl) ~ `c)
  =.  users.lizst  (~(dif in users.lizst) to-kick)
  :_  lizst
  ?~  client-path  ~
  %+  turn  ~(tap in to-kick)
  |=(c=ship [%give %kick ~[u.client-path] `c])
::
++  is-allowed
  |=  [user=ship =lizst =bowl:gall]
  ^-  ?
  |^
  ?-  -.lizst
  ::
  :: allow if you're the owner OR not in blacklist,
  :: if kids is %&, do not allow if parent is blacklisted 
  ::
      %blacklist
    ?|  =(our.bowl user)
      ?&  !(~(has in users.lizst) user)
          &(kids.lizst !(is-kid bowl))
      ==
    ==
  ::
  :: allow if you're the owner OR in a whitelist
  :: if kids is %&, allow if parent is whitelisted or parent is owner
  ::
      %whitelist
    ?|  =(our.bowl user)
        (~(has in users.lizst) user)
        &(kids.lizst (is-kid bowl))
    ==
  ==
  ::
  ++  is-kid
    |=  =bowl:gall
    ?|  =(our.bowl (sein:title our.bowl now.bowl user))
        (~(has in users.lizst) (parent bowl))
    ==
  ++  parent
    |=  =bowl:gall
    (sein:title our.bowl now.bowl user)
  ::
  --
--  
