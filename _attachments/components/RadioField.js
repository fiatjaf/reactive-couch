var deps, factory;

deps = ['lib/react'];

factory = function(React) {
  var RadioField, div, input, label, _ref;
  _ref = React.DOM, input = _ref.input, label = _ref.label, div = _ref.div;
  RadioField = React.createClass({
    displayName: 'RadioField',
    handleChange: function(e) {
      if (e.target.checked) {
        return this.props.onChange(this.props.name, e.target.value);
      }
    },
    render: function() {
      var option;
      return div({}, (function() {
        var _i, _len, _ref2, _results;
        _ref2 = this.props.fields;
        _results = [];
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          option = _ref2[_i];
          _results.push(label({}, input({
            type: 'radio',
            key: this.props.name,
            name: this.props.name,
            value: option.value,
            onChange: this.handleChange,
            checked: this.props.value === option.value
          }), option.label));
        }
        return _results;
      }).call(this));
    }
  });
  return RadioField;
};

if (typeof define === 'function' && define.amd) {
  define(deps, factory);
} else if (typeof exports === 'object') {
  module.exports = factory.apply(this, deps.map(require));
}
