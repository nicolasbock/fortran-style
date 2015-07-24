cmake_minimum_required(VERSION 2.8)
project(findent C)

set(CMAKE_C_FLAGS_DEBUG "-O0 -g")

enable_testing()

add_subdirectory(src)
add_subdirectory(tests)