
curl.config({
  baseUrl: '/_ddoc',
  paths: {
    'lib/lodash': '//cdnjs.cloudflare.com/ajax/libs/lodash.js/2.4.1/lodash.min.js',
    'lib/superagent': '//cdnjs.cloudflare.com/ajax/libs/superagent/0.15.7/superagent.min.js',
    'lib/react': '//cdnjs.cloudflare.com/ajax/libs/react/0.9.0/react-with-addons.js',
    'eventemitter': '/lib/EventEmitter.js',
    'history': '/lib/history.js'
  }
});

curl(['eventemitter'], function(EventEmitter) {
  window.ee = new EventEmitter();
  return curl(['lib/react', 'components/Operacoes', 'components/Despesas'], function(React, Login, SearchResults, Bicho) {
    React.renderComponent(Operacoes(window.data.operacoes), document.getElementById('operacoes'));
    return React.renderComponent(Despesas(window.data.despesas), document.getElementById('despesas'));
  });
});
