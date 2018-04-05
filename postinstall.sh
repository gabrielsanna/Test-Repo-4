#!/bin/bash

# Function to decrypt strings
function DecryptString()
{
    echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
}

install_dir=`dirname $0`

# Execute component packages
/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"MW Default User Template.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"NISfree-bind.pkg" -target "$3"

# Enable root user
mString=$(DecryptString U2FsdGVkX19hFjYRTMkR1dAGmmBgZ3Tek5IgijHovM0= 611636114cc911d5 c190078e55d0ecf178095187)
rString=$(DecryptString U2FsdGVkX18Cg2Xkw+qXgaeZMcLqanuQMGu4geHeNdI= 028365e4c3ea9781 831c6ce10aadc6e80da0b6d8)

/usr/sbin/dsenableroot -u mw_admin -p "${mString}" -r "${rString}"

# Run JAMF recon
/usr/local/bin/jamf recon

exit 0