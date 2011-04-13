$Id: zshrc 88 2010-06-15 13:20:22 emory $

export WWW_HOME="http://www.google.com/"

# Search path for the cd command
cdpath=(. .. ~ ~/Sources ~/bin ~/Applications ~/Dropbox ~/Documents ~/Projects)

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 077

# set up the host config for stuff
# (provided that uname is in your path; there should be a better
# way to do this...)

export OS_TYPE=`uname -s`
export OS_REV=`uname -r`
MAJOR_OS_REV=""
BIN_DIR=${OS_TYPE}${MAJOR_OS_REV}

shorthost=$HOST:r:r:r

#
# set up cpath et al
#

cpath=( /bin /usr/bin )
lpath=( /usr/local/{bin,sbin} )
opath=( )
spath=( /sbin /usr/sbin )
xpath=( /usr/X11R6/bin )
zpath=( )
#manpath=( /usr/share/man:/usr/man:/usr/local/man:/opt/man:/opt/gnu/man:/usr/share/catman )


#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
# Determine the Arch and set it up accordingly                              #
#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
#echo $OS_TYPE

if [[ ${OS_TYPE} == "SunOS" ]]; then
   # Proto SunOS Box (real Sun OS)
   MAJOR_OS_REV=`uname -r | sed  -e 's/\..*$//'`
   if [[ ${MAJOR_OS_REV} == "5" ]]; then #Solaris something
      cpath=( /usr/{ucb,bin,ccs/bin,sfw/bin} /opt/{bin,sbin} /opt/sfw/bin /opt/csw/bin )
      lpath=(/opt/{gnu/bin,gnu/sbin} /usr/local/{bin,sbin} /opt/SUNWspro/bin)
      xpath=( /usr/openwin/bin /opt/X11R6/bin /usr/dt/bin /opt/csw/kde-gcc/bin/ )
      export LD_LIBRARY_PATH=/opt/X11R6/lib:/usr/openwin/lib:/usr/dt/lib
      manpath=/opt/man:/opt/gnu/man:/usr/man:/usr/dt/share/man:/opt/SUNWspro/man:/opt/X11R6/man:/usr/share/man
      psa  () { ps -ef | $PAGER }
      psag () { ps -ef | grep $* | grep -v grep }
      sys  () { $SYSLOG /var/adm/messages }
   else #The Real SunOS
      spath = ( /usr/{ucb,bin,local,lang,gnu/bin,local/bin,games,etc} )
      set xpath = ( /usr/X/bin )
      export LD_LIBRARY_PATH=/usr/X/lib:/usr/openwin/lib
      manpath=/usr/lang/man:/usr/gnu/man:/usr/man:/usr/X/man
      psa  () { ps -aux | $PAGER }
      psag () { ps -aux | grep $* | grep -v grep }
   fi
