include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/date_time/src ABSOLUTE)

add_boost_library(TARGET date_time)

target_sources(${target}
    PRIVATE
        ${src}/gregorian/date_generators.cpp
        ${src}/gregorian/gregorian_types.cpp
        ${src}/gregorian/greg_month.cpp
        ${src}/gregorian/greg_weekday.cpp
        ${src}/posix_time/posix_time_types.cpp
)

global_target_dependencies(${target}
    PUBLIC
        Boost::chrono
)
