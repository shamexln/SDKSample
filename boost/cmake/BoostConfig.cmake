cmake_minimum_required(VERSION 3.12)

get_filename_component(boost_root ${CMAKE_CURRENT_LIST_DIR}/.. ABSOLUTE)
include(${boost_root}/cmake/boost_helper.cmake)

function(add_boost_component name)
    if(NOT TARGET Boost::${name})
        add_subdirectory(${boost_root}/cmake/${name} ${CMAKE_BINARY_DIR}/Boost/${name})
    endif()
endfunction()

if(NOT Boost_FIND_COMPONENTS)
    file(GLOB libs LIST_DIRECTORIES true RELATIVE ${boost_root}/cmake ${boost_root}/cmake/*)
    list(FILTER libs EXCLUDE REGEX "\.cmake")
    set(Boost_FIND_COMPONENTS boost ${libs})
endif()

foreach(comp ${Boost_FIND_COMPONENTS})
    # header only
    if(comp STREQUAL "boost" AND NOT TARGET Boost::boost)
        add_boost_library(TARGET boost HEADER_ONLY)
    endif()

    add_boost_component(${comp})
endforeach()
