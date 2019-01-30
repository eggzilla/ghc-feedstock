export CC="x86_64-conda_cos6-linux-gnu-cc"
export LD="x86_64-conda_cos6-linux-gnu-cc"
export PATH="$BUILD_PREFIX/bin:$PREFIX/bin:$PATH"
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$PREFIX/lib:$LIBRARY_PATH"
export C_INCLUDE_PATH="$PREFIX/include:$C_INCLUDE_PATH"
export LDFLAGS=" -lgmp -lpthread $LDFLAGS "
export CFLAGS=" -Wl,-L$PREFIX/lib -Wl,-lgmp -Wl,-lpthread $CFLAGS "
export LIBS=" -lgmp -lpthread $LIBS "
ghc-pkg recache
#ghc-pkg describe rts
#ghc-pkg describe rts > rts.pkg
#perl -pi -e 's/$PREFIX\/lib\/ghc-8.2.2\/rts/$PREFIX\/lib\/ghc-8.2.2\/rts \$\{pkgroot\}\/../g' rts.pkg
#cat rts.pkg
#ghc-pkg update rts.pkg
#export CONF_GCC_LINKER_OPTS_STAGE0=$LDFLAGS
#export CONF_GCC_LINKER_OPTS_STAGE1=$LDFLAGS
#export CONF_GCC_LINKER_OPTS_STAGE2=$LDFLAGS
#export CONF_GCC_LINKER_OPTS_STAGE3=$LDFLAGS
#export CONF_CC_LINKER_OPTS_STAGE0=$LDFLAGS
#export CONF_CC_LINKER_OPTS_STAGE1=$LDFLAGS
#export CONF_CC_LINKER_OPTS_STAGE2=$LDFLAGS
#export CONF_CC_LINKER_OPTS_STAGE3=$LDFLAGS
#export CONF_CPP_OPTS_STAGE0=$CFLAGS
#export CONF_CPP_OPTS_STAGE1=$CFLAGS
#export CONF_CPP_OPTS_STAGE2=$CFLAGS
#export CONF_CPP_OPTS_STAGE3=$CFLAGS
#export SRC_HC_OPTS=" -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc "
#export SRC_HSC2HS_OPTS=" -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc "
#export CONF_HC_OPTS_STAGE0=" -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc "
#export CONF_HC_OPTS_STAGE1=" -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc "
#export CONF_HC_OPTS_STAGE2=" -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc "
#export CONF_HC_OPTS_STAGE3=" -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc "
#perl -pi -e 's/GhcLibHcOpts=/GhcLibHcOpts= -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -threaded /g' mk/config.mk.in
#perl -pi -e 's/GhcRtsHcOpts=-O2 -fomit-frame-pointer -g/GhcRtsHcOpts=-O2 -fomit-frame-pointer -g -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -threaded /g' mk/config.mk.in
#perl -pi -e 's/GhcHcOpts=/GhcHcOpts= -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -threaded /g' mk/config.mk.in
#perl -pi -e 's/GhcStage1HcOpts=/GhcStage1HcOpts= -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -threaded /g' mk/config.mk.in
#perl -pi -e 's/GhcStage2HcOpts=/GhcStage2HcOpts= -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -threaded /g' mk/config.mk.in
#perl -pi -e 's/GhcStage3HcOpts=/GhcStage3HcOpts= -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -threaded /g' mk/config.mk.in
cat mk/config.mk.in
./configure --prefix=$PREFIX --with-hs-cpp=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-cpp --with-gmp-includes=$PREFIX/include --with-curses-libraries=$PREFIX/lib --with-gmp-libraries=$PREFIX/lib CC=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-cc LD=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-cc CPPFLAGS=$_INCLUDE_PATH
cat mk/config.mk
cp mk/build.mk.sample mk/build.mk
perl -pi -e 's/#BuildFlavour = quick/BuildFlavour = quick/g' mk/build.mk
#perl -pi -e 's/#V=0/V=0/g' mk/build.mk
#perl -pi -e 's/#HADDOCK_DOCS = YES/HADDOCK_DOCS = NO/g' mk/build.mk
echo "V=0" >> mk/build.mk
#echo "HADDOCK_DOCS = NO" >> mk/build.mk
echo "SRC_HC_OPTS = -O0 -H64m -L$PREFIX/lib -lgmp -threaded -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc " >> mk/build.mk
echo "SRC_HSC2HS_OPTS = -lgmp -lpthread " >> mk/build.mk
echo "libraries/integer-gmp_CONFIGURE_OPTS = -lgmp " >> mk/build.mk
cat mk/build.mk
#./validate --build-only
echo "Settings"
cat settings
make 
make install
#Small test
#if [ -f "$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ld" ]; then
#   ln -s $BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ld $BUILD_PREFIX/bin/ld
#fi
echo "main = putStr \"smalltest\"" > Main.hs
ghc -v -O0 -threaded -L$PREFIX/lib -pgmc x86_64-conda_cos6-linux-gnu-cc -pgml x86_64-conda_cos6-linux-gnu-cc -fasm -o smalltest Main.hs 
./smalltest

