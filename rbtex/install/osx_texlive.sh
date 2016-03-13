#The install script for os x

#check that the user is running in root
if [ "$EUID" -ne 0 ] ; then
    echo "This program puts things where your TeX distribution is located."
    echo "This sometimes requires root access. Please run this command again as root."
    echo "We promise to be nice while we are there!"
    exit
fi

git clone https://github.com/RubyLatex/RbTeX.git                #clone the repo's most stable release
OG_DIR="$(pwd)/RbTeX"                                           #we don't want to forget where we are

cd /usr/                                                        #TeX dist is usually under /usr/
TEX_LOC=$(sudo find . -name "article.cls" -print)               #find the location of the TeX installation
TEX_LOC_REAL="${TEX_LOC%/*}"                                    #remove the "/article.cls"
echo "Found TeX Live packages installed at $TEX_LOC_REAL"
cd "$TEX_LOC_REAL"                                              #cd to the TeX installation
sudo mkdir "rbtex"                                              #create the rbtex dir
cd "rbtex"                                                      #in case the dir already existed
sudo rm -f *                                                    #remove everything from the dir
TEX_LOC_REAL="$TEX_LOC_REAL/rbtex"                              #append the rbtex dir to TeX location

cd "$OG_DIR/RbTeX/dist"                                         #cd into the dist directory
sudo mv "rubylatex.dtx" "$TEX_LOC_REAL"                         #move the .dtx file
sudo mv "rubylatex.sty" "$TEX_LOC_REAL"                         #move the .sty file
sudo mv "rblatex" "$TEX_LOC_REAL"                               #move the rblatex program
echo "Done installing LaTeX side. Moving on to Ruby."

sudo gem install rbtex                                          #install the rbtex gem

cd ~                                                            #move back to the home directory
touch .bash_profile
RBT="rblatex"
RBTEX="$TEX_LOC_REAL$RBT"
echo "\n# RbTeX alias\nalias rblatex=\"$RBTEX\"" >> .bash_profile

cd "$OG_DIR"
rm -rf "RbTeX"
