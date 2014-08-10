find_package(BISON)
find_package(FLEX)

BISON_TARGET(SpParser ${CMAKE_CURRENT_SOURCE_DIR}/SpParser.yy ${CMAKE_CURRENT_SOURCE_DIR}/SpParser.cpp)
FLEX_TARGET(SpScanner ${CMAKE_CURRENT_SOURCE_DIR}/SpParser.l  ${CMAKE_CURRENT_SOURCE_DIR}/SpScanner.cpp)
ADD_FLEX_BISON_DEPENDENCY(SpScanner SpParser)

include_directories(${CKT_DIR})
include_directories(${DEV_DIR})

add_library(parser STATIC ${BISON_SpParser_OUTPUTS} ${FLEX_SpScanner_OUTPUTS})
