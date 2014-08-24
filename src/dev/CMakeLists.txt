FILE(GLOB_RECURSE SRC_DEV "${CMAKE_CURRENT_SOURCE_DIR}" "*.cpp")
include_directories(${CKT_DIR})
include_directories(${MAT_DIR})
ADD_LIBRARY(device STATIC ${SRC_DEV}) 
