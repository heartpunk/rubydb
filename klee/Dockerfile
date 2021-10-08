from klee/klee:latest

ENV CC=/tmp/llvm-90-install_O_D_A/bin/clang
ENV CFLAGS=save-temps=llvm

RUN sudo apt-get update
RUN sudo apt install -qy automake bison git
RUN git clone --branch=v3_0_2 --depth=1 https://github.com/ruby/ruby.git
WORKDIR /home/klee/ruby
RUN git checkout
RUN ./autogen.sh
RUN ./configure --prefix=/home/klee/instrumented_ruby
RUN make
RUN make install
