#!/bin/sh

EnvQA="44737";
EnvProd="66432";
EnvPS13="66434";
EnvSBQA="46740";
EnvTest="test";

#Host="rsync-hp.wscdns.com";
#User="palmqa";
#Pwd="palmqa123";

Host="192.168.1.2";
User="zhaoqy";
Pwd="111111";

Mode="--verbose";
export RSYNC_PASSWORD=${Pwd}
OPTS="${Mode} --checksum --archive --timeout=60 --progress"

while [ "$1" != "" ];
do case $1
   in
   -env) if [ "$2" = "qa" ];
       then envpath=$EnvQA;
       elif [ "$2" = "prod" ];
       then envpath=$EnvProd;
       elif [ "$2" = "ps13" ];
       then envpath=$EnvPS13;
       elif [ "$2" = "sbqa" ];
       then envpath=$EnvSBQA;
       elif [ "$2" = "test" ];
       then envpath=$EnvTest;
       fi
       shift 2;;
   -srcpath) srcpath=$2;
       shift 2;;
   -destpath) destpath=$2;
       shift 2;;
   -help) echo "Usage: $0 -env <qa|prod> -srcpath <path_of_ipk> -destpath <destination_of_app>"
       exit 0;;
   *) echo "Usage: $0 -env <qa|prod> -srcpath <path_of_ipk> -destpath <destination_of_app>"
      exit 1;;
   esac
done

if [ "$srcpath" = "" ]; then
    echo "Missing parameter -srcpath";
    missingParams=1;
fi
if [ "$destpath" = "" ]; then
    echo "Missing parameter -destpath";
    missingParams=1;
fi
if [ "$envpath" = "" ]; then
    echo "Missing parameter -env";
    missingParams=1;
fi
if [ "$missingParams" = "1" ]; then
    exit 1;
fi

#OPTS="${Mode} --list-only"

#rsync --list-only --password-file=pwdfile palmqa@palmesd.upload.akamai.com::palmqa/44737
CMD="rsync ${OPTS} ${srcpath} ${User}@${Host}::${User}/${envpath}/${destpath}"
echo $CMD
$CMD
