foreach(filename test01 test02)
  add_test(NAME ${filename}
    COMMAND ${CMAKE_BINARY_DIR}/src/findent ${filename}.F90)
endforeach()
