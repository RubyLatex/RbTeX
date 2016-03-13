#The install script for os x

#check that the user is running in root
if [ "$EUID" -ne 0 ] ; then
    echo "This program puts things where your TeX distribution is located."
    echo "This sometimes requires root access. Please run this command again as root."
    echo "We promise to be nice while we are there!"
    exit
fi

git clone https://github.com/RubyLatex/RbTeX.git                #clone the repo's most stable release
OG_DIR="$(pwd)"                                                 #we don't want to forget where we are

cd /usr/                                                        #TeX dist is usually under /usr/
TEX_LOC=$(sudo find . -name "article.cls" -print)               #find the location of the TeX installation
TEX_LOC_REAL="${TEX_LOC%/*}"                                    #remove the "/article.cls"
TEX_LOC_REAL="${TEX_LOC_REAL%/*}"                               #remove the article directory
echo "Found TeX Live packages installed at $TEX_LOC_REAL"
cd "$TEX_LOC_REAL"                                              #cd to the TeX packages dir
sudo mkdir "rbtex"                                              #create the rbtex dir
cd "rbtex"                                                      #in case the dir already existed
sudo rm -f *                                                    #remove everything from the dir
TEX_LOC_REAL="~/../../usr/$TEX_LOC_REAL/rbtex"                  #append the rbtex dir to TeX location

cd "$OG_DIR/RbTeX/rbtex/dist"                                   #cd into the dist directory
sudo bash -c "cp './rubylatex.dtx' $TEX_LOC_REAL"               #move the .dtx file
sudo bash -c "cp './rubylatex.sty' $TEX_LOC_REAL"               #move the .sty file
sudo bash -c "cp './rblatex' $TEX_LOC_REAL"                     #move the rblatex program
cd ~/../../usr/
cd "${TEX_LOC%/*}"                                              #cd into the rbtex dir
cd ..
cd rbtex
sudo chmod 755 rblatex                                          #make rblatex executable
echo "Done installing LaTeX side. Moving on to Ruby."

sudo gem install rbtex                                          #install the rbtex gem

cd ~
touch .bash_profile                                             #ensure the .bash_profile exists
RBT="rblatex"
RBTEX="$TEX_LOC_REAL/$RBT"
BP_A="# RbTeX alias"
BP_B="alias rblatex=\"$RBTEX\""

# TODO -- Fix sed usage

sudo sed -i -e "/$BP_A/d" "~/.bash_profile"                     #remove the existing rbtex alias
sudo sed -i -e "/$BP_B/d" "~/.bash_profile"                     #remove the existing rbtex alias
echo "\n$BP_A\n$BP_B" >> .bash_profile                          #make an alias in the bash_profile

cd "$OG_DIR"
rm -rf "RbTeX"
