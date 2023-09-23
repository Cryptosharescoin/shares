CMAKE_MINIMUM_REQUIRED(VERSION 3.14)

set(QT_MINIMUM_VERSION 5.5.1)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/forms ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/forms ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/forms)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif ()

unset(Qt5Enables)
foreach(comp Widgets Core Gui Network LinguistTools DBus Svg Charts)
    find_package(Qt5${comp})
    set(Qt5Enables "${Qt5Enables};Qt5${comp}_FOUND")
    if(Qt5${comp}_FOUND)
        MESSAGE(STATUS "FOUND Qt5${comp}")
        include_directories(${include_directories} ${Qt5${comp}_INCLUDE_DIRS} ${QT_USE_FILE})
        add_definitions(${Qt5${comp}_DEFINITIONS})
        list(APPEND Qt5_LIBRARIES ${Qt5${comp}_LIBRARIES})
    else()
        MESSAGE(WARNING "Cant find Qt5${comp}")
    endif()
endforeach(comp)

if (Qt5Core_FOUND)
    if (Qt5Core_VERSION VERSION_LESS QT_MINIMUM_VERSION)
        MESSAGE(FATAL_ERROR "Minimum supported Qt5 version is ${QT_MINIMUM_VERSION}")
    else()
        MESSAGE(STATUS "Found Qt5 version: ${Qt5Core_VERSION}")
    endif()
else()
    MESSAGE(FATAL_ERROR "Could not find any Qt5 installation")
endif()

if (Qt5DBus_FOUND)
    add_compile_options("-DUSE_DBUS")
endif()

if (Qt5Charts_FOUND)
    add_compile_options("-DUSE_QTCHARTS")
endif()

find_package(Qrcode)
if (QRCODE_FOUND)
    include_directories ( ${QRCODE_INCLUDE_DIR} )
    link_directories ( ${QRCODE_LIBRARY_DIRS} )
endif()

find_program(MOC_BIN NAMES moc moc-qt5 qt5-moc
        PATHS /usr/lib/qt5/bin /usr/lib/x86_64-linux-gnu/qt5/bin /usr/local/opt/qt/bin /usr/local/opt/qt5/bin /opt/homebrew/opt/qt5/bin
        NO_DEFAULT_PATH
        NO_SYSTEM_ENVIRONMENT_PATH)
if (MOC_BIN)
    MESSAGE(STATUS "FOUND MOC ${MOC_BIN}")
endif ()

add_compile_options("-DQT_NO_KEYWORDS")

# Why isn't this done automatically??
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(CMAKE_AUTOMOC_MOC_OPTIONS "-DQ_OS_MAC")
endif()

