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
    ::  If poke is to inner agent, check if poke is allowed
    ?.  =(mark %bolt-poke)
      ?.  public.whitelist
        call-inner
      ?>  (is-allowed src.bowl whitelist bowl)
        call-inner
    ::
    ::  Otherwise, poke is for manipulating whitelist
    =/  gwern  !<(bean.sir vase) 
    =/  =return.sir  (handle-command +.gwern whitelist ~ bowl)
    ~&  >  whitelist
    `this(whitelist +:return)
  ++  on-save
    ^-  vase
    %+  slop
      on-save:yosh
    !>  [%bolt state] 
  ++  on-load
    |=  old=vase
    ^-  (quip card agent:gall)
    =/  gads  !<([@ud %bolt state-0] old)
    =^  cards  yosh  (on-load:yosh !>(-.gads)) 
    [cards this(state +.+.gads)]
  ++  on-watch  on-watch:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-agent  on-agent:def
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  --
--
