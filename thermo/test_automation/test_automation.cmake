if(QUL_PLATFORM STREQUAL "stm32f7508-discovery-baremetal"
   OR QUL_PLATFORM STREQUAL "stm32h750b-discovery-baremetal")
    qul_add_automated_test(thermo_small myTest1 ${CMAKE_CURRENT_LIST_DIR}/screen_compare_thermo.js ${CMAKE_CURRENT_LIST_DIR}/data)
endif()
if(QUL_PLATFORM STREQUAL "stm32f469i-discovery-baremetal"
   OR QUL_PLATFORM STREQUAL "stm32f769i-discovery-baremetal")
    qul_add_automated_test(thermo_big myTest1 ${CMAKE_CURRENT_LIST_DIR}/screen_compare_thermo.js ${CMAKE_CURRENT_LIST_DIR}/data)
endif()
