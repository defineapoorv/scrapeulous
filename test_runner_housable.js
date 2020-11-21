#!/usr/bin/env node

const fs = require('fs');
const clipboardy = require('clipboardy');
const UserAgent = require('user-agents');
const axios = require('axios');

class Worker {
  constructor(options) {
    this.logger = {
      info: console.log,
      error: console.error
    };
    this.options = options || {};
  }

  async sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

class HttpWorker extends Worker {
  constructor(options) {
    super(options);
  }

  async setup() {
    this.UserAgent = UserAgent;
    this.Got = require('got');
    this.Cheerio = require('cheerio');
  }

  async turnDown() {}
}

class BrowserWorker extends Worker {
  constructor(options) {
    super(options);
  }

  async setup() {
    this.UserAgent = UserAgent;
    this.clipboardy = clipboardy;
    const puppeteer = require('puppeteer');
    this.browser = await puppeteer.launch({
      headless: true,
      defaultViewport: null,
      args: ['--start-maximized'],
    });
    this.page = await this.browser.newPage();
  }

  async turnDown() {
    await this.page.close();
    await this.browser.close();
  }
}

class TestRunner {
  constructor(crawler, items, options) {
    this.items = items;
    this.options = options;

    try {
      this.crawler_code = fs.readFileSync(crawler);
    } catch (err) {
      console.error(`Could not read crawler: ${err}`);
      process.exit(-1);
    }
  }

  async run() {
    if (this.crawler_code.includes('extends HttpWorker')) {
    } else if (this.crawler_code.includes('extends BrowserWorker')) {
    } else {
      console.error(`Invalid worker`);
      process.exit(-1);
    }

    let Worker = eval(`(${this.crawler_code})`);
    let instance = new Worker(this.options);
    await instance.setup();

    let results = [];

    for (let item of this.items) {
      results.push(await instance.crawl(item));
    }

    await instance.turnDown();

    return results;
  }
}


axios.post('https://protected-peak-85531.herokuapp.com/get_100_addresses', { county: 'SAN JOAQUIN', limit:100 } )
  .then(function (response) {
    addreses = response.data;
    console.log(addreses)
    let items = [];
    for(var k in addreses) items.push(k);

    (async () => {
      // let items = eval(process.argv[3]) || ['https://ipinfo.io/json'];
      if (!Array.isArray(items)) {
        console.error(`items must be an array`);
        process.exit(-1);
      }

      let crawler = process.argv[2] || 'http.js';
      let options = {};
      if (crawler === 'leads.js') {
        options.advanced = false;
      }

      if (crawler === 'social.js') {
        options.link_depth = 1;
      }

      console.log(`Running crawler ${crawler} with options ${JSON.stringify(options)}`);

      let tester = new TestRunner(crawler, items, options);
      let results = await tester.run();
      console.dir(results, { depth: null });
      final_data = {}

      for(var i=0; i< items.length; i++){
        final_data[addreses[items[i]]] = results[i][0]["results"]
      }

      console.dir(final_data, { depth: null });


      axios.post('https://protected-peak-85531.herokuapp.com/save_100_addresses', { 'final_data':final_data })
      .then(function (response) {
        console.log(response)
      })
      .catch(function (error) {
          console.log("Erorr in saving data");
      });



    })();
  })
    .catch(function (error) {
        console.log(error);
        console.log("Error somewhere");
    });