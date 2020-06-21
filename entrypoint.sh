#!/bin/sh -l

target=$1
pkgname=$2
command=$3

# '/github/workspace' is mounted as a volume and has owner set to root
# set the owner to the 'build' user, so it can access package files
sudo chown -R build /github/workspace /github/home

install_deps() {
    # install make and regular package dependencies
    grep -E 'depends|makedepends' PKGBUILD | \
        sed -e 's/.*depends=//' -e 's/ /\n/g' | \
        tr -d "'" | tr -d "(" | tr -d ")" | \
        xargs yay -S --noconfirm
}

case $target in
    pkgbuild)
        namcap PKGBUILD
        install_deps
        PKGEXT='.pkg.tar' makepkg --syncdeps --noconfirm
        namcap "${pkgname}"-*.pkg.tar
        ;;
    run)
        install_deps
        PKGEXT='.pkg.tar' makepkg --syncdeps --noconfirm --install
        eval "$command"
        ;;
    srcinfo)
        makepkg --printsrcinfo | diff .SRCINFO - || \
            { echo ".SRCINFO is out of sync. Please run 'makepkg --printsrcinfo' and commit the changes."; false; }
        ;;
    *)
      echo "Target should be one of 'pkgbuild', 'srcinfo', 'run'" ;;
esac
