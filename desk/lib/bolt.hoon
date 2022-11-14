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
      which=?(%black %white) 
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
      perms  ~(. permissions bowl)
      roster  ?-(which %black blacklist, %white whitelist)
      allowed  %:(is-allowed:perms src.bowl kids roster)
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
      =.  which  ?:(=(which %black) %white %black)
      :-  ~[(emit which/s+which)]
          this 
    ::
        %toggle-kids
      :-  ~[(emit kids/b+kids)]
          this(kids !kids)
    ::
        %add-users
      ?-  which 
          %black 
        =.  users.blacklist  (~(uni in users.blacklist) users.bean)
        :_  this        
            ~[(emit add-users-black/a+%+(turn ~(tap in users.bean) |=(a=@p (ship:enjs:format a))))]
      ::
          %white 
        =.  users.whitelist  (~(uni in users.whitelist) users.bean)
        :_  this           
            ~[(emit add-users-white/a+%+(turn ~(tap in users.bean) |=(a=@p (ship:enjs:format a))))]
      ==
    ::
        %remove-users
      ?-  which
          %black 
         =.  users.blacklist  (~(dif in users.blacklist) users.bean) 
         =/  effects  (clean:perms crumb.bean kids blacklist)
         :_  this(users.blacklist users.nu.effects)
             %+  weld  cards.effects 
               ~[(emit remove-users-black/a+%+(turn ~(tap in users.bean) |=(a=@p (ship:enjs:format a))))]
      ::
          %white 
         =.  users.whitelist  (~(dif in users.whitelist) users.bean) 
         =/  effects  (clean:perms crumb.bean kids blacklist)
         :_  this(users.whitelist users.nu.effects) 
             %+  weld  cards.effects 
              ~[(emit remove-users-white/a+%+(turn ~(tap in users.bean) |=(a=@p (ship:enjs:format a))))]
  
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
    |_  =bowl:gall
    +*  parent  (sein:title our.bowl now.bowl src.bowl)
    ++  clean
      |=  [client-path=(unit path) kids=? =lizst]
      ^-  return
      =/  to-kick=(set ship)
        %-  silt
        %+  murn  ~(tap in users.lizst)
        |=  c=ship  ^-  (unit ship)
        ?:((is-allowed c kids lizst) ~ `c)
      =.  users.lizst  (~(dif in users.lizst) to-kick)
      :_  lizst
      ?~  client-path  ~
      %+  turn  ~(tap in to-kick)
      |=(c=ship [%give %kick ~[u.client-path] `c])
  ::
    ++  is-allowed
      |=  [user=@p kids=? =lizst]
      =*  is-kid  |(=(our.bowl parent) (~(has in users.lizst) parent))
      ^-  ?
      ?-  -.lizst
      ::
      :: allow if you're the owner OR not in blacklist,
      :: if kids is %&, do not allow if parent is blacklisted 
      ::
          %blacklist
        ?|  =(our.bowl user)
          ?&  !(~(has in users.lizst) user)
              &(kids !is-kid)
          ==
        ==
      ::
      :: allow if you're the owner OR in a whitelist
      :: if kids is %&, allow if parent is whitelisted or parent is owner
      ::
          %whitelist
        ?|  =(our.bowl user)
            (~(has in users.lizst) user)
            &(kids is-kid)
        ==
      ==
    --
  ++  json
    =,  enjs:format
    |_  state=state-0
    ++  website
      |=  [type=cord diff=^json]     
      ^-  card
      =;  skel
      ~&  >  skel
      %-  fact:agentio  :_  ~[/website]
      :-  %json  !>  ^-  ^json  skel
    ::
    ::  parsing starts here
      %-  pairs
      :~  [%type s+type]
          [%diff diff]
        :-  %state
        %-  pairs
        :~  [%which s+which]
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
    --
  --
--
