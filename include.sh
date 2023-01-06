#!/bin/sh
#Author bolivari
#Version 0.8
#License GPL

#ECHO='/bin/echo -e'

Print(){
	/bin/echo "$*"
}
Printe(){
	/bin/echo -e "$*"
}
Printne(){
	/bin/echo -ne "$*"
}
PrintE(){
	/bin/echo -E "$*"
}
#TODO 256 color
Color(){
	txtblk='\e[0;30m' # Black - Regular
	txtred='\e[0;31m' # Red
	txtgrn='\e[0;32m' # Green
	txtylw='\e[0;33m' # Yellow
	txtblu='\e[0;34m' # Blue
	txtpur='\e[0;35m' # Magenta
	txtcyn='\e[0;36m' # Cyan
	txtwht='\e[0;37m' # White
	bldblk='\e[1;30m' # Black - Bold
	bldred='\e[1;31m' # Red
	bldgrn='\e[1;32m' # Green
	bldylw='\e[1;33m' # Yellow
	bldblu='\e[1;34m' # Blue
	bldpur='\e[1;35m' # Magenta
	bldcyn='\e[1;36m' # Cyan
	bldwht='\e[1;37m' # White
	unkblk='\e[4;30m' # Black - Underline
	undred='\e[4;31m' # Red
	undgrn='\e[4;32m' # Green
	undylw='\e[4;33m' # Yellow
	undblu='\e[4;34m' # Blue
	undpur='\e[4;35m' # Magenta
	undcyn='\e[4;36m' # Cyan
	undwht='\e[4;37m' # White
	bakblk='\e[40m'   # Black - Background
	bakred='\e[41m'   # Red
	badgrn='\e[42m'   # Green
	bakylw='\e[43m'   # Yellow
	bakblu='\e[44m'   # Blue
	bakpur='\e[45m'   # Magenta
	bakcyn='\e[46m'   # Cyan
	bakwht='\e[47m'   # White
	txtrst='\e[0m'    # Text Reset
	bakrst='\e[m'     # Background Reset?

	if [ $COLORBACKGROUND -eq 1 ];then BackgroundColor=$bakblk;fi #$(tput il 1)
	ResetColor='\e[K'$txtrst #$(tput il 1)
	#`tput cup 0 1`
	TitleColor=$txtcyn$BackgroundColor
	DashLineColor=$txtred$BackgroundColor
	InfoColor=$txtblu$BackgroundColor
	WarnColor=$txtylw$BackgroundColor
	ErrorColor=$txtred$BackgroundColor
	DebugColor=$txtgrn$BackgroundColor
	TextFileColor=$txtylw$BackgroundColor
	ConfirmColor=$txtred$BackgroundColor
	ProgressColor=$txtpur$BackgroundColor
	SSHColor=$txtcyn$BackgroundColor
	#export TERM="xterm-256color"
}
ColorDia(){
	diablk='\Za\Z0'
	diared='\Za\Z1'
	diagrn='\Za\Z2'
	diaylw='\Za\Z3'
	diablu='\Za\Z4'
	diamgt='\Za\Z5'
	diacyn='\Za\Z6'
	diawht='\Za\Z7'
	diabldblk='\Zb\Z0'
	diabldred='\Zb\Z1'
	diabldgrn='\Zb\Z2'
	diabldylw='\Zb\Z3'
	diabldblu='\Zb\Z4'
	diabldmgt='\Zb\Z5'
	diabldcyn='\Zb\Z6'
	diabldwht='\Zb\Z7'
	diaundblk='\Zu\Z0'
	diaundred='\Zu\Z1'
	diaundgrn='\Zu\Z2'
	diaundylw='\Zu\Z3'
	diaundblu='\Zu\Z4'
	diaundmgt='\Zu\Z5'
	diaundcyn='\Zu\Z6'
	diaundwht='\Zu\Z7'
	diarevblk='\Zr\Z0'
	diarevred='\Zr\Z1'
	diarevgrn='\Zr\Z2'
	diarevylw='\Zr\Z3'
	diarevblu='\Zr\Z4'
	diarevmgt='\Zr\Z5'
	diarevcyn='\Zr\Z6'
	diarevwht='\Zr\Z7'
	diareset="\Zn"

	DiaInfoColor=$diareset$diablu
	DiaWarnColor=$diareset$diaylw
	DiaErrorColor=$diareset$diared
	DiaDebugColor=$diareset$diagrn
	DiaTextFileColor=$diareset$diaylw
}
ColorXDia(){
	xdiatxtblk='30' # Black - Regular
	xdiatxtred='31' # Red
	xdiatxtgrn='32' # Green
	xdiatxtylw='33' # Yellow
	xdiatxtblu='34' # Blue
	xdiatxtpur='35' # Magenta
	xdiatxtcyn='36' # Cyan
	xdiatxtwht='37' # White
	xdiabakblk='40' # Black - Background
	xdiabakred='41' # Red
	xdiabadgrn='42' # Green
	xdiabakylw='43' # Yellow
	xdiabakblu='44' # Blue
	xdiabakpur='45' # Magenta
	xdiabakcyn='46' # Cyan
	xdiabakwht='47' # White
	xdiatxtrst='38' # Default gtk theme
	xdiabakrst='48' # Default gtk theme

	if [ $COLORBACKGROUND -eq 1 ];then XDiaBackgroundColor=$xdiabakblk;fi
	XDiaInfoColor='\e[1;'$xdiatxtblu';'$XDiaBackgroundColor'm'
	XDiaWarnColor='\e[1;'$xdiatxtylw';'$XDiaBackgroundColor'm'
	XDiaErrorColor='\e[1;'$xdiatxtred';'$XDiaBackgroundColor'm'
	XDiaDebugColor='\e[1;'$xdiatxtgrn';'$XDiaBackgroundColor'm'
	XDiaTextFileColor='\e[1;'$xdiatxtylw';'$XDiaBackgroundColor'm'
}
Log(){
	touch '$LOGFILE'
	STATUS="$@"
	if [ $LOG ] && [ $LOG -gt 0 ];then Printne "[`date +%d/%m/%y-%H:%M:%S`] $STATUS" >> "$LOGFILE";fi
	return 4
}
Dialog(){
	DIASTATUS="$@"
	if [ $DIA -gt 0 ];then Printne "$DIASTATUS" >> $Dialog_log;fi
}
#TODO Multiline
MultiLineStatus(){
	firsttxt=$1
	shift;
	STATUS="$@"
	#STATUS=$firsttxt"$STATUS"'\n'
	#PrintE "$STATUS"
	result=''
	#STATUS=$firsttxt"$STATUS"
	#awk field \n
	#catch "\n"
}
#Printe $* # "$1 $2 $3 $4 ... $n"
#Printe $@ # "$1" "$2" "$3" "$4" ... "$n"
#Debug VERBOSE=3 Info VERBOSE=2 Warn VERBOSE=1 QUIET VERBOSE=0
InfGeneric(){
	firsttxt=''
	STATUS=''
	firsttxt=$1
	nb=$2
	shift;shift
	STATUS="$@"
	#MultiLineStatus "$firsttxt""$STATUS";result=''
	STATUS=$firsttxt"$STATUS"'\n'
	if [ $DIA -gt 0 ];then DIASTATUS=$XDiaColor$DiaColor"$STATUS";Dialog "$DIASTATUS";fi
	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ] && [ $nb -le $VERBOSE ];then  Printne "$InfColor";Printne "$STATUS";Printne "$ResetColor";fi
	Log "$STATUS"
}
Info(){
	InfColor=$InfoColor
	XDiaColor=$XDiaInfoColor
	DiaColor=$DiaInfoColor
	InfGeneric "[INFO]\t: " 2 "$*"
	return 0
}
Error(){
	InfColor=$ErrorColor
	XDiaColor=$XDiaErrorColor
	DiaColor=$DiaErrorColor
	InfGeneric "[ERROR]\t: " -1 "$*"
	exit 1
}
Warn(){
	InfColor=$WarnColor
	XDiaColor=$XDiaWarnColor
	DiaColor=$DiaWarnColor
	InfGeneric "[WARN]\t: " 1 "$*"
	return 2
}
Debug(){
	InfColor=$DebugColor
	XDiaColor=$XDiaDebugColor
	DiaColor=$DiaDebugColor
	InfGeneric "[DEBUG]\t: " 3 "$*"
	return 3
}
#CheckElement(){
#	if( test -a $1 );then return 0;else return 1;fi
#}
CheckElement(){
	if ( test -e $1 );then return 0;else return 1;fi
}
CheckDirectory(){
	if ( test -d $1 );then return 0;else return 1;fi
}
CheckFile(){
	if ( test -f $1 );then return 0;else return 1;fi
}
CheckLink(){
	if ( test -h $1 );then return 0;else return 1;fi
}
CheckRemoteSSH(){
	result=''
	result=`expr match "$1" "\(\w*[@]\)"`
	if [ "$result" != "" ];then return 0;else return 1;fi
}
#CheckPermission(){
#TODO
#Printe MSG="";
#}
CheckProgram(){
	checkreturn=''
	checkreturn=$(which "$1" 2>&1);if [ $? -eq 0 ];then return 0;else return 1;fi
}
Parity(){
	case $1 in
		*1|*3|*5|*7|*9) return 1;;
		*0|*2|*4|*6|*8) return 0;;
	esac
}
Negative(){
	case $1 in
		-*)return 0;;
		*) return 1;;
	esac
}
#TODO not enought Work with multiple match Not in used surcharched low time execute
#Index $substring $string return numeric index if found
Index(){
	str=''
	sub=''
	sub=$1
	shift
	str=$*;
	ind=''
	in=1;
	strlength=`expr length "$str"`;
	while [ $in -le $strlength ]
	do
		result=''
		result=`expr match "$str" "^\($sub\)"`
		if [ "$result" != "" ];then ind=$ind' '$in;fi
		RemoveFirstCharacter $str
		str=$result
		in=$(($in+1))
		if [ $in -eq $strlenght ];then ind=`echo $ind | sort -u`;Debug $ind;return 0;fi
	done
	result=''
	ind=''
	return 1
}
SubString(){
	result=''
	strresult=''
	string=''
	substring=''
	substring=$1
	shift
	string=$*;
	if [ "$string" != "" -a "$substring" != "" -a "$string" != "$substring" ];then
		Index $substring $string
		ind=$ind
		#Debug "Index: "$ind
		#Debug "subtring: $substring"
		#Debug "string: $string"
		strlength=`expr length "$string"`;
		sublength=`expr length "$substring"`;
		for index in $ind
		do
		if [ $index -eq 1 ] && [ $sublength -eq 1 ];then strresult=`expr substr "$string" 2 $strlength`;
		else
			rest=$(($index + $sublength))
			strresult=`expr substr "$string" 1 $(($index-1))`;
			strresult=$strresult`expr substr "$string" $rest $strlength`;
		fi
		string=$strresult
		Debug "string: "$string
		done
		result=$strresult;return 0
	else
		return 1
	fi
}
#Work with first match string not with multiple match
#Index $substring $string return numeric index if found
Index(){
	str=''
	sub=''
	sub=$1
	shift
	str=$*;
	ind=''
	in=1;
	strlength=`expr length "$str"`;
	while [ $in -le $strlength ]
	do
		result=''
		result=`expr match "$str" "^\($sub\)"`
		if [ "$result" != "" ];then ind=$ind' '$in;return 0;fi
		RemoveFirstCharacter $str
		str=$result
		in=$(($in+1))
	done
	result=''
	ind=''
	return 1
}
SubString(){
	result=''
	strresult=''
	string=''
	substring=''
	substring=$1
	shift
	string=$*;
	if [ "$string" != "" -a "$substring" != "" -a "$string" != "$substring" ];then
		Index $substring $string
		ind=$ind
		#Debug "Index: "$ind
		#Debug "subtring: $substring"
		#Debug "string: $string"
		strlength=`expr length "$string"`;
		sublength=`expr length "$substring"`;
		index=$ind
		if [ $index -eq 1 ] && [ $sublength -eq 1 ];then strresult=`expr substr "$string" 2 $strlength`;
		else
			rest=$(($index + $sublength))
			strresult=`expr substr "$string" 1 $(($index-1))`;
			strresult=$strresult`expr substr "$string" $rest $strlength`;
		fi
		result=$strresult;return 0
	else
		return 1
	fi
}
RealLinkPath(){
	result='';result=$(readlink -f $1);
}
GetFullPath(){
	initpath=''
	ele=''
	result=''
	initpath=`pwd`
	ele=$1
	case $ele in 
		*~*)
		SubString "~" $ele
    		ele=$(cd $HOME$result;pwd)
    	;;
    	esac
	CheckElement $ele
	if [ $? -eq 0 ]
	then
		CheckFile $ele
		if [ $? -eq 0 ]
		then
			directory=$(dirname $ele)
			file=$(basename $ele)
			result=$(cd $directory;pwd)\/$file;cd $initpath
			return 0
		fi
		CheckDirectory $ele
		if [ $? -eq 0 ]
		then
			result=$(cd $ele;pwd);cd $initpath
			return 0
		fi
	else
		return 1
	fi
}
GetRelativePath(){
	#TODO finish
	#basename dirname dirs
	initpath=''
	ele=''
	result=''
	initpath=`pwd`\/
	ele=$1
	shift
	currentpath=''
	targetpath=''
	frompath=$*
	ele=$(SubString $HOME $ele;'~'$result)
	Debug $initpath
	Debug $ele
	CheckElement $ele
	punct=$punct'../'
	root='/'
	if [ $? -eq 0 ]
	then
		CheckFile $ele
		if [ $? -eq 0 ]
		then
			SubString $initpath $ele
			Debug $result
			return 0
		fi
		CheckDirectory $ele
		if [ $? -eq 0 ]
		then
			SubString $initpath $ele
			Debug $result
			return 0
		fi
	else
		return 1
	fi
	#if ( test -d $1 );then result=`cd $1;pwd`;return 0;else return 1;fi
}
CheckArgs(){
	args=''
	result=''
	args=$1
	a=$(echo $args | cut -b1)
	if [ "$a" = "=" -o "$a" = ":" ];then result=$(echo $args | cut -b2-);return 1;else result=$args;return 0;fi
}
CheckResult(){
	if [ $? -eq 0 ]
	then
		MSG="$1 $2 $3"
		Info $MSG
	else
		MSG="$1 $2 $4"
		Error $MSG
	fi
}
#CheckList 'CheckProgram' $program_list
CheckList(){
	element=''
	elementavailable=''
	elementnotavailable=''
	checkreturn=''
	checkreturnavailable=''
	checkreturnnotavailable=''
	check=$1
	Debug "$check"
	shift
	if [ "$*" != "" ]
	then
		for element in `echo $*`;
		do
			eval $check $element
		if [ $? -eq 0 ]
		then
			elementavailable=$elementavailable' '$element
			checkreturnavailable=$checkreturnavailable','$checkreturn
		else
			elementnotavailable=$elementnotavailable' '$element
			checkreturnnotavailable=$checkreturnnotavailable','$checkreturn
		fi
		done
		return 0
	else
		return 1
	fi
}
CheckListResult(){
	if [ $? -eq 0 ]
	then
	element=''
	return=''
	Debug "Element available: "$elementavailable
	Debug "Element not available: "$elementnotavailable
		if [ "$elementavailable" != "" ];then
			i=1
			for element in `echo $elementavailable`;
			do
				i=$(($i+1))
				return=$(echo $checkreturnavailable | cut -d',' -f"$i")
				MSG=$1$element$2$return
				Debug $MSG
			done
		fi
		if [ "$elementnotavailable" != "" ];then
			i=1
			for element in `echo $elementnotavailable`;
			do
				i=$(($i+1))
				return=$(echo $checkreturnnotavailable | cut -d',' -f"$i")
				MSG=$1$element$3' '$return
				Warn $MSG
			done
				Error $4
		else
			Info $5
		fi
	else
		Error $6
	fi
}
#ListField `echo $line`
ListField(){
	a=''
	element=''
	result=''
	list=''
	if [ "$*" != "" ]
	then
		for element in `echo $*`;
		do
			if [ "$list" != "" ];then a=' ';fi
			list=$list$a$element
			shift
		done
		result=$list
		return 0
	else
		return 1
	fi
}
#GetByField nbfield `echo $line`
GetByField(){	
	result=''
	nb=$1
	shift "$nb"
	if [ $? -eq 0 ];
	then
		result=$1
		return 0
	else
		return 1
	fi
}
FinishWithSlash(){
	a='';a=$(echo $* | awk '{print(substr($0, length($0), length($0)))}')
	if [ "$a" = "/" ];then return 0;else return 1;fi
}
RemoveFirstCharacter(){
	result='';result=$(echo $* | awk '{print(substr($0, 2, length($0)))}')
}
RemoveLastCharacter(){
	result='';result=$(echo $* | awk '{print(substr($0, 1, length($0) - 1))}')
}
RemoveFirstStringFromList(){
	result=''
	shift
	if [ "$*" != "" ];then result=$*;return 0;else return 1;fi
}
RemoveLastStringFromList(){
	result=''
	list=''
	i=1
	if [ "$*" != "" ]
	then
		while [ $i -le $# ]
		do
			if [ $# -eq 1 ]
			then
				list=''
				result=$list
				return 0
			else
				list=$list$1
				i=$(($i + 1))
				shift
			fi
		done
		result=$list
		return 0
	else
		return 1
	fi
}
PrependStringToListElement(){
	list=''
	str=$1
	shift
	if [ "$*" != "" ];
	then
		for element in `echo $*`;
		do
			list=$list' '$str$element
		done
		result=$list
		return 0
	else
		return 1
	fi
}
SwapSize(){
	swap_total=$(awk 'BEGIN{ getline }{ print $3 }' /proc/swaps)
	swap_used=$(awk 'BEGIN{ getline }{ print $4 }' /proc/swaps)
	swap_total=$((${swap_total}/1024))
	swap_used=$((${swap_used}/1024))
	swap="${swap_used}M/${swap_total}M"
}
NbDisk(){
	result=''
	nbline=''
	nbline=`df -Hl | grep -vE '^Filesystem|tmpfs|cdrom|rootfs' | awk '{print NR}' | sort -n | sed -n '$p'`
	nbline=$(( $nbline - 1 ))
	result=$nbline
}
DiskSize(){ #TODO 
	result=''
	nb=$1
	result=`df -Hl | grep -vE '^Filesystem|tmpfs|cdrom|rootfs' | awk 'BEGIN{ getline }{ printf("%-20s%5s/%-5s%5s%s",$6,$3,$4,$5,"\n"); }' | head -n $nb | tail -n 1`
}
DetectResolution(){
	if [ -n $DISPLAY ]; then
		xresolution=$(xdpyinfo | sed -n 's/.*dim.* \([0-9]*x[0-9]*\) .*/\1/pg' | sed ':a;N;$!ba;s/\n/ /g')
	else
		xresolution="No X"
	fi
}
Memory(){ #TODO BUG WITH free bad value
	total_mem=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
	totalmem=$((${total_mem}/1024))
	if free | grep -q '/cache'; then
		used_mem=$(free | awk '/Mem:/ { print $3 }')
		usedmem=$((${used_mem}/1024))
	else
		free_mem=$(awk '/MemFree/ { print $2 }' /proc/meminfo)
		used_mem=$((${total_mem} - ${free_mem}))
		usedmem=$((${used_mem}/1024))
	fi
	mem="${usedmem}M/${totalmem}M"
}
UpTime(){
	uptime=$(cat /proc/uptime | awk  '{print $1}');
	centiuptime=$(echo $uptime | awk -F. '{print $2}');
	uptime=$(echo $uptime | awk -F. '{print $1}');
	secs=$((${uptime}%60))
	mins=$((${uptime}/60%60))
	hours=$((${uptime}/3600%24))
	days=$((${uptime}/86400))
	uptime="${mins}m${secs}s"
	if [ "${hours}" -ne "0" ]; then
		uptime="${hours}h${uptime}"
	fi
	if [ "${days}" -ne "0" ]; then
		uptime="${days}d${uptime}"
	fi
	uptime="${uptime}"
}
IdleTime(){
	idletime=$(cat /proc/uptime | awk  '{print $2}');
	nbcore=$(getconf _NPROCESSORS_ONLN)
	idletime=$(echo "scale=2; $idletime/$nbcore" | bc);
	#centiuptime=$(echo $idletime | awk -F. '{print $2}');
	idletime=$(echo $idletime | awk -F. '{print $1}');
	secs=$(($idletime%60))
	mins=$(($idletime/60%60))
	hours=$(($idletime/3600%24))
	days=$(($idletime/86400))
	idletime="${mins}m${secs}s"
	if [ "${hours}" -ne "0" ]; then
		idletime="${hours}h${idletime}"
	fi
	if [ "${days}" -ne "0" ]; then
		idletime="${days}d${idletime}"
	fi
	idletime="${idletime}"

}
LoadInformationBasic(){
	MYSCRIPTNAME=$SCRIPTNAME
	SYSTEM=$(uname -o)
	ARCH=$(uname -m)
	KERNEL=$(uname -r)
	NBCORE=$(getconf _NPROCESSORS_ONLN)
	MYHOSTNAME=$(hostname -s)
	MYUSER=$(whoami)
	MYTERM=$TERM
	MYSHELL=$(which $( ps hp $$ | awk '{print $5}' ) 2>&1) # remove one tiret from multiple su login
	MYHOME=$HOME
	MYLANG=$LANG
}
ShowInformationBasic(){
	Info 'SCRIPT='$MYSCRIPTNAME
	Info 'SYSTEM='$SYSTEM
	Info 'ARCH='$ARCH
	Info 'KERNEL='$KERNEL
	Info 'HOSTNAME='$MYHOSTNAME
	Info 'USER='$MYUSER
	Info 'TERM='$MYTERM
	Info 'SHELL='$MYSHELL
	Info 'HOME='$MYHOME
	Info 'LANG='$MYLANG
}
LoadInformation(){
	MYSCRIPTNAME=$SCRIPTNAME
	SYSTEM=$(uname -o)
	ARCH=$(uname -m)
	KERNEL=$(uname -r)
	PROCTYPE=$(awk -F':' '/model name/{ print $2 }' /proc/cpuinfo | head -n 1 | tr -s " " | sed 's/^ //')
	NBCORE=$(getconf _NPROCESSORS_ONLN)
	Memory;MEMORY=$mem;
	#SwapSize;SWAP=$swap
	NbDisk;nbdisk=$result;
	DetectResolution;RESOLUTION=$xresolution
	UpTime;UPTIME=$uptime
	IdleTime;IDLETIME=$idletime
	DISTRIBUTOR=$(lsb_release -si)
	DISTRIVERSION=$(lsb_release -sr)
	DISTRICODENAME=$(lsb_release -sc)
	MYHOSTNAME=$(hostname -s)
	MYUSER=$(whoami)
	MYTERM=$TERM
	MYSHELL=$(which $(ps hp $$ | awk '{print $5}') 2>&1)
	MYHOME=$HOME
	MYLANG=$LANG

}
ShowInformation(){
	Info 'SCRIPT='$MYSCRIPTNAME
	Info 'PROC='$PROCTYPE
	Info 'NBCORE='$NBCORE
	Info 'MEMORY='$MEMORY
	Info 'SWAP='$SWAP
	if [ "`uname`" = "Linux" ];then i=1;while [ $i -le $nbdisk ];do DiskSize $i;Info 'PARTITION='"$result";i=$(($i+1));done;fi
	Info 'RESOLUTION='$RESOLUTION
	Info 'SYSTEM='$SYSTEM
	Info 'DISTRIBUTOR='$DISTRIBUTOR
	Info 'VERSION='$DISTRIVERSION
	Info 'CODENAME='$DISTRICODENAME
	Info 'ARCH='$ARCH
	Info 'KERNEL='$KERNEL
	Info 'HOSTNAME='$MYHOSTNAME
	Info 'UPTIME='$UPTIME
	Info 'IDLETIME='$IDLETIME
	Info 'USER='$MYUSER
	Info 'TERM='$MYTERM
	Info 'SHELL='$MYSHELL
	Info 'HOME='$MYHOME
	Info 'LANG='$MYLANG
}
EndTime(){
	ENDDATE=$(date +%d/%m/%Y)
	ENDTIME=$(date +%s%N)
	ENDPTIME=$(date +%k:%M:%S)
	DIFFTIME=$(($ENDTIME - $STARTTIME))
	NANOTIME=`expr "$DIFFTIME" : "[0-9]*\([0-9]\{9\}$\)"`
	SEC=`expr "$DIFFTIME" : "\([0-9]*\)[0-9]\{9\}$"`
	if [ "$SEC" = "" ];then SEC=0;fi
	SECTIME=$(($SEC%60))
	MINTIME=$(($SEC/60%60))
	HOURTIME=$(($SEC/3600%24))
	DAYTIME=$(($SEC/86400))
	Info "Start Executed the $STARTDATE at $STARTPTIME and finish the $ENDDATE at $ENDPTIME"
	Info "Executed in $DAYTIME day(s) $HOURTIME hour(s) $MINTIME minute(s) $SECTIME second(s) and $NANOTIME nanosecond(s)"
}
#TODO test & asterix
Input(){
	password=$2
	text=$1
	return=''
	Printne "$ConfirmColor"
	Printne "$text"
	if [ $password -eq 1 ];then
		read -p answer
	else
		read answer
	fi
	Printne "$ResetColor"
	return=answer
}
retry=3
oneletter=1
nosensitive=1
Confirm(){
	#$1 Question $2 DefaultAccept $3 DefaultRefuse $4 Retry Question
	#Printe $1 $2 $3 $4
	#Printe $retry
	answer=""
	if [ $INTERACTIVE -eq 0 -o $DIA -gt 0 ];then return 1;fi
	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then
		#local answer
		Printne "$ConfirmColor"
		Printne "$1"
		read answer
		Printne "$ResetColor"
		#echo '' #for new line in log
		#printf '\r'
		if [ "$answer" != "" ];then
			if [ $nosensitive -eq 0 ];then
				answer=$answer
				defaultaccept=$2
				firstletterdefaultaccept=$(echo $defaultaccept | cut -b1)
				defaultrefused=$3
				firstletterdefaultrefused=$(echo $defaultrefused | cut -b1)
			else
				answer=$(echo $answer | tr "[:lower:]" "[:upper:]")
				defaultaccept=$(echo $2 | tr "[:lower:]" "[:upper:]")
				firstletterdefaultaccept=$(echo $defaultaccept | cut -b1)
				defaultrefused=$(echo $3 | tr "[:lower:]" "[:upper:]")
				firstletterdefaultrefused=$(echo $defaultrefused | cut -b1)	
			fi
			
        		if [ $oneletter = 1 ];then
				if [ $answer = $defaultaccept ] || [ $answer = $firstletterdefaultaccept ] || [ $answer = $defaultrefused ] || [ $answer = $firstletterdefaultrefused ];then
       					if [ $answer = $defaultaccept ] || [ $answer = $firstletterdefaultaccept ];then return 1
					else
						if [ $answer = $defaultrefused ] || [ $answer = $firstletterdefaultrefused ];then return 0;fi
					fi
				else
					if [ $retry -lt 1 ];then return 0;else retry=`expr $retry - 1`;Confirm "$4" "$2" "$3" "$4";fi
				fi
			else
				if [ $answer = $defaultaccept ] || [ $answer = $defaultrefused ];then
					if [ $answer = $defaultaccept ];then return 1;else
						if [ $answer = $defaultrefused ];then return 0;fi
					fi
				else
					if [ $retry -lt 1 ];then return 0;else retry=`expr $retry - 1`;Confirm "$4" "$2" "$3" "$4";fi
				fi
			fi
		else
			if [ $retry -lt 1 ];then return 0;else retry=`expr $retry - 1`;Confirm "$4" "$2" "$3" "$4";fi
		fi
	else
		return 0
	fi
}
#Center '\'$SCRIPTNAME'/'
Center(){
	title=$1
	nbcol=$(tput cols)
	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then printf "%*s\n" $(((${#title} + $nbcol) / 2)) "$title";fi
	if [ $LOG ] && [ $LOG -gt 1 ];then printf "%*s\n" $(((${#title} + $nbcol) / 2)) "$title" >> $LOGFILE;fi
}
DashLine(){
	line=""
	maxpatternlenght=2  #max pattern * 2 in real
	nbcol=$(tput cols)
	pattern=$1
	prepattern=$2
	postpattern=$3
	patternlenght=${#pattern}
	prepatternlenght=${#prepattern}
	postpatternlenght=${#postpattern}
	barlenght=$(( $nbcol - $prepatternlenght - $postpatternlenght ))
	nbpattern=$(echo "scale=0; $barlenght/$patternlenght" | bc)
	nbpatternfull=$(( $nbpattern * $patternlenght + 1 ))
	nbpatternrest=$(( $barlenght - $nbpatternfull + $maxpatternlenght ))
	
	#Debug $nbcol
	#Debug $barlenght
	#Debug $nbpattern
	#Debug $nbpatternfull
	#Debug $nbpatternrest
	
	line=$line"$prepattern"
	i=1
	while [ $i -lt $nbpatternfull ]
	do
		line=$line$pattern
		i=$(( $i + $patternlenght ))
	done
	i=1
	while [ $i -lt $nbpatternrest ]
	do
		p=$(echo $pattern | cut -b$i)
		line=$line$p
		i=$(( $i + 1 ))
	done
	line=$line"$postpattern"
}
#ShowDashLine '=#' '@' '@'
ShowDashLine(){
	DashLine "$1" "$2" "$3"
	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then Printne "$DashLineColor";Printe "$line";Printne "$ResetColor";fi
	if [ $LOG ] && [ $LOG -gt 1 ];then Printe "$line" >> $LOGFILE;fi
}
InsertLineGeneric(){
	line=$*
	col=$(echo $l | awk '{print NF}' | sort -n | sed -n '$p')
	nbcol=$(tput cols)
	nbcol=$(($nbcol/$col))
	echo $l | awk -F"/" '
	BEGIN{
		FS=" "
	}
	{	
		i = 1
            	while (i <= '$col') {
            		printf("%-'$nbcol's",$i);
            		i++;
                }
	}
	END {
	}'
}
PrintFileGeneric(){
	file=$1
	col=$(awk '{if ( NR > 0 && $0 !~ /^#/ && $0 != "" ) {print NF}}' $file | sort -n | sed -n '$p')
	nbcol=$(tput cols)
	nbcol=$(($nbcol/$col))
	awk -F"~" '
	BEGIN{
		FS=" "
		#ip='$ip'
	}
	{	
		if ( NR > 0 && $0 !~ /^#/ && $0 != "" ) {
			i = 1;
            		while (i <= '$col') {
            			printf("%-'$nbcol's",$i);
            			i++;
                	}
                	print("\r");
                }
	}
	END {
	}' $file
}
PrintFileInvertGeneric(){
	file=$1
	col=$(awk '{if ( NR > 0 && $0 !~ /^#/ && $0 != "" ) {print NF}}' $file | sort -n | sed -n '$p')
	nbcol=$(tput cols)
	nbcol=$(($nbcol/$col))
	awk -F"~" '
	BEGIN{
		FS=" "
	}
	{	if ( NR > 0 && $0 !~ /^#/ && $0 != "" ) {
			for (i=NF; i>0; i--) {
				printf("%-'$nbcol's",$i,OFS);
       			}
       			print("\r");
		}
	}
	END {
	}' $file
}
#PrintFile(){
#	DashLine "=" "@" "@"
#	file=$1
#	nbcol=$(tput cols)
#	nbcol=$(($nbcol/2))
#	awk -F"~" '
#	BEGIN{
#		FS=" "
#		print "'$line'"
#		#getline
#		size='$nbcol'/2
#		
#	}
#	{	
#		if ( NR == 1 && $0 !~ /^#/ && $0 != "" ) {
#			printf("%-'$nbcol's%-'$nbcol's\n",$1,$2)
#		}else{
#		if ( NR > 1 && $0 !~ /^#/ && $0 != "" ) {
#			printf("%-'$nbcol's%-'$nbcol's\n",$1,$2)
#		}
#		}
#	}
#	END {
#		print "'$line'"
#	}' $file
#}
#ShowFile(){
#	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then Info "ShowFile $1";Printne "$TextFileColor";DashLine "=" "@" "@";Printe $line;InsertLine `echo $1" SRC DEST"`;PrintFileGeneric $1;DashLine "=" "@" "@";Printe $line;Printne "$ResetColor";fi
#	if [ $LOG ] && [ $LOG -gt 1 ];then PrintFile $1 >> $LOGFILE;fi
#}
ShowFile(){
	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then Info "ShowFile $1";Printne "$TextFileColor";DashLine "=" "@" "@";Printe $line;PrintFileGeneric $1;DashLine "=" "@" "@";Printe $line;Printne "$ResetColor";fi
	if [ $LOG ] && [ $LOG -gt 1 ];then PrintFile $1 >> $LOGFILE;fi
}
#PrintFileInvert(){
#	DashLine "=" "@" "@"
#	file=$1
#	#Info "Show File $1"
#	nbcol=$(tput cols)
#	nbcol=$(($nbcol/2))
#	awk -F"~" '
#	BEGIN{
#		FS=" "
#		print "'$line'"
#		#getline
#		size='$nbcol'/2
#		
#	}
#	{	
#		if ( NR == 1 && $0 !~ /^#/ && $0 != "" ) {
#			printf("%-'$nbcol's%-'$nbcol's\n",$1,$2)
#		}else{
#		if ( NR > 1 && $0 !~ /^#/ && $0 != "" ) {
#			printf("%-'$nbcol's%-'$nbcol's\n",$2,$1)
#		}
#		}
#	}
#	END {
#		print "'$line'"
#	}' $file
#}
#ShowFileInvert(){
#	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then Info "ShowFile $1";Printne "$TextFileColor";DashLine "=" "@" "@";Printe $line;InsertLine `echo $1"  " SRC DEST"`;PrintFileInvertGeneric $1;DashLine "=" "@" "@";Printe $line;Printne "$ResetColor";fi
#	if [ $LOG ] && [ $LOG -gt 1 ];then PrintFile $1 >> $LOGFILE;fi
#}
ShowFileInvert(){
	if [ $VERBOSE ] && [ $VERBOSE -gt 0 ];then Info "ShowFile $1";Printne "$TextFileColor";DashLine "=" "@" "@";Printe $line;PrintFileInvertGeneric $1;DashLine "=" "@" "@";Printe $line;Printne "$ResetColor";fi
	if [ $LOG ] && [ $LOG -gt 1 ];then PrintFile $1 >> $LOGFILE;fi
}
CleanComment(){
	file=$1
	result=`awk '$0 !~ /^#/ {print $0}' $file`
	return 0
}
BuildCommand(){
	#TODO Test
	#set "$@"
	result=''
	str=''
	element=''
	CMD=$1;shift
	if [ "$*" != "" ];then
		for element in `echo $*`;
			do
				arg=$arg' '$str$element
			done
		#result=$arg
		return 0
	else
		return 1
	fi
	Debug "BuildCommand"
}
ConfFileModifyVarFromFile(){
	Debug "T"
	#TODO
}
GetOs() {
    case `uname` in
        'Linux')OS='linux';;
        'Darwin')OS='macos';;
       	CYGWIN*)OS='linux';;
       	*)OS='?';; 
    esac
    Debug "Os set to $OS"
}
StopByUser(){
	#finish
	#postfinish
	Info "Cancelled by User !"
	Printne "$ResetColor"
	Printne '\r'
	exit 4
}
TrapStopByUser(){
	Printne '\n'
	StopByUser
}
Init(){
	result=''
	COLORBACKGROUND=0
	if [ "$DIA" = "" ];then DIA=0;fi
	if [ $COLOR -eq 1 ];then Color;fi
	if [ $DIA -eq 2 ] && [ $COLOR -eq 1 ];then ColorDia;fi
	if [ $DIA -eq 4 ] && [ $COLOR -eq 1 ];then ColorXDia;fi
	#if [ $DIA -gt 0 ];then VERBOSE=1;fi
	log=$LOG;dia=$DIA;LOG=0;DIA=0
	CheckList 'CheckProgram' 'echo expr awk tr sed cut head tail sort bc hostname whoami uname lsb_release which ps readlink date getconf uname free' > /dev/null
	CheckListResult "Program " " is on the system at: " " is not on the system" "A Program not Found on System" "All Program Found" "List is empty" > /dev/null
	LOG=$log;DIA=$dia
	if [ "`uname`" = "Linux" ];then LoadInformation;fi
}
Init
