var deps, factory;

deps = ['lib/react'];

factory = function(React) {
  var RangeField, div, input, label, _ref;
  _ref = React.DOM, input = _ref.input, label = _ref.label, div = _ref.div;
  RangeField = React.createClass({
    displayName: 'RangeField',
    handleChange: function(e) {
      return this.props.onChange(e);
    },
    componentDidMount: function() {
      var elem;
      elem = this.getDOMNode();
      return this.props.reportInputChange({
        target: elem
      });
    },
    render: function() {
      return div({}, label({}, "" + this.props.label + ": ", input({
        type: 'range',
        name: this.props.name,
        min: '1',
        max: '100',
        value: this.props.value || '50',
        onChange: this.handleChange
      })));
    }
  });
  return RangeField;
};

if (typeof define === 'function' && define.amd) {
  define(deps, factory);
} else if (typeof exports === 'object') {
  module.exports = factory.apply(this, deps.map(require));
}