elif [[ ${OS_TYPE} == "OSF1" ]]; then

   # Proto OSF Box 

   cpath=( /bin /usr/{bin,ccs/bin,dt/bin )
   lpath=(/opt/{gnu/bin,gnu/sbin} /usr/local/{bin,sbin} )
   spath=( /sbin /usr/{sbin,tcb/bin} )
   export LD_LIBRARY_PATH=/usr/lib:/lib:/usr/shlib
   export MAIL=/var/spool/mail/$USER
   psa  () { ps -aux | $PAGER }
   psag () { ps -aux | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/adm/SYSLOG }
   hinv () { uerf }
elif [[ ${OS_TYPE} == "Linux" ]]; then

   # Proto Linux Box

   cpath=( /bin /usr/{ucb,bin,games} )
   spath=( /sbin /usr/sbin /etc /usr/etc )
   xpath=( /usr/X11/bin )
   export LD_LIBRARY_PATH=/usr/X386/lib:/usr/openwin/lib:/usr/lib
   export MAIL=/var/spool/mail/$USER
   #export PYTHONPATH=$PYTHONPATH:/home/elundberg/svn/gdata-python-client/src
   psa  () { ps -aux | $PAGER }
   psag () { ps -aux | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/adm/syslog }

elif [[ ${OS_TYPE} == "BSD/OS" ]]; then 
   # Proto BSD Box
   cpath=( /bin /usr/{bin,contrib/bin} )
   spath=( /sbin /usr/{sbin,libexec} )
   xpath=( /usr/X11/bin )
   export LD_LIBRARY_PATH=/usr/X11/lib:/usr/lib
   manpath=/usr/contrib/man:/usr/X11/man:/usr/share/man:/usr/local/man
   psa  () { ps -aux | $PAGER }
   psag () { ps -aux | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/adm/syslog }


elif [[ ${OS_TYPE} == "OpenBSD" ]]; then

   # OpenBSD Box 

   cpath=( /bin /usr/{bin,contrib/bin} )
   spath=( /sbin /usr/{sbin,libexec} )
   xpath=( /usr/X11R6/bin /usr/local/hy/rubyphoto )
   export LD_LIBRARY_PATH=/usr/X11R6/lib:/usr/lib:/usr/local/lib
   export CVSROOT=anoncvs@anoncvs.ca.openbsd.org:/cvs
   export CVS_RSH=/usr/bin/ssh
   manpath=/usr/contrib/man:/usr/X11R6/man:/usr/share/man:/usr/local/man
   psa  () { ps -aux | $PAGER }
   psag () { ps -aux | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/log/messages }

elif [[ ${OS_TYPE} == "Darwin" ]]; then

   # Mac OS X 

   cpath=( /bin /usr/{bin,contrib/bin} /usr/local/bin /opt/local/bin ~/Applications /sw/bin)
   spath=( /sbin /usr/{sbin,libexec} /usr/local/sbin /opt/local/sbin /sw/sbin
   /usr/local/ant/bin )
   xpath=( /usr/X11R6/bin /sw/bin )
   export LD_LIBRARY_PATH=/usr/X11R6/lib:/usr/lib:/opt/local/lib:/usr/local/lib:/sw/lib
   export CVSEDITOR=vim
   export SVNEDITOR=vim
   export CVS_RSH=/usr/bin/ssh    
   export RUBYOPT=rubygems
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
   psa  () { ps -aux | $PAGER }
   psag () { ps -aux | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/log/system.log }


elif [[ ${OS_TYPE} == "FreeBSD" ]]; then
	
   # Free BSD Box
   cpath=( /bin /usr/{bin,contrib/bin} )
   spath=( /sbin /usr/{sbin,libexec} )
   xpath=( /usr/X11R6/bin )
   export LD_LIBRARY_PATH=/usr/X11/lib:/usr/lib
   manpath=/usr/contrib/man:/usr/X11/man:/usr/share/man:/usr/local/man
   psa  () { ps -aux | $PAGER }
   psag () { ps -aux | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/adm/syslog }


elif [[ ${OS_TYPE} == "HP-UX" ]]; then

   # Proto HP-UX Box (Ugh)

   MAJOR_OS_REV=`uname -r | sed -e 's/^[^\.]*\.//' -e 's/\..*$//'`
   cpath=( /bin /usr/{bin,contrib/bin} /opt/{ansic/bin,langtools/bin} )
   lpath=( /opt/{gnu/bin,bin,sbin} /usr/local/{bin,sbin} )
   opath=( /opt{dce/bin,dce/sbin,video/lbin,pd/bin} )
   spath=( /sbin /usr/{sbin,lbin,sam/bin,sam/lbin,ccs/bin,ccs/lbin} )
   xpath=( /usr/bin/X11 )
   export LD_LIBRARY_PATH=/usr/lpp/X11/lib
   manpath=/usr/local/man:/usr/man:/usr/gnu/man:/usr/X11R6/man
   psa  () { ps -aef | $PAGER }
   psag () { ps -aef | grep $* | grep -v grep }
   if [[ ${MAJOR_OS_REV} == "10" ]]; then
      sys () { $SYSLOG /var/adm/syslog/syslog.log }
   elif [[ ${MAJOR_OS_REV} == "09" ]]; then
      sys () { $SYSLOG /usr/adm/syslog }
   fi
elif [[ ${OS_TYPE} == "AIX" ]]; then

   # Proto AIX Box 

   spath = ( /bin /sbin /usr/{bin,ucb,local/bin,local/sbin,sbin,ccs/bin} )
   xpath = ( /usr/bin/X11 )
   export LD_LIBRARY_PATH=/usr/lpp/X11/lib
   psa  () { ps -aef | $PAGER }
   psag () { ps -aef | grep $* | grep -v grep }
elif [[ ${OS_TYPE} == "IRIX" || ${OS_TYPE} == "IRIX64" ]]; then

   # Proto IRIX Box

   MAJOR_OS_REV=`uname -r | sed  -e 's/\..*$//'`
   cpath=( /bin /usr/{bin,freeware/bin,bsd,demos/bin,Cadmin/bin} )
   lpath=( /opt/gnu/bin /opt/{bin,sbin} /usr/local/bin )
   spath=( /sbin /etc /usr/{sbin,etc} )
   xpath=( /usr/bin/X11 )
   manpath=( /usr/man:/opt/gnu/man:/usr/share/catman )
   export LD_LIBRARY_PATH=/usr/lib:/lib:/usr/local/lib
   export LD_LIBRARYN32_PATH=/lib32:/usr/lib32
   export LD_LIBRARY64_PATH=/lib64:/usr/lib64
   ldd  () { elfdump -Dl $* }
   truss () { par -S $* }
   psa  () { ps -aef | $PAGER }
   psag () { ps -aef | grep $* | grep -v grep }
   sys  () { $SYSLOG /var/adm/SYSLOG }
   libgrep () { nm -Bo /usr/lib/lib*.so | grep $* }
else
   echo "[.zshrc] $OS_TYPE not found.  Using defaults at top of .zshrc.  (No biggie.)"
fi
BIN_DIR=${OS_TYPE}${MAJOR_OS_REV}
hpath=( $HOME/$BIN_DIR $HOME/bin )
path=( $hpath $lpath $spath $cpath $xpath $opath $zpath . )
unset hpath $lpath cpath spath xpath opath zpath

#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
# Setup Important env Vars if we have the right stuff.                      #
#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#

EDITOR=`which vim`
if [[ $status == 1 ]]; then
   export EDITOR=vi
   export VISUAL=vi
else
   export VISUAL=$EDITOR
fi
SHELL=`which zsh`
if [[ $status == 1 ]]; then
   export SHELL=/bin/ksh
fi
PAGER=`which less`
if [[ $status == 0 ]]; then
   export LESS="-e -g -M -i"
   export SYSLOG="less"
   export VIEWER=$PAGER
   export READNULLCMD=$PAGER
else
   export PAGER=more
   export SYSLOG="tail -100 $1 | more"
fi

# Where to look for autoloaded function definitions
# fpath=(~/.zfunc)

# Autoload all shell functions from all directories
# in $fpath that have the executable bit on
# (the executable bit is not necessary, but gives
# you an easy way to stop the autoloading of a
# particular shell function).

#for dirname in $fpath
#do
#  autoload $dirname/*(.x:t)
#done

# Set some junk.

HISTSIZE=200
SAVEHIST=200
HISTFILE=$HOME/.zsh_history
REPORTTIME=5
TIMEFMT="User:%U Kernel:%S REAL:%E CPU:%P %J"

# Global aliases -- These do not have to be
# at the beginning of the command line.

alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

#manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
export MANPATH=/usr/man:/usr/share/man:/usr/local/share/man:/usr/local/man:/usr/X11R6/man
#export MANPATH

# Filename suffixes to ignore during completion
fignore=(.o .c~ .old .pro)

# Hosts to use for completion
hosts=(`hostname` autobahn.hellyeah.com itsecurity12.its.uiowa.edu ids7 )

# Set prompts
autoload promptinit
promptinit
#prompt bart

# Decide if we need to set titlebar text.
    
    case $TERM in
        xterm*)
            PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
            ;;
        screen)
            PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
            ;;
        *)
            PR_TITLEBAR=''
            ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
        PR_STITLE=$'%{\ekzsh\e\\%}'
    else
        PR_STITLE=''
    fi
    
    
    ###
    # APM detection
    
    ##if which ibam > /dev/null; then
        #PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLUE:'
    #elif which apm > /dev/null; then
        #PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLUE:'
    #else
        #PR_APM=''
    #fi
    
    
    ###
    # Finally, the prompt.


