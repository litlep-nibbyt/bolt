/-  sir=whitelist
/+  verb, default-agent, agentio, *whitelist

|% 
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==

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
    ::  Check for %bolt-poke
    ?.  =(mark %bolt-poke)
      ::
      :: If not, call inner if ship is allowed
      ?>  (is-allowed src.bowl whitelist bowl)
        call-inner
    ::
    ::  If it is, poke is for manipulating whitelist
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
    :: Grab inner vase, unpack bolt-vase
    =/  inner-v  (slot 2 old)
    =/  flower  +:!<([%bolt state-0] (slot 3 old))
    ?-  -.flower
        %0
      ::
      :: Update of yosh state to inner onload,
      =^  cards  yosh  (on-load:yosh inner-v) 
      ::
      :: Return quip with inner cards and %bolt state updated
      [cards this(state flower)]
    ==
  ++  on-watch 
    |=  =path
    ^-  (quip card agent:gall)
    ::
    ::  TODO http stuff
    ?:  ?=(%bolt -.path)  `this
    ::
    ::  Check if ship is allowed
    ?>  (is-allowed src.bowl whitelist bowl)  
    ::
    ::  If allowed, call inner
    =^  cards  yosh  (on-watch:yosh path) 
    [cards this]
  ++  on-leave
    |=  =path
    ^-  (quip card agent:gall)
    ?:  ?=(%bolt -.path)  `this
    =^  cards  yosh  (on-leave:yosh path) 
    [cards this]
  ++  on-peek  on-peek:yosh
  ++  on-agent 
    |=  [=wire =sign:agent:gall]
    ^-  (quip card agent:gall)
    ?.  ?=(%bolt -.wire)
      ::
      :: If not a bolt wire, call inner
      =^  cards  yosh  (on-agent:yosh wire sign) 
      [cards this]
    ::
    ::  Otherwise, check for poke-ack
    ?.  ?=(%poke-ack -.sign)  `this
    ?~  p.sign  `this
    ((slog u.p.sign) `this)
::
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  --
--
