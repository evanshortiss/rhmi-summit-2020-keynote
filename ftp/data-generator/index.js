'use strict'

const { existsSync, readdirSync, mkdirSync, writeFileSync, readFileSync } = require('fs')
const { resolve } = require('path')
const { tmpdir } = require('os')
const env = require('env-var')
const faker = require('faker')
const hbs = require('handlebars')
const log = require('barelog')
const isProduction = env.get('NODE_ENV').required().asEnum([
  'development', 'production'
]) === 'production'

const tpl = hbs.compile(
  readFileSync(resolve(__dirname, 'templates/transaction.xml.hbs'), 'utf8')
)

/**
 * Determines where to write the generated XML.
 * During development it will write data to a temporary directory.
 */
const filesDir = resolve(isProduction ? '/home/ftp-user/' : tmpdir(), 'transactions/')

// Write initial set of files
doWrite()

function doWrite () {
  if (!existsSync(filesDir)) {
    log('creating files directory at:', filesDir)
    mkdirSync(filesDir)
  }

  if (readdirSync(filesDir).length >= 2) {
    log('skipping data generation since existing files have yet to be processed')
  } else {
    for (let i = 0; i < Math.round(Math.random() * 2); i++) {
      const tx = {
        uuid: faker.random.uuid(),
        firstname: faker.name.firstName(),
        lastname: faker.name.lastName(),
        zipcode: faker.address.zipCode(),
        price: faker.commerce.price(),
        datetime: faker.date.recent().toJSON()
      }

      const writePath = resolve(filesDir, `${tx.uuid}.xml`)
      log('writing data to file:', writePath)
      writeFileSync(writePath, tpl(tx))
    }
  }

  // Queue the next write in ~3 seconds
  setTimeout(doWrite, 3000)
}
