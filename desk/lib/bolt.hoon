::
::  %bolt: whitelist/blacklist wrapper for agents
::
::  usage:
::  /+  bolt
::  ...
::  %-(agent:bolt your-agent)
::

/-  *bolt
/+  verb, agentio, *permissions

|% 
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0  
  $:  %0 
      which=?(%black %white) 
      =blacklist 
      =whitelist
  ==
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
      roster  ?-(which %black blacklist, %white whitelist)
      allowed  %:(is-allowed src.bowl roster bowl)
  ::
  ++  on-init
    =^  cards  yosh  on-init:ag
    [cards this]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card agent:gall)
    ::
    ::  Check for %bolt poke
    ?.  ?=(%bolt mark)
      ::
      :: If not, call inner if ship is allowed
      ?>  allowed
      =^  cards  yosh  (on-poke:ag mark vase)
      [cards this]
    ::
    ::  If it is, the poke is for manipulating permissions
    =/  a  !<(bean vase) 
    ?-  -.a
        %toggle
     `this(which ?:(=(which %black) %white %black))
    ::
        %command
      =/  =return
      %:  handle-command  command.a
        roster  crumb.a  bowl  
      ==
      :-  -.return
      ?-  which
          %black  this(blacklist ;;(^blacklist +.return))
          %white  this(whitelist ;;(^whitelist +.return))
      ==
    ==
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
    :: Update yosh's state using yosh's on-load,
    =^  cards  yosh  (on-load:ag (slot 2 old)) 
    ::
    :: Return quip with yosh's cards and %bolt's updated state.
    :-  cards
    this(state +:!<([%bolt versioned-state] (slot 3 old)))
  ::
  ++  on-watch 
    |=  =path
    ^-  (quip card agent:gall)
    ::
    ::  TODO http stuff
    ?:  ?=([%bolt *] path)  `this
    ::
    ::  Check if ship is allowed,
    ?>  allowed  
    ::
    ::  If allowed, call inner.
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
      :: If not a %bolt wire, call inner,
      =^  cards  yosh  (on-agent:ag wire sign) 
      [cards this]
    ::
    ::  Otherwise, check for poke-ack.
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