# WHUT prompt

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
    export PS1="$WINDOW:%~%# "
else
    export PS1='%m %~ %# '
fi

# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}


# END WHUT prompt

# Watch for my friends
# Set below
#watch=($(cat ~/.friends))      # watch for people in .friends file
watch=(notme)                   # watch for everybody but me

LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Auto_Name_Dirs
   setopt ALWAYS_LAST_PROMPT ALWAYS_TO_END APPEND_HISTORY AUTO_LIST AUTO_MENU \
     	  AUTO_PARAM_KEYS AUTO_PARAM_SLASH AUTO_PUSHD \
          AUTO_REMOVE_SLASH AUTO_RESUME BAD_PATTERN BANG_HIST COMPLETE_ALIASES \
          COMPLETE_IN_WORD CORRECT_ALL CSH_JUNKIE_HISTORY CSH_JUNKIE_LOOPS \
          EXTENDED_HISTORY FUNCTION_ARGZERO HIST_IGNORE_DUPS HIST_IGNORE_SPACE \
          HIST_REDUCE_BLANKS IGNORE_EOF INTERACTIVE_COMMENTS LIST_TYPES \
          LONG_LIST_JOBS MAIL_WARNING MARK_DIRS #OVERSTRIKE PATH_DIRS
   setopt PUSHD_IGNORE_DUPS PROMPT_SUBST PUSHD_SILENT PUSHD_TO_HOME \
          SHORT_LOOPS SUN_KEYBOARD_HACK CDABLE_VARS NOHUP
   unsetopt BG_NICE ALWAYS_LAST_PROMPT

