/-  sir=whitelist
/+  verb, default-agent, agentio, *whitelist

|% 
+$  card  card:agent:gall
+$  state-0
  $:  [%0 =whitelist.sir]
  ==
::
++  agent
  |=  yosh=agent:gall          :: MatrYOSHka doll
  =|  state-0
::
  =*  state  -
  %+  verb  &
  ::
  ^-  agent:gall
  |_  =bowl:gall
  +*  this  .
      def  ~(. (default-agent this %.n) +<)
      ag    yosh
      io    ~(. agentio bowl)
  ::
  ++  on-init   on-init:def
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card agent:gall)
    =*  call-inner
      =^  cards  yosh  (on-poke:ag mark vase)
      [cards this]
    ::
    ::  Check for %bolt-poke (for manipulating whitelist)
    ?.  =(mark %bolt-poke)
      :: If it is, call inner if ship is allowed
      ?>  (is-allowed src.bowl whitelist bowl)
        call-inner
    ::
    ::  If not, poke is for manipulating whitelist
    =/  a  !<(bean.sir vase) 
    =/  =return.sir  (handle-command command.a whitelist crumb.a bowl)
    ~&  >  +:return
    `this(whitelist +:return)
  ++  on-save
    ^-  vase
    %+  slop
      on-save:yosh
    !>  [%bolt state] 
  ++  on-load
    |=  old=vase
    ^-  (quip card agent:gall)
    ::
    :: Unpack vase
    =/  gads  !<([@ud %bolt state-0] old)
    ::
    :: Update of yosh state to inner onload,
    =^  cards  yosh  (on-load:yosh !>(-.gads)) 
    ::
    :: Return quip with inner cards and %bolt state updated
    [cards this(state +.+.gads)]
  ++  on-watch 
    |=  =path
    ^-  (quip card agent:gall)
    ::  Check if ship is allowed
    ?>  (is-allowed src.bowl whitelist bowl)  
    ::
    ::  If allowed, call inner
    =^  cards  yosh  (on-watch:yosh path) 
    [cards this]
  ++  on-leave
    |=  =path
    ^-  (quip card agent:gall)
    =^  cards  yosh  (on-leave:yosh path) 
    [cards this]
  ++  on-peek 
    |=  =path
    ^-  (unit (unit cage))
    (on-peek:yosh path)
  ++  on-agent 
    |=  [=wire =sign:agent:gall]
    ^-  (quip card agent:gall)
    =^  cards  yosh  (on-agent:yosh wire sign) 
    [cards this]
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  --
--
