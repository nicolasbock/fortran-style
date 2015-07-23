add_executable(findent
  findent.c
  logger.c)
set_target_properties(findent
  PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})