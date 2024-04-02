include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/atomic/src ABSOLUTE)

add_boost_library(TARGET atomic)

target_sources(${target}
    PRIVATE
        ${src}/lockpool.cpp
)

target_compile_definitions(${target}
    PRIVATE
       BOOST_ATOMIC_SOURCE
)
