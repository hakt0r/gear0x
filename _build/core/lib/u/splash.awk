function _ord_init(i){ for (i=0;i < 255; i++){ _ord[sprintf("%c",i)]=i } }
function _key_init(){ _ord_init(); _key_name[20]=" "; _key_name["d"]="enter"; _key_name["7f"]="backspace"; _key_name["1b5b48"]="home"; _key_name["1b5b46"]="end"; _key_name["1b5b1b"]="escape"; _key_name["1b5b41"]="up"; _key_name["1b5b42"]="down"; _key_name["1b5b43"]="right"; _key_name["1b5b44"]="left"; _key_name["1b5b337e"]="delete" }
function utf8_strlen(str,    C,c,i,ix,q){ C=q=c=i=0; ix=length(str)+1; for (i=1;i < ix; i++) { c = _ord[C = substr(str,i,1)]; if (C == "\e" && substr(str,i+1,1) == "[" && 0 < ( p = match(substr(str,i),/[a-zA-Z]/))) { i += p - 1; continue } if (c >= 0 && c <= 127)  i+=0; else if (and(c,0xe0) == 0xc0) i+=1; else if (and(c,0xf0) == 0xe0) i+=2; else if (and(c,0xf8) == 0xf0) i+=3; else return 0; q++ } return q }
function utf8_substr(str,L,  C,c,i,ix,q){ C=q=c=i=0; ix=length(str)+1; for (i=1;i < ix; i++) { if(q==L){return substr(str,1,i-1)"\x1b[0m"} c = _ord[C = substr(str,i,1)]; if (C == "\e" && substr(str,i+1,1) == "[" && 0 < ( p = match(substr(str,i),/[a-zA-Z]/))) { i += p - 1; continue } if (c >= 0 && c <= 127)  i+=0; else if (and(c,0xe0) == 0xc0) i+=1; else if (and(c,0xf0) == 0xe0) i+=2; else if (and(c,0xf8) == 0xf0) i+=3; else return 0; q++ } return str; }
function getchar(C,HEX,N){ READ="dd bs=1 count=1 of=/dev/stdout 2>/dev/null; echo"; READ | getline C; close(READ); HEX=sprintf("%x",_ord[C]); if(N=_key_name[HEX]) return N; if(HEX=="1b") return handle_escape("1b"); if(HEX=="7e") return handle_escape("7e"); return C }
function handle_escape(PREFIX,C){ READ="dd bs=1 count=1 of=/dev/stdout 2>/dev/null; echo"; READ | getline C; close(READ); HEX=PREFIX sprintf("%x",_ord[C]); if(N=_key_name[HEX]) return N; if(HEX=="1b5b33") return handle_escape(HEX); if(HEX=="1b5b") return handle_escape(HEX); return HEX }
function read_file(f,c){ getline c < f; close(f); return c; }
function write_file(file,data){ printf "%s" data > file; close(file) }
function write_choice(data,file){ F_CHOICE = USPLASH "/choice"; printf "%s" data > F_CHOICE; close(F_CHOICE); exit(0) }
function remote_render(o,p){ p = sprintf("%s nc local:%s/render >/dev/null 2>&1",BUSYBOX,USPLASH); print o "RENDER" | p; close(p) }

# renderer

function direct_render(mtop){
  input[NCOUNT++]=footer
  j=0; o=""; mtop=(ROWS-NCOUNT)/2; mend=mtop+NCOUNT
  for(i=0;i<ROWS;i++){
    if(mtop<i && i<=mend){
      if(isbg[i]) o = o utf8_substr(line[i],mleft+1)
      else o = o padmenu
      ln = utf8_substr(input[j++],MAXW)
      cc = utf8_strlen(ln)
      if( cc < MAXW ) ln = ln substr(zeros,1,MAXW-cc)
      o = o left_tile ln right_tile
    } else { o = o line[i] }
  } printf "%s",o ; NCOUNT=1 }