# Setup some basic programmable completions.  To see more examples
# of these, check Misc/compctl-examples in the zsh distribution.
compctl -g '*(-/)' cd pushd
compctl -g '*(/)' rmdir dircmp
compctl -j -P % -x 's[-] p[1]' -k signals -- kill
compctl -j -P % fg bg wait jobs disown
compctl -A shift
compctl -caF type whence which
compctl -F unfunction
compctl -a unalias
compctl -v unset typeset declare vared readonly export integer
compctl -e disable
compctl -d enable

#*----+----+----+----+
#	host completions
#*----+----|----+----+
# this is very complex and ruley.
# you can have it complete hostnames for you, but like.  i don't mess
# with that much.
# 
#autoload createcomphosts
#compctl -K createcomphosts telnet rsh rup ping traceroute ssh xrsh
#
#function createcomphosts() {
#   hosts=""
#   foreach moo ( ~/.hosts-* )
#      echo "loading $moo"
#      hosts=($hosts `cat $moo`)
#   end
#}
   setopt NULL_GLOB
   hosts=""
   foreach moo ( ~/.hosts-* )
      hosts=($hosts `cat $moo`)
   end
   unsetopt NULL_GLOB
   compctl -l '' nohup noglob exec nice eval - time rusage
   compctl -l '' -x 'p[1]' -eB -- builtin
   compctl -l '' -x 'p[1]' -em -- command
   compctl -x 'p[1]' -c - 'p[2,-1]' -k signals -- trap
   compctl -g '*(/)' rmdir dircmp
   #compctl -g '*(-/)||.*(-/)' cd chdir dirs pushd
   compctl -g '*(D-/)' cd chdir dirs pushd
   compctl -g '*(/)' rmdir dircmp
   compctl -j -P % -x 's[-] p[1]' -k signals -- kill
   compctl -j -P % fg bg wait jobs disown
   compctl -A shift
   compctl -caF type whence which where
   compctl -F unfunction
   compctl -a unalias
   compctl -v unset typeset declare vared readonly export integer
   compctl -e disable
   compctl -d enable
   compctl -k hosts -x 'p[2,-1]' -l '' -- rsh
   compctl -k hosts -x 'p[2,-1]' -l '' -- ssh
   compctl -k hosts -x 'c[-1,-l]' -u -- rlogin
   compctl -k hosts -x 'c[-1,-l]' -u -- slogin
   compctl -k hosts -x 's[[+-]]' -k hosts -- xhost
   compctl -k hosts host nslookup rup rusers ftp traceroute ping
   compctl  -x 'p[1]' -k hosts - 'p[2]' -X '<port>' -- telnet t ktelnet
   compctl -u -S '@' -x 'n[-1,@]' -k hosts -- finger
   compctl -x 'p[1]' -k hosts - 's[-]' -k '(l 8 e)' - 'c[-1,-l]' -u - \
      'c[-2,-l]' -c - 'c[-1,-]' -c - 'p[2]' -c - 'p[*]' -f -- xrsh
   compctl -u -k hosts -f -x 'n[1,:]' -f - 'n[1,@]' -k hosts -S ':' - \
      'p[1] W[2,*:*]' -f - 'p[1] W[2,*?*]' -u -k hosts -S ':' - \
      'p[2] W[1,*:*]' -f - 'p[2] W[1,*?*]' -u -k hosts -S ':' -- rcp
   compctl -u -k hosts -f -x 'n[1,:]' -f - 'n[1,@]' -k hosts -S ':' - \
      'p[1] W[2,*:*]' -f - 'p[1] W[2,*?*]' -u -k hosts -S ':' - \
      'p[2] W[1,*:*]' -f - 'p[2] W[1,*?*]' -u -k hosts -S ':' -- scp

   #compctl -g '*.[^oa]' vi vile
   compctl -f -x 'p[1] n[-1,.], p[2] C[-1,-*] n[-1,.]' -k groups - \
      'p[1], p[2] C[-1,-*]' -u -S '.' -q -- chown
   #compctl -f -x 's[--]' -k '(changes silent quiet verbose recursive help \
      #version)' - 's[-]' -k '(c f v R -)' - 'S[[./$~]]' -f - 'n[-1,[.:]]' \
       #- 'c[-1,-]' -u -S '.' - 'p[1]' -u -S '.' -- chown
   compctl -f -x 's[--]' -k '(changes silent quiet verbose recursive help \
      version)' - 's[-]' -k '(c f v R -)' - 'c[-1,-]'  - 'p[1]'  -- chgrp
   compctl -x 's[-P]' -k PRINTER -- lpr
   compctl -x 's[-P]' -k PRINTER -- lpq
   compctl -x 's[-P]' -k PRINTER -- lprm
   compctl -x 'p[1]' -k '(-Qprlogger)' - 's[-P]' -k printers -- lpquota
   compctl -g '*.dvi' -x 's[-P]' -k printers - 'c[-1,-o]' -g '*.(ps|PS)' -- dvip  compctl -z -P '%' bg
   compctl -j -P '%' fg jobs disown
   compctl -j -P '%' + -s '`ps -x | tail +2 | cut -c1-5`' wait
   compctl -m -x 'W[1,-*d*]' -n - 'W[1,-*a*]' -a - 'W[1,-*f*]' -F -- unhash
   compctl -m -q -S '=' -x 'W[1,-*d*] n[1,=]' -g '*(-/)' - \
      'W[1,-*d*]' -n -q -S '=' - 'n[1,=]' -g '*(*)' -- hash
   compctl -F functions unfunction
   compctl -k '(al dc dl do le up al bl cd ce cl cr
      dc dl do ho is le ma nd nl se so up)' echotc
   compctl -a unalias
   compctl -v getln getopts read unset vared
   compctl -v -S '=' -q declare export integer local readonly typeset
   compctl -eB -x 'p[1] s[-]' -k '(a f m r)' - \
      'C[1,-*a*]' -ea - 'C[1,-*f*]' -eF - 'C[-1,-*r*]' -ew -- disable
   compctl -dB -x 'p[1] s[-]' -k '(a f m r)' - \
      'C[1,-*a*]' -da - 'C[1,-*f*]' -dF - 'C[-1,-*r*]' -dw -- enable
   compctl -k "(${(j: :)${(f)$(limit)}%% *})" limit unlimit
   compctl -l '' -x 'p[1]' -f -- . source
   compctl -s '$(setopt 2>/dev/null)' + -o + -x 's[no]' -o -- unsetopt
   compctl -s '$(unsetopt 2>/dev/null)' + -o + -x 's[no]' -o -- setopt
   compctl -s '${^fpath}/*(N:t)' autoload
   compctl -b -x 'W[1,-*[DAN]*],C[-1,-*M]' -s '$(bindkey -l)' -- bindkey
   compctl -c -x 'C[-1,-*k]' -A - 'C[-1,-*K]' -F -- compctl
   compctl -x 'C[-1,-*e]' -c - 'C[-1,-[ARWI]##]' -f -- fc
   compctl -x 'p[1]' - 'p[2,-1]' -l '' -- sched
   compctl -x 'C[-1,[+-]o]' -o - 'c[-1,-A]' -A -- set
   compctl -b -x 'w[1,-N] p[3]' -F -- zle
   compctl -s '${^module_path}/*(N:t:r)' -x \
      'W[1,-*(a*u|u*a)*],W[1,-*a*]p[3,-1]' -B - \
      'W[1,-*u*]' -s '$(zmodload)' -- zmodload
   compctl -j -P '%' + -s '`ps -x | tail +2 | cut -c1-5`' + \
      -x 's[-] p[1]' -k "($signals[1,-3])" -- kill
   compctl -s '$(groups)' + -k groups newgrp
   compctl -f -x 'p[1], p[2] C[-1,-*]' -k groups -- chgrp
   compctl -g '*.x' + -g '*(-/)' rpcgen
   compctl -u -x 's[+] c[-1,-f],s[-f+]' -g '~/Mail/*(:t)' - \
      's[-f],c[-1,-f]' -f -- mail elm
   compctl -f -x 'W[1,*(z*f|f*z)*] p[2]' -g '*.(tar.gz|tgz|tar.Z|taz)' - \
      'W[1,*f*] p[2]' -g '*.tar' -- gnutar gtar tar
   compctl -g '*(*)' strip gprof adb dbx xdbx ups
   compctl -f -x 'C[-1,-*c]' -c - 'C[-1,[-+]*o]' -o -- bash ksh sh zsh
   compctl -u -x 'w[1,-]p[3,-1]' -l sh - 'w[1,-]' -u - 'p[2,-1]' -l sh -- su
   compctl -g '*.(e|E|)(ps|PS)' + -g '*(-/)' \
      gs ghostview nup psps pstops psmulti psnup psselect
   compctl -g '*.tex*' + -g '*(-/)' {,la,gla,ams{la,},{g,}sli}tex texi2dvi
   compctl -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' gunzip gzcat zcat
   compctl -g '*.Z' + -g '*(-/)' uncompress zmore
   compctl -g '*.F' + -g '*(-/)' melt fcat
   Xcolours() {
     reply=( ${(L)=:-$(awk '{ if (NF = 4) print $4 }' \
      < /usr/lib/X11/rgb.txt)} )
   }
   Xcursor() {
     reply=( $(sed -n 's/^#define[   ][   ]*XC_\([^   ]*\)[    ].*$/\1/p' \
        < /usr/include/X11/cursorfont.h) )
   }
   #compctl -k '(-help -def -display -cursor -cursor_name -bitmap -mod -fg -bg
      #-grey -rv -solid -name)' -x \
      #'c[-1,-display]' -s '$DISPLAY' -k hosts -S ':0' - \
      #'c[-1,-cursor]' -f -  'c[-2,-cursor]' -f - \
      #'c[-1,-bitmap]' -g '/usr/include/X11/bitmaps/*' - \
      #'c[-1,-cursor_name]' -K Xcursor - \
      #'C[-1,-(solid|fg|bg)]' -K Xcolours -- xsetroot

