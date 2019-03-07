# #!/bin/bash

echo "Checking in $PWD..."
OLDNAME="qazxswedcvfrtgbnhyumjkilop"
for entry in "$PWD"/*; do
    if [ -d "$entry" ]; then
        for entryInner in "$entry"/*; do
            if [ -d "$entryInner" ]; then
                FileCheck=$(basename $entryInner)
                if [[ "$FileCheck" == *"xcodeproj" ]]; then
                    OLDNAME=$(basename $FileCheck .xcodeproj)
                    break
                    break
                fi
            fi
        done
    fi
done

# Checking with initial name
if [ "$OLDNAME" == "qazxswedcvfrtgbnhyumjkilop" ]; then
    echo "No Project found..."
    exit 1
fi

#echo "Base Project name is: '$OLDNAME'"
echo "Please enter new project name"
read NEWNAMETempo

# Replace all the spaces from the new name with underscore, because using spaces is evil.
# NEWNAME=$(echo $1 | sed 's/ /_/g')
NEWNAME=${NEWNAMETempo// /_}
echo "Creating...: '$NEWNAME'"

# Setting system variables
LC_CTYPE=C
LANG=C

# Rename the root folder fo the project
mv "$OLDNAME" "$NEWNAME"
cd "$NEWNAME"

# Rename the folder with the source code
mv "$OLDNAME" "$NEWNAME"

# Rename the folder with the test code
#mv "${OLDNAME}Tests" "${NEWNAME}Tests"
#mv "${NEWNAME}Tests/${OLDNAME}Tests.m" "${NEWNAME}Tests/${NEWNAME}Tests.m"
#
## Rename the folder with the UITest code
#mv "${OLDNAME}UITests" "${NEWNAME}UITests"
#mv "${NEWNAME}UITests/${OLDNAME}UITests.m" "${NEWNAME}UITests/${NEWNAME}UITests.m"

# Renamte the xcodeproject file.
mv "${OLDNAME}.xcodeproj" "${NEWNAME}.xcodeproj"

# Rename the shared scheme
# Not needed for Now
#mv "${NEWNAME}.xcodeproj/xcshareddata/xcschemes/${OLDNAME}.xcscheme" "${NEWNAME}.xcodeproj/xcshareddata/xcschemes/${NEWNAME}.xcscheme"

# Rename the shared scheme for swift
# Not needed for Now
#mv "${NEWNAME}.xcodeproj/xcuserdata/iosdev.xcuserdatad/xcschemes/${OLDNAME}.xcscheme" "${NEWNAME}.xcodeproj/xcuserdata/iosdev.xcuserdatad/xcschemes/${NEWNAME}.xcscheme"

# Rename the 'OLDNAME-Bridging-Header' file for swift
mv "${NEWNAME}/config/${OLDNAME}-Bridging-Header.h" "${NEWNAME}/config/${NEWNAME}-Bridging-Header.h"

# Rename the 'OLDNAME.xcdatamodeld' file for coreData
#mv "${NEWNAME}/${OLDNAME}.xcdatamodeld" "${NEWNAME}/${NEWNAME}.xcdatamodeld"
#mv "${NEWNAME}/${NEWNAME}.xcdatamodeld/${OLDNAME}.xcdatamodel" "${NEWNAME}/${NEWNAME}.xcdatamodeld/${NEWNAME}.xcdatamodel"

# Rename the 'OLDNAME.xcworkspace' file for cocoapods
#mv "${OLDNAME}.xcworkspace" "${NEWNAME}.xcworkspace"

# For each file inside the folder, replace the default title with the new one.
find . -type f -print0 | xargs -0 sed -i '' "s/${OLDNAME}/${NEWNAME}/g"
echo "Operation completed."

echo "Opening project directory..."
open .
cd ..
rm -- "$0"
