# Purpose #

Provide some useful settings and scripts to cleanup Fortran source
code so that it conforms to some coding style convention.

# How to Use #

Copy the script into `~/.emacs.d` and add the following line to
`~/.emacs`:

    (load "~/.emacs.d/fortran-style.el" nil nil t)

The command is run in a buffer containing a Fortran file via:

    M-x f90-cleanup-style
