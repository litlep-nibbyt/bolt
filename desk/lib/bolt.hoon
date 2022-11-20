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

=>
|% 
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0  
  $:  %0 
      which=?
      kids=?
      =blacklist 
      =whitelist
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
      perms  ~(. permissions bowl state)
      allowed  %:(is-allowed:perms src.bowl)
      emit   ~(website json state)
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
    ?-  -.bean
        %toggle-which
      =.  which  switch.bean
      :-  ~[(emit which/b+which)]
          this 
    ::
        %toggle-kids
      =.  kids  switch.bean
      :-  ~[(emit kids/b+kids)]
          this
    ::
        %add-white
        =.  users.whitelist  (~(uni in users.whitelist) users.bean)
        :_  this           
            ~[(emit add-users-white/(ships:util:json users.whitelist))]
    ::
        %add-black
      =.  users.blacklist  (~(uni in users.blacklist) users.bean)
      :_  this           
          ~[(emit add-users-black/(ships:util:json users.blacklist))]
    ::
        %remove-white
      =.  users.whitelist  (~(dif in users.whitelist) users.bean) 
      :_  this
          ~[(emit remove-users-white/(ships:util:json users.whitelist))]
      ::
        %remove-black
      =.  users.blacklist  (~(dif in users.blacklist) users.bean) 
      :_  this
          ~[(emit remove-users-black/(ships:util:json users.blacklist))]
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
      :_  this  ~[(emit initial/~)]
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
    ?+    -.path  (on-peek:ag path) 
        %bolt  ~
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
  |%
  ++  permissions
    |_  [=bowl:gall state=state-0]
    +*  parent  (sein:title our.bowl now.bowl src.bowl)
  ::
    ++  is-allowed
      |=  user=@p
      =+  state
      =*  moon-gud  |(=(our.bowl parent) (~(has in users.whitelist) parent))
      =*  moon-bad  |(=(our.bowl parent) (~(has in users.blacklist) parent))
      ^-  ?
      ::
      ::  Do not allow if in blacklist or kids and kid of blacklister
      ?&  |(!(~(has in users.blacklist) user) &(kids !moon-bad))
      ::
      :: If whitelist is on, check if user is in whitelist or kid of whitelister
          ?:  =(which %off)
            %&
          ?|  =(our.bowl user)
              (~(has in users.whitelist) user)
              &(kids moon-gud)
          ==
      ==
      ::
    --
  ++  json
    =,  enjs:format
    |_  state=state-0
  ::
    ++  website
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
        :~  [%which b+which]
            [%kids b+kids]
          :-  %whitelist
          %-  pairs
          :~  :+  %users
               %a
               %+  turn  ~(tap in users.whitelist)
               |=(a=@p (ship a))
          ==
          :-  %blacklist
          %-  pairs
          :~  :+  %users
              %a
             %+  turn  ~(tap in users.blacklist)
             |=(a=@p (ship a))
          ==
      ==  == 
  ++  util
    |%  
    ++  ships
      |=  users=(set @p) 
      ^-  ^json
      [%a %+(turn ~(tap in users) |=(a=@p (ship a)))]
    --
  --  --
--