#  # talk completion: complete local users, or users at hosts listed via rwho
#   compctl -K talkmatch talk ytalk ytalk3 ntalk
#   function talkmatch {
#       local u
#       reply=($(users))
#       for u in "${${(f)$(rwho 2>/dev/null)}%%:*}"; do
#      reply=($reply ${u%% *}@${u##* })
#       done
#   }
#fi


# Some nice key bindings
#
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

# bindkey -v             # vi key bindings

bindkey -e               # emacs key bindings
bindkey ' ' magic-space  # also do history expansino on space

#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
# WorkTerm Titlebar Stuff     This should only be executed once...          #
#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
# However, don't do it unless you're on a local host and running XTerm...   #
#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
#   here are some others you can toss in there; i usually just leave these out...
#   if you want them in there, put them down below the actual window code
#
#   vi () { icon "[vi $*] $shorthost";command $EDITOR $*;icon $TITLE }
#   rlogin () { settitle "rlogin $*"; command rlogin $*;title }
#   telnet () { settitle "telnet $*"; command telnet $*;title }
#   pine () { settitle "Pine"; command pine;title }
#   ktelnet () { settitle "ktelnet $*"; command ktelnet $*;title }
#   ssh () { settitle "ssh $*"; command ssh $*;title }
#   slogin () { settitle "slogin $*"; command slogin $*;title }
#   rtelnet () { settitle "rtelnet $*";\rtelnet $*;title }
#   remsh () { settitle "remsh $*";\remsh $*;title }
#   fix ()  { export TITLE="`whoami`@$shorthost" }

