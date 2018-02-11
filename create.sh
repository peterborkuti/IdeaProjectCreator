#!/bin/bash
OUTDIR=`pwd`
MYDIR=`dirname $0`
TEMPLATEDIR=${MYDIR}/template

echo $OUTDIR
echo $MYDIR

if [ "$OUTDIR" == "$MYDIR" -o "$MYDIR" == "." ]; then
    echo "Run it from your IDEA's project dir but never from Creator's dir!"
    exit;
fi

PROJECTNAME=${1:-MyProject${RANDOM}}
CLASSNAME=${2:-MyClass}

echo $PROJECTNAME
echo $CLASSNAME

OUTDIR=${OUTDIR}/${PROJECTNAME}
mkdir -p $OUTDIR/.idea
mkdir -p $OUTDIR/src

cd $OUTDIR/.idea
cp $TEMPLATEDIR/.idea/* .

cat $TEMPLATEDIR/.idea/modules.xml|sed -e "s/\${IJ_PROJECT_NAME}/${PROJECTNAME}/g" > modules.xml

cd $OUTDIR/src
cat $TEMPLATEDIR/src/Main.java|sed -e "s/\${IJ_PROJECT_NAME}/${CLASSNAME}/g" > Main.java
cat $TEMPLATEDIR/src/MyClass.java|sed -e "s/\${IJ_PROJECT_NAME}/${CLASSNAME}/g" > "${CLASSNAME}.java"
cat $TEMPLATEDIR/src/MyClassTest.java|sed -e "s/\${IJ_PROJECT_NAME}/${CLASSNAME}/g" > "${CLASSNAME}Test.java"

cd $OUTDIR
cp ${TEMPLATEDIR}/ProjectX.iml ${PROJECTNAME}.iml