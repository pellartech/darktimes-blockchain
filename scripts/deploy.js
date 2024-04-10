// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat')
const { map } = require('lodash')

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms))

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const factories = ['DARKTIMES']

  const resultsAddr = []

  for (const fac of factories) {
    const Factory = await hre.ethers.getContractFactory(fac)
    const res = await Factory.deploy()

    await res.deployed()

    console.log(`Contract ${fac} deployed to:`, res.address)
    resultsAddr.push(res.address)
  }

  console.log('Waiting for 30 seconds to verify contract')
  await sleep(30000)

  await Promise.all(
    map(resultsAddr, (addr) => {
      return hre.run('verify:verify', {
        address: addr,
        constructorArguments: [],
      })
    })
  )
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
