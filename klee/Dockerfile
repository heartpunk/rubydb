from klee/klee:latest

ENV CC=/tmp/llvm-90-install_O_D_A/bin/clang
ENV CFLAGS='--save-temps=llvm -g -O0 -Xclang -disable-O0-optnone'

RUN sudo apt-get update
RUN sudo apt install -qy automake bison git
RUN git clone --branch=v3_0_2 --depth=1 https://github.com/ruby/ruby.git
COPY . /home/klee
WORKDIR /home/klee/ruby
RUN patch -p1 < /home/klee/ruby-mjit-clang.patch
RUN ./autogen.sh
RUN ./configure --prefix=/home/klee/instrumented_ruby
RUN make
RUN make install
