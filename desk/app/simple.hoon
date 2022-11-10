::  Poke this with mark %inc or %dec
::  and a (unit @). ~ is single step
::  while `5 is five steps.
::
/+  default-agent, verb, dbug, bolt, agentio
::
%-  agent:dbug
%-  agent:bolt
%+  verb  &
^-  agent:gall
::
=/  count  *@ud
::
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this |) bowl)
::
++  on-init
  ~&  >  counter=count
  on-init:def
::
++  on-save  !>(count)
::
++  on-load
  |=  old=vase
  =.  count  !<(@ud old)
  ~&  >  counter=count
  `this
::
++  on-poke
  |=  [=mark =vase]
  ?:  =(%forward mark)
    =/  faze  !<([@p (unit @)] vase)
    :_  this
    :~  (~(poke pass:agentio /forward) [-.faze %simple] [%inc !>(+.faze)])
    ==
  =.  count
    %+  ?+(mark !! %inc add, %dec sub)
      count
    ?-  cmd=!<((unit @) vase)
      ~  1
      ^  u.cmd
    ==
  ~&  >  counter=count
  `this
::
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-peek   on-peek:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
