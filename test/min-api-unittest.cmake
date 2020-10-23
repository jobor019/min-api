# Copyright 2018 The Min-API Authors. All rights reserved.
# Use of this source code is governed by the MIT License found in the License.md file.

cmake_minimum_required(VERSION 3.10)

project(${PROJECT_NAME}_test)

enable_testing()

include_directories( 
	"${C74_INCLUDES}"
	"${CMAKE_CURRENT_LIST_DIR}"
	"${CMAKE_CURRENT_LIST_DIR}/mock"
)

if (APPLE)
	set(CMAKE_OSX_ARCHITECTURES x86_64)
endif ()

add_definitions(
	-DMIN_TEST
)

add_executable(${PROJECT_NAME} ${PROJECT_NAME}.cpp)

target_link_libraries(${PROJECT_NAME} PUBLIC "mock_kernel")

if (APPLE)
	set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-Wl,-F'${C74_MAX_API_DIR}/lib/mac', -weak_framework JitterAPI")
	target_compile_options(${PROJECT_NAME} PRIVATE -DCATCH_CONFIG_NO_CPP17_UNCAUGHT_EXCEPTIONS)

    # The build dir won't be present the first time the test is compiled.
    # This isn't a problem but it does generate linker warnings about the folder not existing.
    # So we create the folder in advance.

    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/Debug")
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/Release")
endif ()

add_test(NAME ${PROJECT_NAME}
         COMMAND ${PROJECT_NAME})