file(GLOB LOCAL_QT_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
source_group("QtHeaders" FILES ${LOCAL_QT_HEADERS})

SET(QT_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/bantablemodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/bitcoinaddressvalidator.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/bitcoinunits.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/clientmodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/csvmodelwriter.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/guiutil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/intro.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/networkstyle.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/notificator.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/optionsmodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/peertablemodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/platformstyle.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/qvalidatedlineedit.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/qvaluecombobox.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/rpcconsole.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/rpcexecutor.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/trafficgraphwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/utilitydialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/addressbookpage.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/addresstablemodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/askpassphrasedialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/coincontroldialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/coincontroltreewidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/editaddressdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/openuridialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/paymentserver.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/recentrequeststablemodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/transactionfilterproxy.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/transactionrecord.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/transactiontablemodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/walletmodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/walletmodeltransaction.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/cryptosharesgui.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/loadingdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/pwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/focuseddialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/guitransactionsutils.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/snackbar.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/navmenuwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/lockunlock.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/receivedialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/furabstractlistitemdelegate.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/txviewholder.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/qtutils.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/balancebubble.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/expandablebutton.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/topbar.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/txrow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/addressfilterproxymodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/dashboardwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/addresslabelrow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/contactdropdownrow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/contactsdropdown.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/optionbutton.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/mninfodialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/coldstakingmodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/mnmodel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/masternodewizarddialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/mnrow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/masternodeswidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/sendchangeaddressdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/sendconfirmdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/sendcustomfeedialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/sendmemodialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/sendmultirow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/send.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/addnewaddressdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/addnewcontactdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/requestdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/receivewidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/myaddressrow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/csrow.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/addressholder.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/tooltipmenu.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/addresseswidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/defaultdialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/coldstakingwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/mnselectiondialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/proposalcard.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/votedialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/createproposaldialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/proposalinfodialog.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/governancewidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsbackupwallet.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsbittoolwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsconsolewidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsdisplayoptionswidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsfaqwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsinformationwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsmainoptionswidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingssignmessagewidgets.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingswalletoptionswidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingswalletrepairwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingsexportcsv.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings/settingswidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/welcomecontentwidget.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/splash.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/governancemodel.cpp
        )

execute_process(
        COMMAND ${MOC_BIN} -o moc_pfborderimage.cpp pfborderimage.h
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares
)
list(APPEND QT_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/moc_pfborderimage.cpp)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    list(APPEND QT_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/macdockiconhandler.mm)
    list(APPEND QT_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/macnotificationhandler.mm)
endif()

add_library(qt_stuff STATIC ${BitcoinHeaders} ${QtHeaders} ${QT_SOURCES} ${PROTO_SRCS} ${PROTO_HDRS})
target_include_directories(qt_stuff PUBLIC ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/src/leveldb/include
        ${CMAKE_SOURCE_DIR}/src/univalue/include
        ${CMAKE_SOURCE_DIR}/src/secp256k1/include
        ${CMAKE_SOURCE_DIR}/src/chiabls/src
        ${relic_SOURCE_DIR}/include
        ${relic_BINARY_DIR}/include
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares
        ${CMAKE_CURRENT_SOURCE_DIR}/cryptoshares/settings
        ${BerkeleyDB_INCLUDE_DIRS}
        )
set_property(TARGET qt_stuff PROPERTY CXX_STANDARD 14)

file(GLOB QT_TRANSLATIONS_FILES ${CMAKE_CURRENT_SOURCE_DIR}/locale/*.ts)

get_filename_component(QM_FILES_BINARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/locale" ABSOLUTE)
set_source_files_properties(${QT_TRANSLATIONS_FILES} PROPERTIES OUTPUT_LOCATION "${QM_FILES_BINARY_DIR}")

QT5_ADD_TRANSLATION(QM ${QT_TRANSLATIONS_FILES})
add_custom_target(translations_target ALL DEPENDS ${QM})

QT5_ADD_RESOURCES(QRC_RESOURCE cryptoshares.qrc)
QT5_ADD_RESOURCES(QRC_LOCALE_RESOURCE cryptoshares_locale.qrc)

add_executable(cryptoshares-qt cryptoshares.cpp ${QM} ${QRC_RESOURCE} ${QRC_LOCALE_RESOURCE})
add_dependencies(cryptoshares-qt translations_target libunivalue libsecp256k1 libzcashrust leveldb crc32c bls)
target_include_directories(cryptoshares-qt PUBLIC ${ENDIAN_INCLUDES} ${GMP_INCLUDE_DIR})
target_link_libraries(cryptoshares-qt
        qt_stuff
        univalue
        leveldb crc32c secp256k1 rustzcash bls
        ${BerkeleyDB_LIBRARIES} ${Boost_LIBRARIES} ${LIBEVENT_LIB}
        ${sodium_LIBRARY_RELEASE} ${GMP_LIBRARY}
        -ldl pthread
        )
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    target_link_libraries(cryptoshares-qt "-framework Cocoa")
endif()
if(ZMQ_FOUND)
    target_link_libraries(cryptoshares-qt ZMQ_A ${ZMQ_LIB})
    target_include_directories(cryptoshares-qt PUBLIC ${ZMQ_INCLUDE_DIR})
endif()
if (QRCODE_FOUND)
    target_link_libraries(cryptoshares-qt ${QRCODE_LIB})
    target_include_directories(cryptoshares-qt PUBLIC ${QRCODE_INCLUDE_DIR})
endif()
if(MINIUPNP_FOUND)
    target_compile_definitions(cryptoshares-qt PUBLIC "-DSTATICLIB -DMINIUPNP_STATICLIB")
    target_link_libraries(cryptoshares-qt ${MINIUPNP_LIBRARY})
    target_include_directories(cryptoshares-qt PUBLIC ${MINIUPNP_INCLUDE_DIR})
endif()
if(NAT-PMP_FOUND)
    target_link_libraries(cryptoshares-qt ${NAT-PMP_LIBRARY})
    target_include_directories(cryptoshares-qt PUBLIC ${NAT-PMP_INCLUDE_DIR})
endif()

target_link_libraries(cryptoshares-qt Qt5::Gui Qt5::Core Qt5::Widgets Qt5::Network Qt5::Svg ${QT_LIBRARIES})
if (Qt5DBus_FOUND)
    target_link_libraries(cryptoshares-qt Qt5::DBus ${QT_LIBRARIES})
endif()
if (Qt5Charts_FOUND)
    target_link_libraries(cryptoshares-qt Qt5::Charts ${QT_LIBRARIES})
endif()
