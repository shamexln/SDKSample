include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/atomic/src ABSOLUTE)

add_boost_library(TARGET asio HEADER_ONLY)

global_target_dependencies(${target}
    INTERFACE
       OpenSSL::SSL
       Boost::system
       Boost::chrono
)
