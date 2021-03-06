/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1641449796218_6807';

  // add your middleware config here
  config.middleware = [];
  config.mysql = {
    // database configuration
    client: {
      // host
      host: 'localhost',
      // port
      port: '3306',
      // username
      user: 'root',
      // password
      password: '12345678',
      // database
      database: 'react_blog',
    },
    // load into app, default is open
    app: true,
    // load into agent, default is close
    agent: false,
  };
  // add your user config here

  config.security = {
    csrf: {
      enable: false,
    },
    // domainWhiteList: [ '*' ]
    domainWhiteList: [ 'http://127.0.0.1:3001', 'http://127.0.0.1:3000', 'http://127.0.0.1:7001' ],
  };
  config.cors = {
    // origin: 'http://localhost:3000',
    origin: ctx => ctx.get('origin'),
    credentials: true, // 允许Cook可以跨域
    allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH,OPTIONS',
  };
  config.jwt = {
    secret: '123456',
  };

  const userConfig = {
    // myAppName: 'egg',
  };

  return {
    ...config,
    ...userConfig,
  };
};
