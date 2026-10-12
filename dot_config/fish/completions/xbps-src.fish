# Completions for void-packages' ./xbps-src. fish ships them for every other
# xbps tool.

# The checkout being worked in: the nearest one above $PWD, else the usual place.
function __xbps_src_distdir
    set -l dir $PWD
    while test "$dir" != /
        if test -x $dir/xbps-src -a -d $dir/srcpkgs
            echo $dir
            return
        end
        set dir (path dirname $dir)
    end
    test -d ~/dev/void-packages/srcpkgs; and echo ~/dev/void-packages
end

function __xbps_src_pkgs
    set -l dist (__xbps_src_distdir); or return
    path basename $dist/srcpkgs/*
end

function __xbps_src_archs
    set -l dist (__xbps_src_distdir); or return
    path change-extension '' (path basename $dist/common/cross-profiles/*.sh)
end

# Targets that take a package name
set -l pkg_targets fetch extract patch configure build check install pkg \
    clean remove show show-avail show-build-deps show-check-deps show-deps \
    show-files show-hostmakedepends show-makedepends show-options \
    show-shlib-provides show-shlib-requires sort-dependencies update-check
set -l other_targets binary-bootstrap bootstrap bootstrap-update \
    consistency-check chroot clean-repocache list remove-autodeps \
    purge-distfiles show-var show-repo-updates show-sys-updates \
    show-local-updates update-bulk update-sys update-local update-hash-cache zap
set -l no_target "not __fish_seen_subcommand_from $pkg_targets $other_targets"

complete -c xbps-src -f
complete -c xbps-src -n "__fish_seen_subcommand_from $pkg_targets" -a "(__xbps_src_pkgs)"

complete -c xbps-src -n $no_target -a binary-bootstrap -d "Install bootstrap packages from host repositories"
complete -c xbps-src -n $no_target -a bootstrap -d "Build the bootstrap packages from source"
complete -c xbps-src -n $no_target -a bootstrap-update -d "Update bootstrap packages"
complete -c xbps-src -n $no_target -a consistency-check -d "Check all packages for consistency"
complete -c xbps-src -n $no_target -a chroot -d "Enter the masterdir chroot"
complete -c xbps-src -n $no_target -a clean-repocache -d "Remove obsolete packages from the repocache"
complete -c xbps-src -n $no_target -a fetch -d "Download the source distfiles"
complete -c xbps-src -n $no_target -a extract -d "Extract the distfiles into the build directory"
complete -c xbps-src -n $no_target -a patch -d "Patch the sources"
complete -c xbps-src -n $no_target -a configure -d "Run up to the configure stage"
complete -c xbps-src -n $no_target -a build -d "Run up to the build stage"
complete -c xbps-src -n $no_target -a check -d "Run the package checks after building"
complete -c xbps-src -n $no_target -a install -d "Install into destdir without packaging"
complete -c xbps-src -n $no_target -a pkg -d "Build the binary package and its dependencies"
complete -c xbps-src -n $no_target -a clean -d "Remove autodeps, builddir and destdir"
complete -c xbps-src -n $no_target -a list -d "List packages installed in masterdir"
complete -c xbps-src -n $no_target -a remove -d "Remove the package from destdir"
complete -c xbps-src -n $no_target -a remove-autodeps -d "Remove automatically installed dependencies"
complete -c xbps-src -n $no_target -a purge-distfiles -d "Remove obsolete distfiles"
complete -c xbps-src -n $no_target -a show -d "Show package information"
complete -c xbps-src -n $no_target -a show-avail -d "Succeed if the package can be built for the architecture"
complete -c xbps-src -n $no_target -a show-build-deps -d "Show build dependencies"
complete -c xbps-src -n $no_target -a show-check-deps -d "Show check dependencies"
complete -c xbps-src -n $no_target -a show-deps -d "Show run-time dependencies"
complete -c xbps-src -n $no_target -a show-files -d "Show files installed by the package"
complete -c xbps-src -n $no_target -a show-hostmakedepends -d "Show host build dependencies"
complete -c xbps-src -n $no_target -a show-makedepends -d "Show target build dependencies"
complete -c xbps-src -n $no_target -a show-options -d "Show the package's build options"
complete -c xbps-src -n $no_target -a show-shlib-provides -d "Show provided shlibs"
complete -c xbps-src -n $no_target -a show-shlib-requires -d "Show required shlibs"
complete -c xbps-src -n $no_target -a show-var -d "Print an xbps-src variable"
complete -c xbps-src -n $no_target -a show-repo-updates -d "List outdated packages in the repositories"
complete -c xbps-src -n $no_target -a show-sys-updates -d "List outdated packages on this system"
complete -c xbps-src -n $no_target -a show-local-updates -d "List outdated packages in local repositories"
complete -c xbps-src -n $no_target -a sort-dependencies -d "Sort the given packages by dependency order"
complete -c xbps-src -n $no_target -a update-bulk -d "Rebuild outdated packages in the system repositories"
complete -c xbps-src -n $no_target -a update-sys -d "Rebuild and update outdated system packages"
complete -c xbps-src -n $no_target -a update-local -d "Rebuild outdated packages in local repositories"
complete -c xbps-src -n $no_target -a update-check -d "Check upstream for new releases"
complete -c xbps-src -n $no_target -a update-hash-cache -d "Update the hash cache from existing distfiles"
complete -c xbps-src -n $no_target -a zap -d "Remove a masterdir, keeping ccache and hostdir"

complete -c xbps-src -s 1 -d "Fail if dependencies are missing instead of building them"
complete -c xbps-src -s A -x -a "(__xbps_src_archs)" -d "Use this host machine"
complete -c xbps-src -s a -x -a "(__xbps_src_archs)" -d "Cross compile for this target"
complete -c xbps-src -s b -d "Build even if broken, nocross or excluded by archs"
complete -c xbps-src -s c -x -d "Use etc/conf.<configuration>"
complete -c xbps-src -s C -d "Keep builddir, autodeps and destdir after install"
complete -c xbps-src -s E -d "Exit if a binary package exists in any repository"
complete -c xbps-src -s e -d "Exit if a binary package exists in a local repository"
complete -c xbps-src -s f -d "Force the stage even if it already ran"
complete -c xbps-src -s G -d "Enable XBPS_USE_GIT_REVS"
complete -c xbps-src -s g -d "Build -dbg packages"
complete -c xbps-src -s H -x -a "(__fish_complete_directories)" -d "Host directory"
complete -c xbps-src -s h -d "Show usage"
complete -c xbps-src -s I -d "Ignore required dependencies"
complete -c xbps-src -s i -d "Make internal errors non-fatal"
complete -c xbps-src -s j -x -d "Parallel build jobs"
complete -c xbps-src -s L -d "Disable colours"
complete -c xbps-src -s m -x -a "(__fish_complete_directories)" -d "Master directory"
complete -c xbps-src -s N -d "Do not use remote repositories for dependencies"
complete -c xbps-src -s n -d "Do not sync remote repositories"
complete -c xbps-src -s o -x -d "Enable or disable (~) build options"
complete -c xbps-src -s p -x -d "Extra variables for the show target"
complete -c xbps-src -s Q -d "Run the check stage for the target package"
complete -c xbps-src -s K -d "Run the check stage with longer tests"
complete -c xbps-src -s q -d "Suppress xbps-src's own output"
complete -c xbps-src -s r -x -d "Alternative local repository"
complete -c xbps-src -s s -d "Turn some warnings into errors"
complete -c xbps-src -s t -d "Build in a temporary masterdir"
complete -c xbps-src -s v -d "Verbose messages"
complete -c xbps-src -s V -d "Print the xbps version"
