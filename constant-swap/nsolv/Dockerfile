FROM debian:bullseye-slim
RUN apt-get update
RUN apt-get install -y git cmake
RUN apt-get install -y g++
RUN git clone https://github.com/delcypher/nsolv.git

RUN apt-get install -y libboost-program-options1.71.0 libboost-filesystem1.71.0 libboost-system1.71.0
RUN apt-get install -y libstdc++6
RUN cmake nsolv/
CMD echo "hello"
