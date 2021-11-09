#!/bin/sh -l

target=$1
builddir=$2
pkgname=$3
command=$4

# '/github/workspace' is mounted as a volume and has owner set to root
# set the owner to the 'build' user, so it can access package files
sudo chown -R build /github/workspace /github/home

# assumes that package files are in a subdirectory
# of the same name as "pkgname", so this works well
# with "aurpublish" tool
cd "$builddir" || exit

case $target in
    pkgbuild)
        namcap PKGBUILD
        install_deps
        PKGEXT='.pkg.tar' makepkg --syncdeps --noconfirm
        namcap "${pkgname}"-*.pkg.tar
        ;;
    srcinfo)
        makepkg --printsrcinfo | diff .SRCINFO - || \
            { echo ".SRCINFO is out of sync. Please run 'makepkg --printsrcinfo' and commit the changes."; false; }
        ;;
    *)
      echo "Target should be one of 'pkgbuild', 'srcinfo'" ;;
esac