function render_main(){ _ord_init()
  BG="                             ████████████████                             \n                      ███████                ███████\n                  ████                              ████\n               ███        ▄██▄  ▄██▄  ▄██▄  ▄██▄        ███\n            ██████        █     █     █  █  █ ▄▀        ██████\n          █████████       █ ▀█  █▀▀   █ ▀█  █▀▄        █████████\n        █████████████     ▀██▀  ▀▄▄▄  █  █  █  █     ▓████████████\n       ███████████████                              ███████████████\n     ██████████████████▓                          ▓██████████████████\n    █████████████████████                        █████████████████████\n   ████████████████████████                    ████████████████████████\n  ███████████████████████████                ███████████████████████████\n  ██████████████████████████   ░▒▓██████▓▒░   ██████████████████████████\n █████████████████████████   ████████████████   █████████████████████████\n ████████████████████████  ████████████████████  ████████████████████████\n████████████████████████  ██████████████████████  ████████████████████████\n███████████████████████  ████████████████████████  ███████████████████████\n███████████████████████  ████████████████████████  ███████████████████████\n█                        ████████████████████████                        █\n█                         ██████████████████████                         █\n █                         ████████████████████                         █\n █                          ██████████████████                          █\n  █                          ████████████████                          █\n  █                              ▓▓████▓▓                              █\n   █                      ████▓▒          ▒▓█████                     █\n    █                    █████████████████████████                   █\n     ██                ▓███████████████████████████▓               ██\n       █              ███████████████████████████████             █\n        ██          ▓█████████████████████████████████▓         ██\n          ██       █████████████████████████████████████      ██\n            ███  ▓███████████████████████████████████████▓ ███\n               ████████████████████████████████████████████\n                  ██████████████████████████████████████\n                      ██████████████████████████████\n                             ████████████████"
  left_tile="\x1b[33m░▒▓█\x1b[0m"
  right_tile="\x1b[0;33m█▓▒░\x1b[0m"
  header="\x1b[1;41;33m GEARos \x1b[0m\x1b[1;42;30m 0x0001 \x1b[0m\x1b[1;43;30m enter to login \x1b[0m"
  footer=header; MAXW=32
  zeros = "                                                                                                                                                                                                                                                                                                            "
  split(BG,bg,"\n")
  bglh    = length(bg)
  bglw    = utf8_strlen(bg[1])
  mleft   = sprintf("%i",(COLS-MAXW-8)/2)
  bgtop   = sprintf("%i",(ROWS-bglh)/2)
  bgleft  = sprintf("%i",(COLS-bglw)/2)
  padbg   = substr(zeros,0,bgleft)
  padmenu = substr(zeros,0,mleft)
  for(i=0;i<ROWS;i++)line[i]="\x1b["i";1H\x1b[2K"
  for(i=0;i<length(bg);i++){ ln = i + bgtop
    isbg[ln] = "\x1b[" ln ";1H\x1b[0m"
    line[ln] = isbg[ln] padbg bg[i] "\x1b[0K" }
  for(i=0;i<ROWS;i++)printf "%s", line[i]
  input[0]=header; NCOUNT=1
  printf "\x1b[?25l\x1b[1;1H";
  direct_render()
  SERVER = sprintf( "%s tcpsvd -E local:%s/render 0 %s tee /proc/self/fd/2 2>&1", BUSYBOX, USPLASH, BUSYBOX )
  while( (SERVER|getline) > 0 ){
    if($1=="EXIT"){
      printf "\x1b[?25h\x1b[1;1H"
      system("fuser -k -KILL " USPLASH "/render >/dev/null 2>&1")
      system("rm -f " USPLASH "/render")
      close(SERVER)
      exit(0) }
    if      ($1=="PING"){ continue }
    else if ($1=="RENDER"){ direct_render() }
    else input[NCOUNT++]=$0 }}

# menu

function menu_read(i,c,items,menu){ COUNT=1; CTXCOUNT=1
  items = BUSYBOX " find " USPLASH " -type f -name *menu | sort"
  while((items|getline c)>0){
    menu = substr(c,1,length(c)-5)
    ID[menu]      = COUNT
    FILE[COUNT]   = menu
    TITLE[COUNT]  = read_file(c)
    ACTION[COUNT] = read_file(menu ".action")
    CTX[COUNT++]  = read_file(menu ".context/_default.action") }
  close(items); COUNT--; update_cursor() }

