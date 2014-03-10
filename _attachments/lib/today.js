var moment, today;

if (typeof define === 'function' && define.amd) {
  define({});
} else if (typeof exports === 'object') {
  moment = require('lib/moment');
  today = moment();
  module.exports = {
    year: today.format('YYYY'),
    month: today.format('MM'),
    day: today.format('DD')
  };
}
