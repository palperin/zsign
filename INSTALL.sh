#!/bin/bash

MacOs=darwin
CentOs=yum
Ubuntu=apt-get
CmakeV=3.21.3

# Compile on MacOs

	# Detect Os if  it is MacOs 
	if [[ "$OSTYPE" =~ ^$MacOs ]]; then
		
	# Dependencies 
	brew install zip unzip &&
	brew install openssl cmake
    
    test -d "/usr/local/opt/openssl@3" &&
        mkdir lib && cp /usr/local/opt/openssl@3/lib/libssl.dylib ./lib/ && cp /usr/local/opt/openssl@3/lib/libcrypto.dylib ./lib/ &&
        cp /usr/local/opt/openssl@3/lib/libssl.3.dylib ./lib/ && cp /usr/local/opt/openssl@3/lib/libcrypto.3.dylib ./lib/ 

    test -d "/opt/homebrew/opt/" &&
        mkdir -p /usr/local/opt/ && sudo cp -rn /opt/homebrew/opt/openssl* /usr/local/opt/ &&
        mkdir lib && cp /opt/homebrew/opt/openssl@3/lib/libssl.dylib ./lib/ && cp /opt/homebrew/opt/openssl@3/lib/libcrypto.dylib ./lib/ &&
        cp /opt/homebrew/opt/openssl@3/lib/libssl.3.dylib ./lib/ && cp /opt/homebrew/opt/openssl@3/lib/libcrypto.3.dylib ./lib/ 

# Compile zsign usign cmake
mkdir build; cd build &&
cmake .. && 
make


# Compile on CentOS

    # Detect OS if it is CentOS
    elif [ -x /usr/bin/$CentOs ]; then

        # Dependencies
        yum install openssl-devel -y;
        yum install wget zip unzip -y &&
        yum group install "Development Tools" -y &&

            # Installing Cmake latest
wget -qO- "https://cmake.org/files/v3.21/cmake-$CmakeV-linux-x86_64.tar.gz" | \
tar --strip-components=1 -xz -C /usr/local &&



# Compile zsign using cmake
mkdir build; cd build &&
cmake .. &&
make


# Compile on Ubuntu

    # Detect OS if it is ubuntu
    elif [ -x /usr/bin/$Ubuntu ]; then


        # Dependencies
        sudo apt-get install wget zip unzip build-essential checkinstall zlib1g-dev libssl-dev -y &&

            # Installing Cmake latest
            wget -qO- "https://cmake.org/files/v3.21/cmake-$CmakeV-linux-x86_64.tar.gz" | \
            tar --strip-components=1 -xz -C /usr/local &&


# Compile zsign using cmake
mkdir build; cd build &&
cmake .. &&
make
    fi
