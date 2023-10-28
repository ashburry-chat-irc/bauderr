;TODO add all menu item separators, .-, in the remotes menus; not the popups.ini
; /set_show_away 1 = notice 2 = private message 0 = off
alias menu_parted {
  if ($1 isin endbegin) { return }
  if (!$chan($1)) { return - }
  return $chan($1) $block($chan($1).status) : part $chan($1)
}
alias style_part_all_rooms {
  var %i = 1
  var %chan = $chan(%i)
  while (%chan) {
    if (join isin $chan(%i).status) { return }
    inc %i
    %chan = $chan(%i)
  }
  return $style(3)
}
alias close_parted {
  var %i = 1
  var %last
  while ($chan(%i)) {
    if (join* !iswm $chan(%i).status) { 
      %last = $chan(%i)
      part $chan(%i)
    }
    if ($chan(%i) == %last) { inc %i }
    continue 
  }
}
alias oldnick {
  if ($varname_global(old_nick,$$1).value != $null) { return $ifmatch }
}
alias old_nick_islisted {
  var %i = 0
  :loop
  if (%i == 10) { return $false }
  inc %i
  if ($varname_global(old_nick,%i).value == $$1) { return $true }
  goto loop
}
alias old_nick_add {
  if ($old_nick_islisted($1) == $true) { return }
  var %i = 0
  :loop
  if (%i == 10) { set $varname_global(old_nick,$rands(1,10)) $1 | return }
  inc %i
  if ($varname_global(old_nick,%i).value == $null) { set $varname_global(old_nick,%i) $1 | return }
  goto loop
}
on *:nick: {
  if ($nick == $me) { old_nick_add $me | old_nick_add $newnick }
}
alias style_parted_rooms {
  var %i = 1
  var %parted = $false
  while ($chan(%i)) {
    if ($chan(%i).status != parted) { inc %i | continue }
    var %parted = $true
    break
  }
  if (!%parted) {
    return $style(3)
  }
}
on *:start: {
  unset %bde_temp*
}
raw 18:*: {
  if ($1- == :www.mslscript.com www.mslscript.com online) {
    set $varname_cid(trio-ircproxy,in_use) = $true
  }
}
on *:quit: {
  if ($nick == $me) { 
    unset $varname_cid(trio-ircproxy.py, active)
    unset $varname_cid(trio-ircproxy.py, admin)     
  }
}
alias onotice-script {
  var %room = #$$input(Enter a room name to send op-notice to:,eygbqk60m,enter a room name to send op-notice to,select a room,$chan(1),$chan(2),$chan(3),$chan(4),$chan(5),$chan(6),$chan(7),$chan(8),$chan(9),$chan(10),$chan(11),$chan(12),$chan(13),$chan(14),$chan(15))
  if (%room == #select a room) { return }
  %room = $gettok(%room,1,32)
  var %msg = $$input(Speak your notice to all chan-ops in %room $+ :,eygbqk60,Speak your notice to all chan-ops in %room,:: : MG script : .)
  !onotice %room %msg
}
alias omsg-script {
  var %room = #$$input(Enter a room name to send op-msg to:,eygbqk60m,enter a room name to send op-msg to,select a room,$chan(1),$chan(2),$chan(3),$chan(4),$chan(5),$chan(6),$chan(7),$chan(8),$chan(9),$chan(10),$chan(11),$chan(12),$chan(13),$chan(14),$chan(15))
  if (%room == #select a room) { return }
  %room = $gettok(%room,1,32)
  var %msg = $$input(Enter your message to all chan-ops in %room $+ :,eygbqk60,Enter your message to all chan-ops in %room,:: : MG script : .)
  !omsg %room %msg
}

alias parted_rooms {
  if ($1 isin begin end) { return }
  if ($1 > $chan(0)) { return }
  if ($chan($1).status == kicked) { return $chan($1) $block(kicked) : join $chan($1) }
  elseif ($chan($1).status == parted) { return $chan($1) $block(parted) : join $chan($1) }
  else { return - }
}
alias joinall {
  echo $color(info) -ae * Joining all channels...
  var %i = 1
  while ($chan(%i)) {
    if (join* iswm $chan(%i).status) { inc %i | continue }
    else { join $chan(%i) }
    inc %i
  }
}
alias style_joinall {
  var %i = 1
  while ($chan(%i)) {
    if (join* iswm $chan(%i).status) { inc %i | continue }
    else { return }
  }
  return $style(3)
}
alias style_show_away_not {
  if ($status != connected) || (!$network) { return $style(3) }
  if ($varname_global(show_away,blank).value == 0) { return $style(3) }
}
alias style_show_away_note {
  if ($status != connected) || (!$network) { return }
  if ($varname_global(show_away,blank).value == 1) { return $style(3) }
}
alias style_show_away_priv {
  if ($status != connected) || (!$network) { return }
  if ($varname_global(show_away,blank).value == 2) { return $style(3) }
}

alias style_show_away {
  return $iif($style_show_away_priv $+ $style_show_away_note,$style(1))
}
alias set_show_away {
  if ($1 <= 2) && ($1 >= 0)  { set $varname_global(show_away,blank) $1 }
}
alias advertise-chan {
  if ($status != connected) { return }
  if ($chan != $null) { return this channel }
}
alias advertise-in-channel {
  if ($status != connected) { return }
  if ($chan(0) > 0) { return in channel }
}
alias advertise-chan-00 {
  if ($status != connected) { return }
  if ($chan(1) != $null) { return $chan(1) }
}
alias advertise-chan-01 {
  if ($status != connected) { return }
  if ($chan(2) != $null) { return $chan(2) }
}
alias advertise-chan-02 {
  if ($status != connected) { return }
  if ($chan(3) != $null) { return $chan(3) }
}
alias advertise-chan-03 {
  if ($status != connected) { return }
  if ($chan(4) != $null) { return $chan(4) }
}
alias advertise-chan-04 {
  if ($status != connected) { return }
  if ($chan(5) != $null) { return $chan(5) }
}
alias advertise-chan-05 {
  if ($status != connected) { return }
  if ($chan(6) != $null) { return $chan(6) }
}
alias advertise-chan-06 {
  if ($status != connected) { return }
  if ($chan(7) != $null) { return $chan(7) }
}
alias advertise-chan-07 {
  if ($status != connected) { return }
  if ($chan(8) != $null) { return $chan(8) }
}
alias advertise-chan-08 {
  if ($status != connected) { return }
  if ($chan(9) != $null) { return $chan(9) }
}
alias advertise-chan-09 {
  if ($status != connected) { return }
  if ($chan(10) != $null) { return $chan(10) }
}
alias advertise-this-connection {
  if ($status != connected) { return }
  if ($chan(0) == 0) { return }
  return all chans on this connection
}
alias advertise-network {
  if ($network == $null) { return }
  return chans on network $network
}
alias advertise-this-client {
  return everywhere on this client
}
alias advertise-user {
  return all proxy user $varname_cid(trio-ircproxy.py, is_user).value
}
alias block {
  if (strip($1) == $null) { return }
  return $chr(91) $+ $1- $+ $chr(93)
}
alias -l style_net_chan_link {
  if (!$chan) { return }
  if ($varname_global(network-link,$chan).value) { return $style(1) }
}
alias dq {
  echo State: $iif($dqwindow & 1,enabled,not enabled)

  echo State: $iif($dqwindow & 2,open,not open)

  echo State: $iif($dqwindow & 4,opening,not opening)

  echo State: $iif($dqwindow & 8,writing,not writing)

  echo State: $iif($dqwindow & 16,written,not written)

}

menu Status,Channel {
  $chr(46) $chr(58) M&achine Gun $str($chr(58),2) $chr(58)
  .$style_proxy $chr(46) $chr(58) describe mg $str($chr(58),2) $chr(58)
  ..$advertise-chan : /describe $chan is using Machine Gun mSL script named Bauderr. use ctcp version/script/source for more info.
  ..$advertise-in-channel
  ...$advertise-chan-00 : /bauderr-advertise --chan $chan(1)
  ...$advertise-chan-01 : /bauderr-advertise --chan $chan(2)
  ...$advertise-chan-02 : /bauderr-advertise --chan $chan(3)
  ...$advertise-chan-03 : /bauderr-advertise --chan $chan(4)
  ...$advertise-chan-04 : /bauderr-advertise --chan $chan(5)
  ...$advertise-chan-05 : /bauderr-advertise --chan $chan(6)
  ...$advertise-chan-06 : /bauderr-advertise --chan $chan(7)
  ...$advertise-chan-07 : /bauderr-advertise --chan $chan(8)
  ...$advertise-chan-08 : /bauderr-advertise --chan $chan(9)
  ...$advertise-chan-09 : /bauderr-advertise --chan $chan(10)
  ..$advertise-this-connection : /bnc_msg advertise-connection
  ..$advertise-network : bnc_msg --advertise-network-with-bauderr
  ..$advertise-this-client : /scon -a /ame is using Machine Gun mSL script named Bauderr. use ctcp version/script/source for more info.
  ..$advertise-user : bnc_msg advertise-username-with-bauderr
  ..everywhere possible : bnc_msg --advertise-everywhere-with-bauderr
  -
  &room functions
  .&chanserv
  ..$identify_here_popup : /msg *status identify $$chan 
  ..$popup-identify-founder-list
  ...$submenu($identify_chans_popup($1))
  .[&allow prevention]
  ..$style_allow_ascii &allow ascii-art
  ...$style_allow_paste &allow paste 25 lines : set_allow_room_paste
  ...$style_allow_long_word &allow long words : set_allow_room_long_word
  ...$style_allow_line &allow long lines : set_allow_room_long_line
  ...$style_allow_repeat &allow repeat 6x : set_allow_room_repeat
  ...$style_allow_rand_text [&allow random text] : set_allow_room_random_text
  ...-
  ...$style_allow_ascii allow ascii-art (Every Thing) : set_allow_asciiart
  ; menu
  ..$style_bad_script_menu &allow bad scripts
  ...$style_bad_script_ban &do not allow bad scripts : set_allow_bad_scripts
  ...-
  ...open bad script list : open_bad_script
  ; menu
  ..$style_allow_rand_nick &allow random nickname : set_allow_rand_nick
  ..$style_allow_clone &allow clone 10x : set_allow_room_clone
  ..-
  ..$style_allow_share [&allow file sharing] : set_allow_room_file_share
  ..$style_allow_idle [&allow idle 25+ minutes] : set_allow_room_idle
  ..$style_allow_binart [&allow bin-art && non-english] : set_allow_room_binart
  ; menu
  ..$style_allow_bad_word [&allow bad words]
  ...$style_allow_bad_word_off do not allow bad words : set_allow_room_badword
  ...-
  ...open bad word list : open_bad_word
  ; menu
  ..$style_allow_room_name [&allow advertising other #room-names]
  ...$style_allow_room_name_off do not allow : set_allow_room_name
  ...-
  ...open allowed list : open_allowed_room
  ; menu
  ..$style_allow_url [&allow speaking $+(https,$chr(58),//URLs,]) 
  ...$style_allow_url_off do not allow : set_allow_room_url
  ...-
  ...open always allowed-url list : open_allowed_url
  ; menu
  ..$style_bad_chan [&allow bad room]
  ...$style_bad_chan_off do not allow : set_allow_room_bad_chan
  ...-
  ...open bad room list : open_bad_chan
  ..-
  ..$style_allow_non_default set non-defaults to allow : set_allow_room_non_default
  ..$style_allow_default [set defaults to allow] : set_allow_room_default
  ; menu
  .[ir&c oper scan]
  ..-
  ..$iif(($chan == $null),$style_proxy) scan here : /operscan $chan
  ..$style_proxy scan everywhere : /operscan
  ..-
  ..$iif($menu_enable_oper_scan != $style(3),$style(1)) s&can on join
  ...$menu_enable_oper_scan switch OFF scanning : disable_oper_scan
  ...-  
  ...$oper_scan_net switch ON for this network : toggle_oper_scan_net
  ...$oper_scan_cid switch ON for this connection id (temporary) : toggle_oper_scan_cid
  ...-
  ...$oper_scan_cid_chan switch ON for this channel/connection id (temporary) : toggle_oper_scan_cid_chan
  ...$oper_scan_net_chan [switch ON for this channel/network] : toggle_oper_scan_net_chan
  ...-
  ...$oper_scan_client [switch ON for this irc-client] : toggle_oper_scan_client

  .$style_net_chan_link network channel link 
  ..$style_link_on turn on here : {
    if ($varname_global(network-link,$chan).value > 0) { set $varname_global(network-link,$chan) 0 | status_msg set channel-link $chan off }
    else { set $varname_global(network-link,$chan) $cid | status_msg set channel-link $chan $cid }
  }
  ..-
  ..in&fo : /script_info -chan_link
  .$style_annc_urls describe urls
  ..$style_annc_urls switch ON .url crawl : annc_urls_toggle
  ..$style_annc_urls_secure only use secure connections : annc_urls_toggle_secure
  ..-
  ..info : script_info -urls
  .-

  .$style_auto_ial [&auto update ial] : toggle_auto_ial

  &trio-ircproxy.py
  .&visit your home-page : proxy_msg visit homepage
  .&visit proxy list : run https://www.mslscript.com/proxy.html
  .-

  ; Keep track of the IP and PORT in use so you know where to send the shutdown command to
  &connect irc
  .last used : /server
  .-
  .with proxy 
  ..192.168.0.17 4321 : /proxy on | var %net = $iif(($network),$network,$$?="enter network name:") | /server $$server(1, %net) $+ : $+ $remove($server(1, %net).port,+) 
  .with vhost
  ..38.242.206.227 7000 : /proxy off | var %net = $$?="enter network name:") | /server 38.242.206.227:7000 $$?="enter your username:" $+ / $+ %net $+ : $+ $$?="enter your password:"
  ..192.168.0.17 +6697 : /proxy off | var %net = $iif(($network),$network,$$?="enter network name:") | /server 192.168.0.17:+6697 $$?="enter your username:" $+ / $+ %net $+ : $+ $$?="enter your password:"
  .-
  .without proxy nor vhost : /proxy off | /server $server(1, $iif(($network),$network,$$?="enter network name:"))
  ; command history
  ;.xcdcc send #899 : /msg [MG]-MISC|EU|S|RandomPunk xdcc send #899
}
alias -l style_link_on {
  if (!$chan) { return $style(2) }
  if ($varname_global(network-link,$chan).value == 1) { return $style(1) }

}
alias -l BAUDERR-ADVERTISE {
  if ($1 == --chan) {
    describe $$2 is using Machine Gun mSL script named Bauderr. use ctcp version / script / source for more info.
  }
}
alias style_auto_ial {
  if ($varname_global(auto_ia1,blank).value == $true) || ($varname_global(auto_ia1,blank).value == $null) { return $style(1) }
}
alias toggle_auto_ial {
  set $varname_global(auto_ia1,blank) $iif($1 != $null,$1,$iif(($varname_global(auto_ia1,blank).value == $true || $varname_global(auto_ia1,blank).value == $null),$false,$true))
}
alias -l style_annc_urls {
  return $iif(($varname_cid(annc_urls,blank).value),$style(1))
}
alias -l annc_urls_toggle {
  set $varname_cid(annc_urls,blank) $iif(($varname_cid(annc_urls,blank).value),$false,$true)
}
alias query_menu {
  if ($1 isin beginend) { return }
  if ($query($1)) { return $query($1) : whois $query($1) }
}
alias ialupdate_menu {
  if ($1 isin beginend) { return }
  if (!$chan($1)) { return }
  if ($chan($1).status != joined) { return $style(2) $chan($1) - $chan($1).status : return }
  if ($chan($1)) { return $chan($1) $ialupdated($chan($1)) : if ($ial) { ialfill -f $chan($1) } }
}
alias play-sound-history {
  if ($1 isin begin end) { return asdf }
  if ($1 == 16) { return }
  var %fn = $varname_global(sound-history,$1).value
  if (!%fn) { return }
  return $nopath(%fn) : play-sound $eval($iif($active == $chan || $active == $nick,$ifmatch,$gettok($$?="enter a room or nickname to play to:",1,32)),0) %fn
}
alias style_annc_urls_secure {
  if ($varname_global(urlcrawl,secure) == $null) || ($varname_global(urlcrawl,secure) == $true) { return $style(1) }
}
alias play-sound {
  var %file = $qw($2-), %fn
  if (!$exists(%file)) { return }
  var %n = 1, %empty
  while (%n < 16) {
    %fn = $varname_global(sound-history,%n).value
    if (%fn) && ($exists(%fn) == $false) { var %fn | unset $varname_global(sound-history,%n) }
    elseif (%fn == %file) { %empty = skip | break }
    if (!%fn) && (!%empty) { %empty = %n }
    inc %n
  }
  if (%empty == $null) {
    if ($varname_global(sound-history,last-n).value == $null) { set $varname_global(sound-history,last-n) 1 }
    set $varname_global(sound-history,last-n) $calc($varname_global(sound-history,last-n).value + 1)
    if ($varname_global(sound-history,last-n).value > 15) { set $varname_global(sound-history,last-n) 1 }
    set $varname_global(sound-history,$varname_global(sound-history,last-n).value) %file
  }
  else { if (%empty != skip) { set $varname_global(sound-history,%empty) %file } }
  var %m = is playing a sound * 76,1 E n j o y!   *
  if (C isin $chan($1).mode) { %m = $strip(%m) }
  sound $1- %m
  if ($varname_temp(soundfile-message,blank).value != $true) {
    set $varname_temp(soundfile-message,blank) $true
    .timersoundfile-message -o 1 $calc(60 * 12) /set $varname_temp(soundfile-message,blank) $false
  }
  else { return }
  echo (for other ppl to listen to the sound file they paste) ! $+ $me $nopath(%file)  (in channel or private message. use /splay stop)
}
alias -l oper_scan_client {
  if ($varname_global(oper-scan-client,blank).value == $true) { return $style(1) }
}
alias -l toggle_oper_scan_client {
  set $varname_global(oper-scan-client,blank) $iif(($1 isin $!true$false),$1,$iif(($varname_global(oper-scan-client,blank).value == $true),$false,$true))
}
alias -l open_allowed_url {
  var %fn = $qw($scriptdirprevention\allowed-url-list.txt)
  if ($exists(%fn) == $false) { write -c %fn }
  run %fn

}
alias -l open_bad_word {
  var %fn = $qw($scriptdirprevention\bad-word-list.txt)
  if ($exists(%fn) == $false) { write -c %fn }
  run %fn
}
alias -l open_bad_script {
  var %fn = $qw($scriptdirprevention\bad-scripts.txt)
  if ($exists(%fn) == $false) { write -c %fn }
  run %fn
}
alias -l open_bad_chan {
  var %fn = $qw($scriptdirprevention\bad-chan-list.txt)
  if ($exists(%fn) == $false) { write -c %fn }
  run %fn
}
alias -l open_allowed_room {
  var %fn = $qw($scriptdirprevention\allowed-room-names.txt)
  if ($exists(%fn) == $false) { write -c %fn }
  run %fn
}
alias -l style_bad_chan_off {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_bad_chan,$network $+ $chan).value == $false) { return $style(1) }
}
alias -l style_bad_chan {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_bad_chan,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_default {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_default,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_repeat {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_repeat,$network $+ $chan).value == $null) { return $style(1) }
}
alias style_bad_script_menu {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_bad_scripts_menu,$network  $+ $chan).value == $null) { return $style(1) }
}
alias style_bad_script_ban {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_bad_scripts,$network  $+ $chan).value == $false) { return $style(1) }
}

