#!/usr/bin/env bash
#
# Copyright (c) 2018-2021 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Check for circular dependencies

export LC_ALL=C

EXPECTED_CIRCULAR_DEPENDENCIES=(
    "activemasternode -> masternode-sync -> activemasternode"
    "activemasternode -> masternodeman -> activemasternode"
    "budget/budgetmanager -> masternode-sync -> budget/budgetmanager"
    "budget/budgetmanager -> net_processing -> budget/budgetmanager"
    "budget/budgetmanager -> validation -> budget/budgetmanager"
    "budget/budgetmanager -> wallet/wallet -> budget/budgetmanager"
    "chain -> legacy/stakemodifier -> chain"
    "chainparamsbase -> util/system -> chainparamsbase"
    "consensus/params -> consensus/upgrades -> consensus/params"
    "crypter -> wallet/wallet -> crypter"
    "evo/deterministicmns -> evo/providertx -> evo/deterministicmns"
    "evo/deterministicmns -> evo/specialtx -> evo/deterministicmns"
    "evo/deterministicmns -> masternodeman -> evo/deterministicmns"
    "evo/providertx -> evo/specialtx -> evo/providertx"
    "kernel -> validation -> kernel"
    "masternode -> masternode-sync -> masternode"
    "masternode -> masternodeman -> masternode"
    "masternode -> wallet/wallet -> masternode"
    "masternode-payments -> masternode-sync -> masternode-payments"
    "masternode-payments -> masternodeman -> masternode-payments"
    "masternode-payments -> net_processing -> masternode-payments"
    "masternode-payments -> validation -> masternode-payments"
    "masternode-sync -> masternodeman -> masternode-sync"
    "masternode-sync -> validation -> masternode-sync"
    "masternodeman -> net_processing -> masternodeman"
    "masternodeman -> validation -> masternodeman"
    "policy/fees -> txmempool -> policy/fees"
    "policy/policy -> validation -> policy/policy"
    "qt/cryptoshares/addresseswidget -> qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/addresseswidget"
    "qt/cryptoshares/navmenuwidget -> qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/navmenuwidget"
    "qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/qtutils -> qt/cryptoshares/cryptosharesgui"
    "qt/cryptoshares/qtutils -> qt/cryptoshares/snackbar -> qt/cryptoshares/qtutils"
    "sapling/saplingscriptpubkeyman -> wallet/wallet -> sapling/saplingscriptpubkeyman"
    "spork -> sporkdb -> spork"
    "spork -> validation -> spork"
    "txmempool -> validation -> txmempool"
    "validation -> validationinterface -> validation"
    "wallet/fees -> wallet/wallet -> wallet/fees"
    "wallet/scriptpubkeyman -> wallet/wallet -> wallet/scriptpubkeyman"
    "wallet/wallet -> wallet/walletdb -> wallet/wallet"
    "chain -> legacy/stakemodifier -> stakeinput -> chain"
    "chain -> legacy/stakemodifier -> validation -> chain"
    "chainparamsbase -> util/system -> logging -> chainparamsbase"
    "coins -> policy/fees -> txmempool -> coins"
    "evo/deterministicmns -> masternode -> masternode-sync -> evo/deterministicmns"
    "evo/deterministicmns -> masternodeman -> net_processing -> evo/deterministicmns"
    "evo/deterministicmns -> masternode -> wallet/wallet -> evo/deterministicmns"
    "evo/deterministicmns -> validation -> validationinterface -> evo/deterministicmns"
    "kernel -> stakeinput -> wallet/wallet -> kernel"
    "masternode-sync -> masternodeman -> net_processing -> masternode-sync"
    "qt/askpassphrasedialog -> qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/topbar -> qt/askpassphrasedialog"
    "qt/cryptoshares/coldstakingwidget -> qt/cryptoshares/tooltipmenu -> qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/coldstakingwidget"
    "qt/cryptoshares/masternodeswidget -> qt/cryptoshares/tooltipmenu -> qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/masternodeswidget"
    "qt/cryptoshares/cryptosharesgui -> qt/cryptoshares/send -> qt/cryptoshares/tooltipmenu -> qt/cryptoshares/cryptosharesgui"
    "chain -> legacy/stakemodifier -> validation -> evo/specialtx -> chain"
    "chain -> legacy/stakemodifier -> validation -> validationinterface -> chain"
    "chain -> legacy/stakemodifier -> stakeinput -> txdb -> chain"
    "chain -> legacy/stakemodifier -> validation -> checkpoints -> chain"
    "chain -> legacy/stakemodifier -> validation -> undo -> chain"
    "chain -> legacy/stakemodifier -> validation -> pow -> chain"
    "coins -> policy/fees -> policy/policy -> validation -> coins"
    "coins -> policy/fees -> policy/policy -> validation -> txdb -> coins"
    "chain -> legacy/stakemodifier -> stakeinput -> wallet/wallet -> spork -> net_processing -> chain"
)

EXIT_CODE=0

CIRCULAR_DEPENDENCIES=()

IFS=$'\n'
for CIRC in $(cd src && ../contrib/devtools/circular-dependencies.py {*,*/*,*/*/*}.{h,cpp} | sed -e 's/^Circular dependency: //'); do
    CIRCULAR_DEPENDENCIES+=( "$CIRC" )
    IS_EXPECTED_CIRC=0
    for EXPECTED_CIRC in "${EXPECTED_CIRCULAR_DEPENDENCIES[@]}"; do
        if [[ "${CIRC}" == "${EXPECTED_CIRC}" ]]; then
            IS_EXPECTED_CIRC=1
            break
        fi
    done
    if [[ ${IS_EXPECTED_CIRC} == 0 ]]; then
        echo "A new circular dependency in the form of \"${CIRC}\" appears to have been introduced."
        echo
        EXIT_CODE=1
    fi
done

for EXPECTED_CIRC in "${EXPECTED_CIRCULAR_DEPENDENCIES[@]}"; do
    IS_PRESENT_EXPECTED_CIRC=0
    for CIRC in "${CIRCULAR_DEPENDENCIES[@]}"; do
        if [[ "${CIRC}" == "${EXPECTED_CIRC}" ]]; then
            IS_PRESENT_EXPECTED_CIRC=1
            break
        fi
    done
    if [[ ${IS_PRESENT_EXPECTED_CIRC} == 0 ]]; then
        echo "Good job! The circular dependency \"${EXPECTED_CIRC}\" is no longer present."
        echo "Please remove it from EXPECTED_CIRCULAR_DEPENDENCIES in $0"
        echo "to make sure this circular dependency is not accidentally reintroduced."
        echo
        EXIT_CODE=1
    fi
done

exit ${EXIT_CODE}
