var deps, factory;

deps = ['lib/superagent', 'lib/lodash', 'lib/react'];

factory = function(request, _, React, RadioField) {
  var Thing, a, button, dd, div, dl, dt, fieldset, form, h1, h2, h3, hr, input, label, legend, p, span, style, table, td, textarea, th, tr, _ref;
  _ref = React.DOM, style = _ref.style, button = _ref.button, div = _ref.div, span = _ref.span, a = _ref.a, p = _ref.p, hr = _ref.hr, dl = _ref.dl, dt = _ref.dt, dd = _ref.dd, label = _ref.label, fieldset = _ref.fieldset, legend = _ref.legend, table = _ref.table, tr = _ref.tr, th = _ref.th, td = _ref.td, h1 = _ref.h1, h2 = _ref.h2, h3 = _ref.h3, form = _ref.form, input = _ref.input, textarea = _ref.textarea;
  return Thing = React.createClass({
    getInitialState: function() {
      return {
        thing: this.props.thing || {}
      };
    },
    componentDidMount: function() {
      var self;
      self = this;
      return ee.on('showThing', function(thingid) {
        request.get("/_shows/displayThing/" + thingid).set('Accept', 'application/json').end(function(res) {
          return self.setState({
            thing: res.body
          });
        });
        self.setState({
          thing: thing
        });
        return History.to("/thing/" + thing._id);
      });
    },
    render: function() {
      var thing;
      thing = this.state.thing;
      if (thing._id) {
        return div({}, h2({}, thing.title), dt({}, 'Property'), dd({}, thing.property), dt({}, 'Kind'), dd({}, thing.kind), dt({}, 'Value'), dd({}, thing.value));
      } else {
        return div({
          style: 'display: none'
        });
      }
    }
  });
};

if (typeof define === 'function' && define.amd) {
  define(deps, factory);
} else if (typeof exports === 'object') {
  module.exports = factory.apply(this, deps.map(require));
}
