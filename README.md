HTML FILE COMPLETION
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin offers insert mode file completion for HTML links to local files,
taking into account a base directory (document root) and base URL (web server
location) to enable completion of absolute (/foo...) and fully qualified
(http://host/foo...) links.

### RELATED WORKS

- FilePathConvert.vim ([vimscript #4885](http://www.vim.org/scripts/script.php?script_id=4885)) converts filespecs between absolute,
  relative, and URL (file://) formats.

USAGE
------------------------------------------------------------------------------

    CTRL-X CTRL-F           Find matches for file names that start with the same
                            'isfname' characters as before the cursor. File names
                            are inserted in URL-escaped form (e.g. <Space> -> %20)
                            and always with forward slashes as path separator.
                            An absolute file path starting with "/" is interpreted
                            relative to b:basedir, and a base URL b:baseurl is
                            stripped off the front. This enables you to complete
                            file links even though they are specified as absolute
                            or fully qualified links in the HTML.
                            When there are no matches within the base directory,
                            this falls back to default, non-URL-escaped file
                            completion (i_CTRL-X_CTRL-F).

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-html_FileCompletion
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim html_FileCompletion*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.035 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

Set the following variables in autocmds, filetype plugins or a local vimrc:
                                                                   b:basedir
Specifies the local directory that represents the document root of the edited
HTML file, i.e. where an absolute link starting with "/" points to. To make
this resistant to changes in the CWD, this should be an absolute dirspec. In a
local vimrc located at the document root, you could use:

    let b:basedir = expand('<sfile>:p:h')

                                                                   b:baseurl
Specifies the server location of the b:basedir document root; i.e. a fully
qualified link to the document root, including protocol and hostname.

For a permanent configuration, put the following commands into your vimrc:

The b:basedir can be auto-discovered when it isn't set. Starting with the
directory the current file is in, it will traverse the directory hierarchy
upward until it finds a directory that does _not_ contain typical HTML files,
and will then take the previous directory as the document root. You can adapt
the file glob of what represents files within the document root via:

    let g:html_FileCompletion_WithinDocRootGlob = '*.{htm,html,xhtml,asp,gsp,jsp,php}'

If you want to use a different mapping, map your keys to the
&lt;Plug&gt;(HtmlFileComplete) mapping target _before_ the script is sourced (e.g.
in ~/ftplugin/html\_00remap.vim):

    imap <buffer> <C-x><C-f> <Plug>(HtmlFileComplete)

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-html_FileCompletion/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### 1.21    RELEASEME
- Use ingo#compat#glob() and ingo#workingdir#ChdirCommand().

__You need to update to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.035!__

##### 1.20    31-May-2014
- Detect absolute filespecs and handle them like the build-in file completion,
  as the default mapping overrides that. If the user wants to convert the
  filespec into a link, she must do this explicitly via the
  html\_PathConvert.vim plugin.
- Add dependency to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)).

__You need to separately
  install ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.019 (or higher)!__

##### 1.12    21-May-2014
- FIX: Include autoload scripts in Vimball that are missing in version 1.11.

##### 1.11    12-Jun-2012
- FIX: Do not clobber the global CWD when the buffer has a local CWD set.

##### 1.10    16-May-2012
- ENH: Auto-discover b:basedir by traversing up the directories until one is
found that contains no HTML files.

##### 1.00    15-May-2012
- First published version.

##### 0.01    09-May-2012
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2012-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
