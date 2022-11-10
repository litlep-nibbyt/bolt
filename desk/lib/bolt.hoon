/-  sir=whitelist
/+  verb, agentio, *whitelist

|% 
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =whitelist.sir]
::
++  agent
  |=  yosh=agent:gall          :: MatrYOSHka doll
  =|  state-0
  =*  state  -
  ::
  %+  verb  &
  ::
  ^-  agent:gall
  |_  =bowl:gall
  +*  this  .
      ag    ~(. yosh bowl)
      io    ~(. agentio bowl)
  ::
  ++  on-init
    =^  cards  yosh  on-init:ag
    [cards this]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card agent:gall)
    ::
    ::  Check for %bolt-poke
    ?.  =(mark %bolt-poke)
      ::
      :: If not, call inner if ship is allowed
      ?>  (is-allowed src.bowl whitelist bowl)
      =^  cards  yosh  (on-poke:ag mark vase)
      [cards this]
    ::
    ::  If it is, poke is for manipulating whitelist
    =/  a  !<(bean.sir vase) 
    =/  =return.sir  (handle-command command.a whitelist crumb.a bowl)
    ~&  >  +:return
    `this(whitelist +:return)
  ::
  ++  on-save
    ^-  vase
    %+  slop  on-save:ag
    !>  [%bolt state]
  ::
  ++  on-load
    |=  old=vase
    ^-  (quip card agent:gall)
    ::
    :: Update of yosh state to inner onload,
    =^  cards  yosh  (on-load:ag (slot 2 old)) 
    ::
    :: Return quip with inner cards and %bolt state updated
    :-  cards
    this(state +:!<([%bolt state-0] (slot 3 old)))
  ::
  ++  on-watch 
    |=  =path
    ^-  (quip card agent:gall)
    ::
    ::  TODO http stuff
    ?:  ?=([%bolt *] path)  `this
    ::
    ::  Check if ship is allowed
    ?>  (is-allowed src.bowl whitelist bowl)  
    ::
    ::  If allowed, call inner
    =^  cards  yosh  (on-watch:ag path) 
    [cards this]
  ::
  ++  on-leave
    |=  =path
    ^-  (quip card agent:gall)
    ?:  ?=([%bolt *] path)  `this
    =^  cards  yosh  (on-leave:ag path) 
    [cards this]
  ::
  ++  on-peek  on-peek:ag
  ++  on-agent 
    |=  [=wire =sign:agent:gall]
    ^-  (quip card agent:gall)
    ?.  ?=([%bolt *] wire)
      ::
      :: If not a bolt wire, call inner
      =^  cards  yosh  (on-agent:ag wire sign) 
      [cards this]
    ::
    ::  Otherwise, check for poke-ack
    ?.  ?=(%poke-ack -.sign)  `this
    ?~  p.sign  `this
    ((slog u.p.sign) `this)
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    =^  cards  yosh  (on-arvo:ag wire sign-arvo)
    [cards this]
  ::
  ++  on-fail
    |=  [=term =tang]
    =^  cards  yosh  (on-fail:ag term tang)
    [cards this]
  --
--