function update_cursor(c,items,menu){ CTXCOUNT=1 CTXCUR=1
  SEL=read_file(F_SELECTED)
  CUR=ID[SEL]
  if( SEL == "" && CUR==0 ){ SEL = FILE[CUR = 1] }
  if( CUR && CTX[CUR] ){
    items = BUSYBOX " find " SEL ".context -type f -name *action | sort"
    while((items|getline c)>0){
      menu = substr(c,1,length(c)-7)
      CTXACTION[CTXCOUNT] = read_file(c)
      CTXTITLE[CTXCOUNT]  = menu = read_file(menu ".title")
      if( CTXACTION[CTXCOUNT] == ACTION[CUR] ) TITLE[CUR] = menu
      CTXCOUNT++ }
    close(items) }
  CTXCOUNT-- }

function menu_write(){
  SEL = FILE[CUR];
  if( CTX[CUR] ){
    TITLE[CUR] = CTXTITLE[CTXCUR]
         print CTXACTION[CTXCUR] > SEL ".action"; close(SEL ".action")
         print CTXACTION[CTXCUR] > F_ACTION;      close(F_ACTION)   }
  else { print    ACTION[CUR]    > F_ACTION;      close(F_ACTION)   }
  print SEL                      > F_SELECTED;    close(F_SELECTED)
  menu_render() }

function menu_render(i,o){
  o = sprintf("\e[33m %s \e[0m (%i/%i)\n",HEADLINE,COUNT,CUR)
  for(i=TOP;i<=COUNT;i++){
    if( CUR == i ) o = o "\e[42;1m"
    o = o TITLE[i]
    if( CTX[i] ) o = o " [*]"
    o = o "\n" }
  remote_render(o) }

function menu_main(){ _key_init()
  F_ACTION   = USPLASH "/action"
  F_SELECTED = USPLASH "/selected"

  TOP=1; menu_read(); menu_render()
  if(UPDATE) exit(0)
  while( C = getchar() ){
         if (C=="enter"){ menu_read(); menu_write(); exit(0) }
    else if (C=="up"){    menu_read(); CUR--;    if(CUR==0)          CUR=COUNT; }
    else if (C=="down"){  menu_read(); CUR++;    if(CUR>COUNT)       CUR=1; }
    else if (C=="left"  && CTX[CUR] ){ menu_read(); CTXCUR--; if(CTXCUR==0)       CTXCUR=CTXCOUNT; }
    else if (C=="right" && CTX[CUR] ){ menu_read(); CTXCUR++; if(CTXCUR>CTXCOUNT) CTXCUR=1; }
    else if (C=="escape"||C=="q"){ CTX[CUR] = 0; ACTION[CUR] = "return 1\n"; menu_write(); exit(0) }
    menu_write(); }}

# select

function select_read(list,count,i,line){ COUNT=1
  split(VAL,list,"\n"); count=length(list)
  for(i=1;i<count;i++){ if(line=list[i]){ TITLE[COUNT++] = line }}}

function select_render(i,o){
  o = sprintf("\e[33m %s \e[0m\n",HEADLINE)
  for(i=TOP;i<COUNT;i++){
    if(CUR==i) o = o "\e[1;42m"
    o = o TITLE[i] "\n" }
  remote_render(o) }

function select_main(){ _key_init()
  CUR=1; TOP=1; select_read(); select_render()
  while( C = getchar() ){
         if ( C == "enter" ) write_choice(TITLE[CUR])
    else if ( C == "up"    ){ CUR--; if(CUR==0) CUR=COUNT-1 }
    else if ( C == "down"  ){ CUR++; if(CUR==COUNT) CUR=1 }
    select_render() }}

# choose

