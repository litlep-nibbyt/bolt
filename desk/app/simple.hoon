::  Poke this with mark %inc or %dec
::  and a (unit @). ~ is single step
::  while `5 is five steps.
::
/-  *simp
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
  ?:  ?=(%test mark)
    =/  faze  !<(poak vase)
    =/  to=@p  to.faze
    ?-  -.payload.faze
        %inc
      :_  this
      [(~(poke pass:agentio /test) [to.faze %simple] [%inc !>(+.payload.faze)])]~
  ::
        %dec
      :_  this
      [(~(poke pass:agentio /test) [to.faze %simple] [%inc !>(+.payload.faze)])]~
  ::
        %watch-self
     :_  this
     [(~(watch-our pass:agentio /test) dap.bowl /website/initialize)]~
  ::
        %watch
     :_  this
     [(~(watch pass:agentio /test) [to.faze dap.bowl] /website/initialize)]~
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
