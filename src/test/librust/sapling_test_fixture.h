// Copyright (c) 2020 The PIVX developers
// Copyright (c) 2022 The Cryptoshares developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or https://www.opensource.org/licenses/mit-license.php.

#ifndef CRYPTOSHARES_SAPLING_TEST_FIXTURE_H
#define CRYPTOSHARES_SAPLING_TEST_FIXTURE_H

#include "test/test_cryptoshares.h"

/**
 * Testing setup that configures a complete environment for Sapling testing.
 */
struct SaplingTestingSetup : public TestingSetup
{
    SaplingTestingSetup(const std::string& chainName = CBaseChainParams::MAIN);
    ~SaplingTestingSetup();
};

/**
 * Regtest setup with sapling always active
 */
struct SaplingRegTestingSetup : public SaplingTestingSetup
{
    SaplingRegTestingSetup();
};


#endif //CRYPTOSHARES_SAPLING_TEST_FIXTURE_H
