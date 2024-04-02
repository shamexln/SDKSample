include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/system/src ABSOLUTE)

add_boost_library(TARGET system)

target_compile_definitions(${target}
    PUBLIC
        BOOST_SYSTEM_NO_DEPRECATED
)

target_sources(${target}
    PRIVATE
        ${src}/error_code.cpp
)
