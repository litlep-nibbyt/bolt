::
::  %bolt: whitelist/blacklist wrapper for agents
::
::  usage:
::  /+  bolt
::  ...
::  %-(agent:bolt your-agent)
::
/-  *bolt
/+  verb, agentio
::
=>
  |% 
  +$  card  card:agent:gall
  +$  versioned-state
    $%  state-0
    ==
  +$  state-0
    $:  %0 
        white=?
        kids=?
        blacklist=(set ship)
        whitelist=(set ship)
    ==
  --
::
|%
++  agent
  |=  yosh=agent:gall          :: MatrYOSHka doll
  =|  state-0
  =*  state  -
  ::
  %+  verb  &
  =<
  ::
  ^-  agent:gall
  |_  =bowl:gall
  +*  this  .
      ag    ~(. yosh bowl)
      io    ~(. agentio bowl)
      allowed  (is-allowed bowl)
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
    ?>  =(src.bowl our.bowl)
    =/  =bean  !<(bean vase)
    ?-    -.bean
        %toggle-white
      =.  white  switch.bean
      :_  this
      ~[(emit:json white/b+white)]
    ::
        %toggle-kids
      =.  kids  switch.bean
      :_  this
      ~[(emit:json kids/b+kids)]
    ::
        %add-white
      ?>  ?=(~ (~(int in blacklist) users.bean))
      =.  whitelist  (~(uni in whitelist) users.bean)
      :_  this 
      ~[(emit:json add-users-white/(ships:util:json whitelist))]
    ::
        %add-black
      ?>  ?&  !(~(has in users.bean) our.bowl) 
              ?=(~ (~(int in whitelist) users.bean))
          ==
      =.  blacklist  (~(uni in blacklist) users.bean)
      :_  this           
      ~[(emit:json add-users-black/(ships:util:json blacklist))]
    ::
        %remove-white
      =.  whitelist  (~(dif in whitelist) users.bean)
      :_  this
      ~[(emit:json remove-users-white/(ships:util:json whitelist))]
    ::
        %remove-black
      =.  blacklist  (~(dif in blacklist) users.bean) 
      :_  this
      ~[(emit:json remove-users-black/(ships:util:json blacklist))]
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
    ::  Check for %bolt watch requests
    ?.  ?=([%bolt %website ~] path)
      :_  this
      ~[(emit:json initial/~)]
    ::
    ::  If not for %bolt, check if ship is allowed,
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
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:ag path)
      [%x %bolt *]  ~
    ==
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
  ::
  |%
  ++  is-allowed
    |=  =bowl:gall
    ^-  ?
    =*  parent  (sein:title our.bowl now.bowl src.bowl)
    =*  is-moon  (team:title parent src.bowl)
    =*  p-black  (~(has in blacklist) parent)
    =*  p-white  (~(has in whitelist) parent)
    ?&  !|((~(has in blacklist) src.bowl) &(kids is-moon p-black))
        ?|  !white 
            =(our.bowl src.bowl) 
            (~(has in whitelist) src.bowl) 
            &(kids is-moon p-white)
    ==  == 
  ::
  ++  json
    =,  enjs:format
    |%
    ++  emit
      |=  [type=cord diff=^json]
      ^-  card
      %-  fact:agentio  :_  ~[/website]
      :-  %json  !>  ^-  ^json
      ::
      ::  parsing starts here
      %-  pairs
      :~  [%type s+type]
          [%diff diff]
          :-  %state
          %-  pairs
          :~  [%white b+white]
              [%kids b+kids]
              [%whitelist (frond %users (ships:util whitelist))]
              [%blacklist (frond %users (ships:util blacklist))]
      ==  ==
    ::
    ++  util
      |%
      ++  ships
        |=  users=(set @p)
        ^-  ^json
        [%a (turn ~(tap in users) ship)]
      --
    -- 
  --
--
