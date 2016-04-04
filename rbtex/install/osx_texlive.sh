# TODO -- add support for zsh, sh

#The install script for os x

STY_URL="https://raw.githubusercontent.com/RubyLatex/RbTeX/master/rbtex/dist/ctan/rubylatex/rubylatex.sty"
TEXT_ONE="This program puts things where your TeX distribution is located."
TEXT_TWO="This sometimes requires root access. Please run this command again as root."
TEXT_THREE="We promise to be nice while we are there!"

DIR_NAME="rubylatex"

if [ "$EUID" -ne 0 ] ; then                                     #check that the user is running in root
    echo $TEXT_ONE
    echo $TEXT_TWO
    echo $TEXT_THREE
    exit
fi

cd /usr/                                                        #TeX dist is usually under /usr/
TEX_LOC=$(sudo find . -name "article.cls" -print)               #find the location of the TeX installation
TEX_LOC_REAL="${TEX_LOC%/*}"                                    #remove the "/article.cls"
TEX_LOC_REAL="${TEX_LOC_REAL%/*}"                               #remove the article directory
echo "Found TeX Live packages installed at $TEX_LOC_REAL"
cd "$TEX_LOC_REAL"                                              #cd to the TeX packages dir
sudo mkdir "$DIR_NAME"                                          #create the rbtex dir
cd "$DIR_NAME"                                                  #in case the dir already existed
sudo rm -f *                                                    #remove everything from the dir
$(curl -L "$STY_URL" -o "$DIR_NAME.sty")                        #grab the .sty file content
sudo mktexlsr                                                   #refresh the texlive dist

echo "LaTeX files installed correctly... moving to Ruby"

sudo gem install rbtex                                          #install the rbtex package

echo "Thank you for installing RbTeX!"
echo "Don't forget to restart your Terminal"