function choose_read(list,count,i,line,field,val){ COUNT=1
  split(VAL,list,"\n")
  count=length(list)
  for(i=1;i<count;i++){ if(line=list[i]){
    split(line,field,/[ \t]+/)
    KEY[COUNT] = field[1];
    CHILD[COUNT] = length(field[1]) > 1
    VAL[COUNT] = val=field[2]
    TITLE[COUNT] = substr(line,index(line,val)+2)
    COUNT++ }}}

function update_children(key,val,i){
  for(i=1;i<COUNT;i++){ if(1==index(KEY[i],key)) VAL[i]=val }}

function choose_render(i,o){
  o = sprintf("\e[33m %s \e[0m (%i/%i/%i/%s)\n",HEADLINE,COUNT,CUR,HEX,C)
  for(i=TOP;i<COUNT;i++){
    if(CUR==i) o = o "\e[1;42m"
    if(VAL[i]) o = o " [*] "
    else o = o " [ ] "
    if(CHILD[i]) o = o "\\ "
    o = o TITLE[i] "\n" }
  remote_render(o) }

function choose_main(){ _key_init()
  CUR=1; TOP=1; choose_read(); choose_render()
  while( C = getchar() ){
    if (C=="up"){   CUR--; if(CUR==0)     CUR=COUNT-1 }
    else if ( C == "down" ){ CUR++; if(CUR==COUNT) CUR=1 }
    else if ( C == "enter" ){
      o=""; for(i=1;i<COUNT;i++) if(VAL[i]) o = o " " KEY[i]
      write_choice(substr(o,2)) }
    else if ( C == " " )
      if ( 0 == ( VAL[CUR] = ( VAL[CUR] + 1 ) % 2 ) )
        update_children(KEY[CUR],0)
    choose_render() }}

# prompt

function prompt_render(o,a,c,e,len){
  len = length(VAL); if(CUR<0)CUR=0; if(CUR>len+1) CUR=len;
  a = substr(VAL,1,CUR)
  c = substr(VAL,CUR+1,1); if(c=="")c=" "
  e = substr(VAL,CUR+2)
  o = sprintf("\e[33m %s \e[0m (%i/%i/%s)\n",HEADLINE,CUR,len,HEX)
  o = o a "\e[42m" c "\e[0m" e "\n"
  remote_render(o) }

function prompt_main(){ _key_init()
  CUR=0; prompt_render();
  while( C = getchar() ){
    if (C=="enter"){ write_choice(VAL) }
    else if (C=="up")    CUR=utf8_strlen(VAL)
    else if (C=="down")  CUR=0
    else if (C=="left")  CUR--
    else if (C=="right") CUR++
    else if (C=="backspace"){ if(CUR>0) { a = substr(VAL,1,CUR-1); c = substr(VAL,CUR+1); VAL = a c; CUR-- } }
    else if (C=="delete"){ a = substr(VAL,1,CUR); c = substr(VAL,CUR+2); VAL = a c }
    else{ a = substr(VAL,1,CUR) C; c = substr(VAL,CUR+1); VAL = a c; CUR++ }
    prompt_render() }}

# yesno

function yesno_render(o){
  o = o a "\e[1;42;37m " HEADLINE "\n"
  if(VAL==1) o = o YES
  else    o = o NO
  remote_render(o) }

function yesno_main(){ _key_init()
  YES="    no               \e[30;42m▓▒░ yes ░▒▓\e[0m \n"
   NO="\e[30;41m▓▒░ no ░▒▓\e[0m                yes    \n"
  if(VAL!=1)VAL=0; yesno_render()
  while( C = getchar() ){
    if (C=="enter") { yesno_render(); exit(VAL-1) }
    else if (C=="y"||C=="j") { yesno_render(); exit(0) }
    else if (C=="n"||C=="q"||C=="escape") { yesno_render(); exit(1) }
    else VAL = ( VAL + 1 ) % 2
    yesno_render() }}

BEGIN{ if ( CMD == "render") render_main()
  else if ( CMD == "prompt") prompt_main()
  else if ( CMD == "select") select_main()
  else if ( CMD == "choose") choose_main()
  else if ( CMD == "yesno")  yesno_main()
  else if ( CMD == "menu")   menu_main() 
  else exit(2) }
