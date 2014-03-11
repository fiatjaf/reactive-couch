var deps, factory;

deps = ['lib/superagent', 'lib/lodash', 'lib/react', 'lib/history', 'lib/today'];

factory = function(request, _, React, History, today, require) {
  var ListComponent, Results, a, button, dd, div, dl, dt, fieldset, form, h1, h2, h3, hr, input, label, legend, p, span, style, table, td, textarea, th, tr, _ref;
  _ref = React.DOM, style = _ref.style, button = _ref.button, div = _ref.div, span = _ref.span, a = _ref.a, p = _ref.p, hr = _ref.hr, dl = _ref.dl, dt = _ref.dt, dd = _ref.dd, label = _ref.label, fieldset = _ref.fieldset, legend = _ref.legend, table = _ref.table, tr = _ref.tr, th = _ref.th, td = _ref.td, h1 = _ref.h1, h2 = _ref.h2, h3 = _ref.h3, form = _ref.form, input = _ref.input, textarea = _ref.textarea;
  ListComponent = React.createClass({
    displayName: 'ListResults',
    getInitialState: function() {
      return {
        list: this.props.listOfSomeKindOfThing
      };
    },
    reload: function(viewparams, e) {
      var query, self;
      viewparams.include_docs = true;
      query = _.pairs(viewparams).map(function(pair) {
        return pair.join('=');
      }).join('&');
      History.to("/someKindOfThing?" + query);
      self = this;
      request.get("/_list/standardListOfSomeKindOfThing/someKindOfThing").set('Accept', 'application/json').query(viewparams).end(function(res) {
        return self.setState({
          list: res.body
        });
      });
      return e.preventDefault();
    },
    render: function() {
      return div({}, button({
        onClick: this.reload.bind(this)
      }, {
        startkey: [2014, null]
      }, 'newer results'), button({
        onClick: this.reload.bind(this)
      }, {
        endkey: [2013, {}]
      }, 'older results'), Results({
        results: this.state.list
      }));
    }
  });
  Results = React.createClass({
    displayName: 'Results',
    showItem: function(thingid, e) {
      return ee.emit('showThing', thingid);
    },
    render: function() {
      var thing;
      return table({}, h1({}, 'things of some kind'), ul({}, (function() {
        var _i, _len, _ref2, _results;
        _ref2 = this.props.results;
        _results = [];
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          thing = _ref2[_i];
          _results.push(li({
            ref: thing._id,
            onClick: this.showItem.bind(this, thing._id)
          }, thing.value));
        }
        return _results;
      }).call(this)));
    }
  });
  return ListComponent;
};

if (typeof define === 'function' && define.amd) {
  define(deps, factory);
} else if (typeof exports === 'object') {
  module.exports = factory.apply(this, deps.map(require));
}
