include(FindBISON)
include(FindFLEX)

if(NOT BISON_FOUND)
  message(FATAL_ERROR "Could not find a suitable bison parser generator")
endif()

if(NOT FLEX_FOUND OR NOT FLEX_LIBRARIES)
  message(FATAL_ERROR "Could not find a suitable flex lexer")
endif()

set(DEBUG_PARSER FALSE
  CACHE BOOL "Whether to debug the parser")

add_custom_command(OUTPUT parser.c parser.h
  COMMAND ${BISON_EXECUTABLE} -d -v -o parser.c parser.y
  DEPENDS parser.y)

add_custom_command(OUTPUT lexer.c
  COMMAND ${FLEX_EXECUTABLE} -o lexer.c lexer.l
  DEPENDS lexer.l)

add_executable(findent
  findent.c
  lexer.c
  logger.c
  parser.c)

get_target_property(COMPILE_DEFINITIONS findent COMPILE_DEFINITIONS)
if(NOT COMPILE_DEFINITIONS)
  unset(COMPILE_DEFINITIONS)
endif()

list(APPEND COMPILE_DEFINITIONS "YYERROR_VERBOSE")
if(DEBUG_PARSER)
  list(APPEND COMPILE_DEFINITIONS "YYDEBUG")
endif()

message(STATUS "${COMPILE_DEFINITIONS}")

set_target_properties(findent
  PROPERTIES
  COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")

target_link_libraries(findent ${FLEX_LIBRARIES})