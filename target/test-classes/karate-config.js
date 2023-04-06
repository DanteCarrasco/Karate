function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'xavier@hola.com',
    config.userPassword = 'Xavier3012'
  } else if (env == 'qa') {
    config.userEmail = 'xavierC@hola.com',
    config.userPassword = 'Xavier0306'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization:'Token ' + accessToken})

  return config;
}