alias -l style_bad_chan {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_bad_chan,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_url {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_url,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_url_off {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_url,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_room_name {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_name,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_room_name_off {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_name,$network $+ $chan).value == $false) { return $style(1) }
}

alias -l style_allow_binart {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_binart,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_bad_word {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_bad_word,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_bad_word_off {
  if (!$network) || (!$chan) { return }
  if ($varname_global(allow_bad_word,$network $+ $chan).value == $false) { return $style(1) }

}
alias -l style_allow_idle {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_idle,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_share {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_sharing,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_clone {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_clone,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_rand_nick {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_rand_nick,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_long_word {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_long_word,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_line {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_long_line,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_paste {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_paste,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_non_default {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_room_non_default,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_rand_text {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_rand_text,$network $+ $chan).value == $null) { return $style(1) }
}
alias -l style_allow_ascii {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(allow_rand_text,$network $+ $chan).value == $null) && $&
    ($varname_global(allow_room_paste,$network $+ $chan).value == $null) || $&
    ($varname_global(allow_long_line,$network $+ $chan).value == $null) && $&
    ($varname_global(allow_long_word,$network $+ $chan).value == $null) && $&
    ($varname_global(allow_room_repeat,$network $+ $chan).value == $null) { return $style(1) }
}


alias set_allow_room_binart {
  if ($varname_global(allow_room_binart,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_room_binart,$network $+ $chan).value == $null) { set $varname_global(allow_room_binart,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_binart,$network $+ $chan) }

}
alias set_allow_rand_nick {
  if ($varname_global(allow_rand_nick,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  if ($varname_global(allow_rand_nick,$network $+ $chan).value == $null) { set $varname_global(allow_rand_nick,$network $+ $chan) $false }
  else { unset $varname_global(allow_rand_nick,$network $+ $chan) }


}

alias set_allow_room_clone {
  if ($varname_global(allow_room_clone,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  if ($varname_global(allow_room_clone,$network $+ $chan).value == $null) { set $varname_global(allow_room_clone,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_clone,$network $+ $chan) }
}
alias set_do_not_allow_bad_scripts {
  if ($varname_global(allow_bad_scripts,$network $+ $chan).value == $null) { unset $varname_global(allow_room_non_default,$network $+ $chan }
  if ($varname_global(allow_bad_scripts,$network $+ $chan).value == $null) { unset $varname_global(allow_bad_scripts_menu,$network $+ $chan) | set $varname_global(allow_bad_scripts,$network $+ $chan) $false }
  else { unset $varname_global(allow_bad_scripts,$network $+ $chan) }
}

alias set_allow_room_badword {
  if ($varname_global(allow_bad_word,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_bad_word,$network $+ $chan).value == $null) { set $varname_global(allow_bad_word,$network $+ $chan) $false }
  else { unset $varname_global(allow_bad_word,$network $+ $chan) }
}
alias set_allow_room_non_default {
  if ($varname_global(allow_room_non_default,$network $+ $chan).value == $null) {
    set $varname_global(allow_room_non_default,$network $+ $chan) $false
    set_allow_asciiart_non_default
    set $varname_global(allow_bad_scripts,$network $+ $chan) $false
    set $varname_global(allow_bad_scripts_menu,$network  $+ $chan) $false
    set $varname_global(allow_rand_nick,$network $+ $chan) $false
    set $varname_global(allow_room_clone,$network $+ $chan) $false
    set_allow_asciiart
  }
  else { 
    unset $varname_global(allow_room_non_default,$network $+ $chan)
    unset_allow_asciiart_non_default
    unset $varname_global(allow_bad_scripts,$network $+ $chan)
    unset $varname_global(allow_bad_scripts_menu,$network  $+ $chan)
    unset $varname_global(allow_rand_nick,$network $+ $chan)
    unset $varname_global(allow_room_clone,$network $+ $chan)
    set_allow_asciiart
  }
}
alias set_allow_room_default {
  if ($varname_global(allow_room_default,$network $+ $chan).value == $null) {
    set $varname_global(allow_room_default,$network $+ $chan) $false
  }
  else { unset $varname_global(allow_room_default,$network $+ $chan) }
  set $varname_global(allow_room_sharing,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  set $varname_global(allow_room_idle,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  set $varname_global(allow_bad_word,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  set $varname_global(allow_room_binart,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  set $varname_global(allow_room_name,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  set $varname_global(allow_room_url,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  set $varname_global(allow_bad_chan,$network $+ $chan) $varname_global(allow_room_default,$network $+ $chan).value
  unset $varname_global(allow_rand_text,$network $+ $chan)
}
alias set_allow_room_bad_chan {
  if ($varname_global(allow_bad_chan,$network $+ $chan).value == $false) { set $varname_global(allow_room_default,$network $+ $chan) $false }
  if ($varname_global(allow_bad_chan,$network $+ $chan).value == $null) { set $varname_global(allow_bad_chan,$network $+ $chan) $false }
  else { unset $varname_global(allow_bad_chan,$network $+ $chan) }

}
alias set_allow_room_repeat {
  if ($varname_global(allow_room_repeat,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  if ($varname_global(allow_room_repeat,$network $+ $chan).value == $null) { set $varname_global(allow_room_repeat,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_repeat,$network $+ $chan) }

}
alias set_allow_room_paste {
  if ($varname_global(allow_room_paste,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  if ($varname_global(allow_room_paste,$network $+ $chan).value == $null) { set $varname_global(allow_room_paste,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_paste,$network $+ $chan) }

}
alias set_allow_room_long_word {
  if ($varname_global(allow_long_word,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  if ($varname_global(allow_long_word,$network $+ $chan).value == $null) { set $varname_global(allow_long_word,$network $+ $chan) $false }
  else { unset $varname_global(allow_long_word,$network $+ $chan) }

}
alias set_allow_room_long_line {
  if ($varname_global(allow_long_line,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  if ($varname_global(allow_long_line,$network $+ $chan).value == $null) { set $varname_global(allow_long_line,$network $+ $chan) $false }
  else { unset $varname_global(allow_long_line,$network $+ $chan) }

}
alias set_allow_room_random_text {
  if ($varname_global(allow_rand_text,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_rand_text,$network $+ $chan).value == $null) { set $varname_global(allow_rand_text,$network $+ $chan) $false }
  else { unset $varname_global(allow_rand_text,$network $+ $chan) }
}
alias set_allow_asciiart {
  unset $varname_global(allow_rand_text,$network $+ $chan)
  set $varname_global(allow_asciiart,$network $+ $chan) $iif(($varname_global(allow_asciiart,$network $+ $chan).value == $null), $false, $null)
  set $varname_global(allow_room_paste,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_long_line,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_long_word,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_room_repeat,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  if ($varname_global(allow_asciiart,$network $+ $chan).value == $false) { set $varname_global(allow_room_non_default,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_non_default,$network $+ $chan) }

}

alias set_allow_asciiart_non_default {
  set $varname_global(allow_asciiart,$network $+ $chan) $iif(($varname_global(allow_asciiart,$network $+ $chan).value == $null),$false,$null)
  unset $varname_global(allow_rand_text,$network $+ $chan)
  set $varname_global(allow_room_paste,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_long_line,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_long_word,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_room_repeat,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
  set $varname_global(allow_room_non_default,$network $+ $chan) $varname_global(allow_asciiart,$network $+ $chan).value
}
alias SET_ALLOW_ROOM_FILE_SHARE {
  if ($varname_global(allow_room_sharing,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_room_sharing,$network $+ $chan).value == $null) { set $varname_global(allow_room_sharing,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_sharing,$network $+ $chan) }

}
alias set_allow_room_idle {
  if ($varname_global(allow_room_idle,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_room_idle,$network $+ $chan).value == $null) { set $varname_global(allow_room_idle,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_idle,$network $+ $chan) }


}
alias set_allow_room_url {
  if ($varname_global(allow_room_url,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_room_url,$network $+ $chan).value == $null) { set $varname_global(allow_room_url,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_url,$network $+ $chan) }

}
alias set_allow_room_name {
  if ($varname_global(allow_room_name,$network $+ $chan).value == $false) { unset $varname_global(allow_room_default,$network $+ $chan) }
  if ($varname_global(allow_room_name,$network $+ $chan).value == $null) { set $varname_global(allow_room_name,$network $+ $chan) $false }
  else { unset $varname_global(allow_room_name,$network $+ $chan) }

}
alias -l menu_enable_oper_scan {
  if ($varname_cid(oper-scan-cid).value) { return }
  if ($chan && $varname_cid(oper-scan-cid-chan,$chan).value) { return }
  if ($network && ($varname_global(oper-scan-net,$network).value)) { return }
  if ($network && $chan && ($varname_global(oper-scan-net-chan,$+($$network,$$Chan)).value)) { return }
  if ($varname_global(oper-scan-client,blank).value) { return }
  return $style(3)
}

alias disable_oper_scan {
  set $varname_cid(oper-scan-cid) $false
  if ($network) { set $varname_global(oper-scan-net,$$network) $false }
  if ($chan) { set $varname_cid(oper-scan-cid-chan,$$chan) $false }
  if ($chan) && ($network) { set $varname_global(oper-scan-net-chan,$+($$network,$$Chan)) $false }
  set $varname_global(oper-scan-client,blank) $false
}
alias oper_scan_net_chan {
  if (!$network) || (!$chan) { return $style(2) }
  if ($varname_global(oper-scan-net-chan,$+($$network,$$Chan)).value) { return $style(1) }
}
alias toggle_oper_scan_net_chan {
  if ($network == $null) || (!$chan) { return }
  if (!$varname_global(oper-scan-net-chan,$+($$network,$$Chan)).value) {
    /set $varname_global(oper-scan-net-chan,$+($$network,$$Chan)) $true
  }
  else { /set $varname_global(oper-scan-net-chan,$+($$network,$$Chan)) $false }
}

alias -l oper_scan_cid_chan {
  if ($chan == $null) { return $style(2) }
  if ($varname_cid(oper-scan-cid-chan,$$chan).value) { return $style(1) }

}
alias -l toggle_oper_scan_cid_chan {
  if (!$varname_cid(oper-scan-cid-chan,$$chan).value) {
    /set $varname_cid(oper-scan-cid-chan,$chan) $true
  }
  else {
    /set $varname_cid(oper-scan-cid-chan,$chan) $false
  }
}

alias -l oper_scan_cid {
  if ($varname_cid(oper-scan-cid).value) { return $style(1) }

}
alias toggle_oper_scan_cid {
  if ($varname_cid(oper-scan-cid).value == $true) {
    /set $varname_cid(oper-scan-cid) $false
  }
  else {
    /set $varname_cid(oper-scan-cid) $true
  }
}

alias oper_scan_net {
  if ($network == $null) { return $style(2) }
  if ($varname_global(oper-scan-net,$$network).value) { return $style(1) }
}
alias toggle_oper_scan_net {
  if ($network == $null) { return }
  if (!$varname_global(oper-scan-net,$$network).value) {
    /set $varname_global(oper-scan-net,$$network) $true
  }
  else { /set $varname_global(oper-scan-net,$$network) $false }
}
alias style-proxy-shutdown {
  if ($varname_cid(using-bnc) != $true) { return $style(2) }

}
alias /proxy-shutdown {
  if ($varname_cid(using-bnc) == $true) {
    /raw proxy-shutdown NOW
  }
}
;-
; chanserv exists:
;-
alias -l identify_here_popup {
  if ($bool_using_proxy != $true) { return }
  if ($varname_global(identify-chanserv,$+($chan,-,$$network)).value == $chan) { return identify here }
}
;-
alias -l identify_chans_popup {
  if ($1 == begin) { return }
  if ($1 == end) { return }
  var %chan = $var($varname_global(identify-chanserv,$+(*,-,$$network)),$1)
  %chan = [ [ %chan ] ]
  if (%chan == $null) && ($1 == 1) { return no channels : eecho you have not identified as founder of channel(s) on this network ( $+ $network $+ ). $chr(124) eecho after you identify as an founder your channel will be listed in the menu. }
  return %chan : /bnc_msg identify-chanserv %chan
}
on *:quit: {
  if ($nick == $me) { unset $varname_cid(trio_ircproxy.py,active) }
}
alias status_usenick_pop {
  if (!$varname_cid(trio-ircproxy.py,active).value) { return $style(2) }
  if ($varname_glob(status-nick,none).value == $1) { return $style(1) }
}
alias bool_using_proxy {
  if ($varname_cid(trio-ircproxy.py,active).value) { return $true }
  return $false
}
alias style_proxy {
  if (!$varname_cid(trio-ircproxy.py,active).value) { return $style(2) }
}
on *:text:*:$chr(42) $+ mg-script: {
  tokenize 32 $strip($1-)
  if ($1- == Trio-ircproxy.py active for this connection) { set $varname_cid(trio-ircproxy.py, active) $true }
  if ($4 != $null) && (*your username is ???* iswm $1-4) { set $varname_cid(trio-ircproxy.py, is_user) $4 }
  if (say-away == $1) && ($2 isin $true$false) { set $varname_glob(say-away,none) $2 }
  if (operscan-join == $1) && ($2 isin $true$false) { set $varname_cid(operscan-join,none) $2 }
  if ($1 == identify-chanserv) { set $varname_cid(identify-chanserv,$network) $true }
  if ($1 == identify-nick) { return }
}
alias -l popup-identify-founder-list {
  if ($bool_using_proxy == $false) {  return $style(2) identify as &founder  }
  var %chan = $var($varname_global(identify-chanserv,$+(*,-,$$network)),1)
  var %chan = [ [ %chan ] ]
  if (%chan) { 
    if (!$varname_cid(identified-founder,%chan)) {
    return identify as &founder }
  }
  else {
    retrun $style(3) identify as &founder
  }
}
alias true$false {
  return $true $+ $false
}
alias is_status_nick {
  ;check is active nick is either one of the two status nicks available.
  ;;
  if ($1) { var %nick = $1 }
  elseif ($nick != $null) { var %nick = $nick }
  if ($chr($asc(*)) $+ mg-script != %nick) { return $false }
  return $true
}
menu menubar {
  $iif((!$var(%bde_glob_*history*,0)),$style(2)) erase history : unset %bde_glob_*history* | eecho you have erased your history.
  $iif(($os isin 7,10,11),&set client faster (High)) : eecho changed priority of all running $nopath($mircexe) and python3.exe (py.exe) apps to 'High' | run -hn wmic process where name=" $+ $nopath($mircexe) $+ " CALL setpriority 128 | run -hn wmic process where name="python.exe" CALL setpriority 128 | run -hn wmic process where name="py.exe" CALL setpriority 128 | run -hn wmic process where name="python3.exe" CALL setpriority 128
  -
  server commands
  .knock room $chan : /raw knock $$chan
  .help help : raw help help
  .help : raw help
  .-
  .info : raw info
  .time : raw time
  .-
  .users : raw users
  .long users : raw lusers
  .-
  .list channels : list
  .server links : raw links




}
on *:input:$chan: {
  if (*?> $chr(35) $+ ?* !iswm $1-) { return }
  tokenize 32 $strip($1-)
  if ($0 < 2) { return }
  var %num = $remove($2,$chr(35))
  if (!$isnum(%num)) { return }
  var %name = $remove($1,<,>,+,@,%,&,!)
  if (!%name) { return }
  msg %name xdcc send $chr(35) $+ %num
  halt
}
menu @script_info {
  close window : window -c $active
  -
  flood : /script_info -flood
  channel history : script_info -history
  identity : script_info -identity
  listen ip : script_info -listen
  listen port : script_info -port
}
alias bnc_msg {
  if (!$varname_glob(status-nick,none).value) { return }
  if ($bool_using_proxy != $true) { return }
  if ($strip($1) == $null) { return }
  if ($silence) { .msg $varname_glob(status-nick,none).value $1- }
  else { msg $varname_glob(status-nick,none).value $1- }
}
alias status_msg {
  bnc_msg $1-
}
alias errecho {
  if ($active == Status Window) { echo -a 4Error: $1- }
  else { echo -as 4Error: $1- }
}
