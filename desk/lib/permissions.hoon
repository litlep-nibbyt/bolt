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
      ~&  >>  ^-  return  `lizst(users (~(uni in users.lizst) users.target.comm))
      `lizst(users (~(uni in users.lizst) users.target.comm))
    ::
    ==
  ::
      %remove
::    %^  clean-client-list  client-path  bowl
    ?-    -.target.comm 
    ::
        %kids
      `lizst(kids %.n)
    ::
        %users
      `lizst(users (~(dif in users.lizst) users.target.comm))
    ::
    ==
  ==
::
++  clean-white
  |=  [client-path=(unit path) =bowl:gall =whitelist]
  ^-  return
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
++  clean-black
  |=  [client-path=(unit path) =bowl:gall =blacklist]
  ^-  return
  =/  to-kick=(set ship)
    %-  silt
    %+  murn  ~(tap in users.blacklist)
    |=  c=ship  ^-  (unit ship)
    ?:((is-allowed c blacklist bowl) ~ `c)
  =.  users.blacklist  (~(dif in users.blacklist) to-kick)
  :_  blacklist
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
  :: allow if you're the owner OR (you are a kid OR not in blacklist)
  ::
      %blacklist
    ?|  =(our.bowl user)
       &(kids.lizst (is-kid bowl)) 
       !(~(has in users.lizst) user)
     ==
  ::
  :: allow if you're the owner OR (a kid OR in whitelist)
  ::
      %whitelist
    ?|  =(our.bowl user)
      &(kids.lizst (is-kid bowl)) 
      (~(has in users.lizst) user)
    ==
  ==
  ::
  ++  is-kid
    |=  =bowl:gall
    =(our.bowl (sein:title our.bowl now.bowl user))
  ::
  --
--  