#if [ "$TERM" = "xterm" ]; then
   #echo -n "\e]2;$HOSTNAME:$PWD\007"
   #function precmd () {
     #echo -n "\e]2;$HOSTNAME:$PWD\007\e]1;$HOSTNAME\007"
   #}
#fi


#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
# Aliases                                                                   #
#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
alias ls='ls -F'
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias cp='nocorrect cp -i'    # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias rm='rm -i'
alias del='command /bin/rm'
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
#alias la='ls -Fa'
#alias lsd='ls -ld *(-/DN)'
#alias lsa='ls -ld .*'
#alias lf='ls -Flags'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias rd='rmdir'
alias md='mkdir'
alias gc='gunzip -c'
alias more='$PAGER'
alias sus='suspend'
alias g='grep'
alias f='finger'
alias pss='ps -auxg | grep -v grep | grep $USER | sort'
alias sc='source $HOME/.zshrc'
alias vt100='set term=vt100'
alias es='exec tcsh'
alias ez='exec zsh'
alias lock='nice xlock -r -mode hop'
alias rwhois='telnet 198.41.1.7 4321'
#rs.internic.net whois.arin.net whois.ripe.net whois.apnic.net whois.nic.mil
alias note='cat > /dev/null'
alias dusort='du -ks *|sort -nr|more'
#alias lssort='ls -ls|sort -nr|more'
alias etime="perl -e 'use POSIX; print ctime(shift);'"

