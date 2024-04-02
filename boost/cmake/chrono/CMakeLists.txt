include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/chrono/src ABSOLUTE)

add_boost_library(TARGET chrono)

target_sources(${target}
    PRIVATE
        ${src}/chrono.cpp
        ${src}/process_cpu_clocks.cpp
        ${src}/thread_clock.cpp
)

global_target_dependencies(${target}
    PUBLIC
        Boost::system
)
