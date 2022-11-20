/-  bolt
|^  
|_  command=bean
++  grow
  |%
  ++  noun  command
  --
++  grab
  |%
  ++  noun  bean:bolt
  ++  json  dejs-bean
  -- 
++  grad  %noun
--
  ++  dejs-bean
  =,  dejs:format
  |=  jon=json
  ^-  bean:bolt
  %.  jon
  %-  of
  :~  [%add-white (ot ~[users+(as (se %p))])]
      [%add-black (ot ~[users+(as (se %p))])]
      [%remove-white (ot ~[users+(as (se %p))])]
      [%remove-black (ot ~[users+(as (se %p))])]
      [%toggle-which (ot ~[switch+bo])]
      [%toggle-kids (ot ~[switch+bo])]
  ==
--