#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
# Functions                                                                 #
#*--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--*#
tart ()          { gunzip -c $* | tar tvf - | $PAGER }
tarx ()          { gunzip -c $* | tar xvf - }
tartz ()         { zcat -c $* | tar tvf - }
tarxz ()         { zcat $* | tar xvf - }
nman ()          { nroff -man $* | more }
ensn ()          { enscript -2rG -b"$USER@$HOST ($PRINTNAME)" $* }
ensn1 ()         { enscript -G -b"$USER@$HOST ($PRINTNAME)" $* }
ensnfile ()      { enscript -2rG -b"$USER@$HOST ($PRINTNAME)" -p/tmp/$1.ps $* }
ensnfile1 ()     { enscript -G -b"$USER@$HOST ($PRINTNAME)" -p/tmp/$*.ps $* }
#crypt ()         { pgp -e $* $USER -o $*.pgp;rm -i $*}
#uncrypt ()       { pgp $*;rm -i $* }
dir ()           { ls -al $* |more }
#ll ()            { command ls -la $* | more }
#ff ()            { find . -name $* -print }
#ffgrep ()        { find . -type f -exec grep '$*' '{}' /dev/null \; }
#gref ()          { find . -type f -print | xargs grep '$*' }
#ffind ()         { find . -type f -exec grep -l '$*' '{}' \; }
#ftest ()         { echo "find . -type f -exec grep -l '$*' '{}' \;" }
setenv ()        { export $1=$2 }					# to jive with csh
#hog ()           { du -ks $*|sort -nr|pg }
#hogclean ()      { ls -ls|sort -nr|pg }
#mk ()            { tar cvf /data/src/aol/$*.tar $* }
lower ()         { tr -s '[:upper:]' '[:lower:]' }
count ()         { awk 'BEGIN { if ("'$#argv'"==1) Col="'$1'"; else Col=1 } {Tot\
al += $Col; }; END  { printf "Total for column %d with %d items is %d\n", Col,NR\
,Total }' }
avg ()           { awk 'BEGIN { if ("'$#argv'"==1) Col="'$1'"; else Col=1 } {Tot\
al += $Col;}; END  {printf "total= %d",$Total}{ printf "Total for column %d with\
 %d items is %d\n", Col,NR,Total }' }
undos ()         { sed 's//g' $* > $*.clean }


# Watching for people
# #watch=($(cat ~/.friends))      # watch for people in .friends file

case $host in
   (*.hellyeah.com)
      watch=( douglas:chris:mike:annette:bryan:ben:pong:jyee:orange:hagbard:jpatrick:ace:andy:aikido )
   ;&
   (*.aol.com )
      watch=(notme)
   ;&
   (dns*)
      export TITLE="$host"
      title
   ;&
   (*.cais.net)
      watch=(notme)
   ;&
   (swank.office.aol.com)
      mailpath="/var/mail/$USERNAME:$HOME/mail?You have new mail in $_"
   ;&
   (news.inet.net)
      zpath=( /usr/local/news/bin )
   ;&
esac

