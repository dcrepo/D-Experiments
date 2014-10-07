D-Experiments
=============

Experiments with D code

Important: Most of these examples will be Windows-specific, so be sure to get the win32 API bindings
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

GDC and LDC compilers operate a bit differently. I have limited experience with them, but I've gotten a few programs to compile. There are currently a few issues to consider though:
1. D Versions lag behind the latest DMD releases.
2. Binary-sizeis an issue.GDC sits on the GCC compiler chain and executables tend to be about 1MB minimum.
2. Certain extra GCC-specific DLL's may not statically link with the executable, causing all kinds of issues with porting the executable around.
3. GDC linking in libraries might need to be done on the command-line (-luser32, etc).

Also, if you haven't yet, please try Visual D: https://rainers.github.io/visuald/visuald/StartPage.html
