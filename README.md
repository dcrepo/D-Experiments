D-Experiments
=============

Experiments with D code on Windows

Important: AS most of these examples will be Windows-specific, be sure to get the win32 API bindings

Windows API bindings are linked from here: http://www.dsource.org/projects/bindings/wiki/WindowsApi

Put the Windows bindings in a folder thats in your include path! I tend to put the bindings in dmd2/src/phobos/win32.

Also important for compiling with Windows programs is using either the implib tool or coffimplib.

IMPLIB: http://www.digitalmars.com/ctg/implib.html
COFFIMPLIB: http://www.digitalmars.com//ctg/coffimplib.html

Find IMPLIB in Basic Utilities download at http://www.digitalmars.com//download/freecompiler.html
(pretty old)

Find COFFIMPLIB download at http://forum.dlang.org/thread/dpaolp$1oek$1@digitaldaemon.com

Create or convert libraries and put them in dmd2/windows/lib. Don't concern yourself with the lib64 folder, as dmd requires the Microsoft linker for 64-bit code, and thus will use the Windows SDK libraries.

Library-link flags can be put in the source code, but these may only work on DMD at the moment:

pragma(lib, "user32");  // Link to user32.lib

GDC and LDC compilers operate a bit differently. I have limited experience with GDC, and no luck getting LDC to work.

With these other compilers, there are currently a few issues to consider:

1. GDC and LDC D Versions lag behind the latest DMD releases.
2. Getting either compiler to work on Windows is painful. A GCC release and a GDC release must be merged into a single folder. LDC requires either the minGW or MSVC compiler toolchains. I haven't had success with this at all.
3. Binary-size is an issue: GDC, since it sits on the GCC compiler chain, produces executables with a base size of ~1MB each. LDC with minGW will likely have around the same size. However, if the MSVC compiler chain is used, there could be a massive reduction in size.
4. Certain extra GCC-specific DLL's may not statically link with the executable, causing all kinds of issues with porting the executable around. (GDC and LDC with the minGW compiler)
5. GDC linking in libraries might need to be done on the command-line (-luser32, etc).

(Also check out SDC compiler which is a W-I-P: https://github.com/UplinkCoder/sdc)

IDE's:
If you haven't yet, please try Visual D: https://rainers.github.io/visuald/visuald/StartPage.html
It requires Microsoft Visual Studio, so if you don't have it, I'd certainly recommend getting one of the free versions, or a student edition if you are attending university.

Also check out MonoD and DDT (for Eclipse), as well as others:

http://wiki.dlang.org/IDEs

Additionally, editors that are worth looking at:

http://wiki.dlang.org/Editors

I personally tend to use Code::Blocks and Programmer's Notepad (with my own tools) [http://www.pnotepad.org/].

D Libraries are numerous, many are covered on the wiki. Some are O/S-specific, many are cross-platform:

http://wiki.dlang.org/Open_Source_Projects

Check out the D DUB repos as these are integrated in most IDE's and help experimenting and using other libraries:

http://wiki.dlang.org/DUB
http://code.dlang.org/
