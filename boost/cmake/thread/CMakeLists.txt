include(../boost_helper.cmake)
get_filename_component(src ${boost_root}/libs/thread/src ABSOLUTE)

find_package(Threads MODULE)

add_boost_library(TARGET thread)

if(SUPPORT_LEGACY_GLOBAL_MAKE)
    target_compile_definitions(${target}
        PRIVATE
            $<$<PLATFORM_ID:Windows>:BOOST_THREAD_BUILD_LIB>
    )
else()
    target_compile_definitions(${target}
        INTERFACE
            $<$<BOOL:${BUILD_SHARED_LIBS}>:BOOST_THREAD_USE_DLL>
        PRIVATE
            $<$<BOOL:${BUILD_SHARED_LIBS}>:BOOST_THREAD_BUILD_DLL>
    )
endif()

target_sources(${target}
    PRIVATE
        $<$<BOOL:${CMAKE_USE_PTHREADS_INIT}>:${src}/tss_null.cpp>
        $<$<BOOL:${CMAKE_USE_PTHREADS_INIT}>:${src}/pthread/once.cpp>
        $<$<BOOL:${CMAKE_USE_PTHREADS_INIT}>:${src}/pthread/thread.cpp>

        $<$<PLATFORM_ID:Windows>:${src}/win32/thread.cpp>
        $<$<PLATFORM_ID:Windows>:${src}/win32/tss_dll.cpp>
        $<$<PLATFORM_ID:Windows>:${src}/win32/tss_pe.cpp>
        $<$<PLATFORM_ID:Windows>:${src}/future.cpp>
)

global_target_dependencies(${target}
    PUBLIC
        Boost::date_time
)
