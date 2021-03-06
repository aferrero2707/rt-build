#! /bin/bash
#cd /usr/i686-w64-mingw32/include || exit 1
#rm -f Shlobj.h || exit 1
#ln -s shlobj.h Shlobj.h || exit 1
(mkdir -p /work/w64-build && cd /work/w64-build) || exit 1
echo "Compiling RawTherapee"
ls /sources
sed -i 's/Shlobj.h/shlobj.h/g' /sources/rtgui/options.cc
sed -i 's/Shlwapi.h/shlwapi.h/g' /sources/rtgui/placesbrowser.cc
sed -i 's|install(FILES "${CMAKE_CURRENT_BINARY_DIR}/WindowsInnoSetup.iss"|#install(FILES "${CMAKE_CURRENT_BINARY_DIR}/WindowsInnoSetup.iss"|' /sources/rtdata/CMakeLists.txt

(crossroad cmake -DCMAKE_BUILD_TYPE=Release -DPROC_TARGET_NUMBER=1 \
 -DCACHE_NAME_SUFFIX="'5-dev-ci'" \
 -DCMAKE_C_FLAGS="'-mwin32 -m64 -mthreads -msse2'" \
 -DCMAKE_C_FLAGS_RELEASE="'-DNDEBUG -g -O2'" \
 -DCMAKE_CXX_FLAGS="'-mwin32 -m64 -mthreads -msse2'" \
 -DCMAKE_CXX_FLAGS_RELEASE="'-Wno-aggressive-loop-optimizations -DNDEBUG -g -O3'" \
 -DCMAKE_EXE_LINKER_FLAGS="'-m64 -mthreads -static-libgcc'" \
 -DCMAKE_EXE_LINKER_FLAGS_RELEASE="'-s -O3'" \
 /sources && make -j 2 && make install) || rm -rf Release
#(crossroad cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPROC_TARGET_NUMBER=1 \
# -DCACHE_NAME_SUFFIX="'5-dev'" \
# -DCMAKE_C_FLAGS="'-mwin32 -m64 -mthreads -msse2'" \
# -DCMAKE_C_FLAGS_RELWITHDEBINFO="'-DNDEBUG -g -O2'" \
# -DCMAKE_CXX_FLAGS="'-mwin32 -m64 -mthreads -msse2'" \
# -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="'-Wno-aggressive-loop-optimizations -DNDEBUG -g -O3'" \
# -DCMAKE_EXE_LINKER_FLAGS="'-m64 -mthreads -static-libgcc'" \
# -DCMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO="'-s -O3'" \
# /sources && make -j 2 && make install) || exit 1
