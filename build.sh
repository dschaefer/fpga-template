set -x

if [ ! -d build ]; then
    mkdir -p build
    cd build
    cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
else
    cd build    
fi

ninja
