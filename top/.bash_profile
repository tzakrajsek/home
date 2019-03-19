# .bash_profile : See .bashrc for details.

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH

# added by Miniconda2 4.1.11 installer
#export PATH="/usr/local/develop/miniconda2/bin:$PATH"

# added by Anaconda3 4.2.0 installer
export PATH="/usr/local/develop/anaconda/bin:$PATH"

##
# Your previous /Users/tomz/.bash_profile file was backed up as /Users/tomz/.bash_profile.macports-saved_2016-11-10_at_13:09:44
##

# MacPorts Installer addition on 2016-11-10_at_13:09:44: adding an appropriate PATH variable for use with MacPorts.
#export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# MacPorts Installer addition on 2016-11-18_at_22:08:46: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


. ~/.bashrc


# added by Anaconda2 4.2.0 installer
export PATH="/usr/local/develop/anaconda/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
