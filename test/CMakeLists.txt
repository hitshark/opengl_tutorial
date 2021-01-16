# get source files
aux_source_directory(. SRC_TEST)

file(GLOB GLAD_SOURCE ${CMAKE_SOURCE_DIR}/3rd-party/glad/src/glad.c)
file(GLOB STB_SOURCE ${CMAKE_SOURCE_DIR}/src/stb.cc)

# Build each source file independently
foreach(source ${SRC_TEST})
    get_filename_component(name ${source} NAME_WE)
    set(obj ${name}.bin)

    # target
    add_executable(${obj} ${source} ${GLAD_SOURCE} ${STB_SOURCE})
    target_compile_features(${obj} PRIVATE cxx_std_11)

    target_compile_options(${obj} PRIVATE
        $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:GNU>>:
        -Wall -Wno-unused-parameter -Wextra>
        $<$<CONFIG:Debug>: -O0 -g -ggdb>
        $<$<CONFIG:Release>: -O3>
    )

    target_include_directories(${obj}
        PRIVATE
            ${CMAKE_SOURCE_DIR}/include
            ${CMAKE_SOURCE_DIR}/src
            ${CMAKE_SOURCE_DIR}/3rd-party/assimp/include
            ${CMAKE_SOURCE_DIR}/3rd-party/bullet/src
            ${CMAKE_SOURCE_DIR}/3rd-party/glad/include
            ${CMAKE_SOURCE_DIR}/3rd-party/glfw/include
            ${CMAKE_SOURCE_DIR}/3rd-party/glm
            ${CMAKE_SOURCE_DIR}/3rd-party/stb
    )

    target_link_libraries(${obj}
        PRIVATE
            assimp glfw ${GLFW_LIBRARIES} ${GLAD_LIBRARIES} BulletDynamics BulletCollision LinearMath
    )

endforeach(source)
