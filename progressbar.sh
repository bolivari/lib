#!/bin/sh
#PreloadProgressBar '#=@' ' [' '] ' '._$';ProgressBarAnimate '0' '100';
ProgressBarAnimate(){
	start=$1
	end=$2
	speed=1
	o=$start
	while [ $o -le $end ]
	do
		ProgressBar "$o"
		o=$(( $o + $speed ))
		#sleep 0.5
	done
}
FlushPattern(){
	patternloaded1=''
	patternloaded2=''
	patternloaded3=''
	pattern=''
	prepattern=''
	postpattern=''
	emptypattern=''
}
LoadPattern(){
	set -o noglob
	spe=1
	patternloaded=''
	patternload=$1
	patternlenghtload=${#patternload}
	while [ $spe -le $patternlenghtload ];
	do
		sub=`expr substr $patternload $spe 1`
		patternloaded=$patternloaded' '"$sub"
		spe=$(( $spe + 1 ))
	done
	if [ "$patternloaded1" = "" ]
	then
		patternloaded1=$patternloaded
	else
		if [ "$patternloaded2" = "" ]
		then
			patternloaded2=$patternloaded
		else
			patternloaded3=$patternloaded
		fi
	fi
}
GetCharPattern(){
	char=''
	pattern=''
	ir=1
	position=$1
	position=${1%%' '*}
	pattern=$*
	pattern=${pattern#*' '}
	#echo $position
	#echo $*
	#echo $#
	#echo $pattern
	
	#echo $@ $ir $position
	#shift
	while [ $ir -lt $position ]
	do
		#shift
		pattern=${pattern#*' '}
		ir=$(( $ir + 1 ))
	done
	#echo $pattern
	result=${pattern%%' '*}
	#echo $result
	#char=$1
	char=$result
}
PreloadProgressBar(){
	FlushPattern

	LoadPattern $1
	pattern=$1
	prepattern=$2
	postpattern=$3
	emptypattern=$4
	LoadPattern $4
	
	nbcol=$(tput cols)
	patternlenght=${#pattern}
	emptypatternlenght=${#emptypattern}
	prepatternlenght=${#prepattern}
	postpatternlenght=${#postpattern}

	patterndiff=$(echo "scale=0; sqrt(($patternlenght-$emptypatternlenght)^2)" | bc)
	percentlenght=4
	barlenght=$(( $nbcol - ($prepatternlenght * 2) - ($postpatternlenght * 2) - $percentlenght ))
}
ProgressBar(){
	i=0
	sp=1
	ep=1
	line=""
	p=""
	percent=$1
	barpercent=$(( $barlenght * $percent / 100 ))
	#echo $barpourcent
	#barrest=$(( $barlenght - $barpourcent ))
	#echo $barrest
	#substr to list
	printf '\r'
	line="$line""$prepattern"
	percent=$(printf "%03d" "$percent")
	line="$line""$percent""%%"
	line="$line""$postpattern"
	line="$line""$prepattern"
	while [ $i -lt $barlenght ]
	do
		if [ $i -le $barpercent ]
		then
			if [ $i -eq $barpercent ];then ep=$sp;fi
			if [ $sp -gt $patternlenght ];then sp=1;fi
			GetCharPattern $sp$patternloaded1
			#echo $char
			#sub=`expr substr $pattern $sp 1`
			#sub=$pattern
			p=$p$char
			sp=$(( $sp + 1 ))
			i=$(( $i + 1 ))
			
		else
			if [ $ep -gt $emptypatternlenght ];then ep=1;fi
			GetCharPattern $ep$patternloaded2
			p=$p$char
			ep=$(( $ep + 1 ))
			i=$(( $i + 1 ))
		fi
	done
	line="$line""$p"
	line="$line""$postpattern"
	#tput cup 19 0
	Printne "$ProgressColor"
	printf "$line"
	Printne "$ResetColor"
}
###############################################################################################
ProgressBar2(){
	i=1
	sp=1
	ep=1
	line=""
	p=""
	
	pourcent=$5
	barpourcent=$(( $barlenght * $pourcent / 100 + 1 ))
	
	nbpattern=$(echo "scale=0; $barlenght/$patternlenght" | bc)
	nbpatternfull=$(( $nbpattern * $patternlenght ))
	nbpatternrest=$(( $barlenght - $nbpatternfull ))
	nbemptypattern=$(echo "scale=0; $barlenght/$emptypatternlenght" | bc)
	nbemptypatternfull=$(( $nbemptypattern * $emptypatternlenght ))
	nbemptypatternrest=$(( $barlenght - $nbemptypatternfull ))
	
	nbprogresspattern=$(echo "scale=0; $barpourcent/$patternlenght" | bc)
	nbprogresspatternfull=$(( $nbprogresspattern * $patternlenght ))
	nbprogresspatternrest=$(( $barpourcent - $nbprogresspatternfull ))
	nbprogessemptypatternrest=$(( $barlenght - $nbprogresspatternfull - $nbprogresspatternrest ))
	
	printf '\r'
	line=$line"$prepattern"
	while [ $i -le $barlenght ]
	do
		if [ $i -le $barpourcent ]
		then
			if [ $barpourcent -gt $patternlenght ]
			then
				if [ $nbprogresspatternrest -ne 0 ]
				then
					if [ $sp -gt $patternlenght ];then sp=1;fi
					#p=$(echo $pattern | cut -b$ip)
					#sub=`expr substr $pattern $ip 1`
					GetCharPattern $sp$patternloaded1
					line=$line"$char"
					sp=$(( $sp + 1 ))
					i=$(( $i + 1 ))
				
				else
					line=$line"$pattern"
					i=$(( $i + $patternlenght ))
				fi
			else
				
				#p=$(echo $pattern | cut -b$i)
				#sub=`expr substr $pattern $i 1`
				GetCharPattern $i$patternloaded1
				line=$line"$char"
				i=$(( $i + 1 ))
			fi
		else
			if [ $nbprogessemptypatternrest -ne 0 ]
			then
				if [ $ep -gt $emptypatternlenght ];then ep=1;fi
				#p=$(echo $emptypattern | cut -b$ip)
				#sub=`expr substr $emptypattern $ep 1`
				GetCharPattern $ep $patternloaded2
				line=$line"$char"
				ep=$(( $ep + 1 ))
				i=$(( $i + 1 ))
				
			else
				line=$line$emptypattern
				i=$(( $i + $emptypatternlenght ))
			fi
		fi
	done
	line=$line"$postpattern"
	printf "$line"
}

