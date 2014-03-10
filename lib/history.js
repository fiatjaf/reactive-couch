var deps, factory;

deps = [];

factory = function() {
  window.addEventListener('popstate', function(e) {
    if (e.state && e.state.pushed) return location.reload();
  });
  return {
    to: function(address) {
      if (window.history && window.history.pushState) {
        return window.history.pushState({
          pushed: true
        }, null, address);
      } else {
        return location.href = address;
      }
    }
  };
};

if (typeof define === 'function' && define.amd) {
  define(deps, factory);
} else if (typeof exports === 'object') {
  module.exports = {};
}
