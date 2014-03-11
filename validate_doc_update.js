var __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

(function(doc, old, userCtx, secObj) {
  var exists, organization, owner, unchanged, verify;
  verify = function(field, value) {
    if (doc[field] !== value) {
      throw {
        forbidden: "you are passing wrong information"
      };
    }
  };
  exists = function(field) {
    if (!(field in doc)) {
      throw {
        forbidden: "must have `" + field + "`"
      };
    }
  };
  unchanged = function(field) {
    if (doc[field] !== old[field]) {
      throw {
        forbidden: "`" + field + "` cannot change"
      };
    }
  };
  owner = function(field) {
    if (doc.owner !== userCtx.name && doc[field] !== old[field]) {
      throw {
        unauthorized: "only the owner can change `" + field + "`"
      };
    }
  };
  organization = function(field) {
    var _ref;
    if ((_ref = doc.organization, __indexOf.call(userCtx.roles, _ref) < 0) && doc.owner !== userCtx.name) {
      if (field === '*') {
        throw {
          unauthorized: "only members of the organization \n`" + doc.organization + "` can update this doc"
        };
      }
      if (doc[field] !== old[field]) {
        throw {
          unauthorized: "only members of the organization \n`" + doc.organization + "` can change `" + field + "`"
        };
      }
    }
  };
  if (doc.type === 'anything') {
    exists('owner');
    exists('updater');
    exists('created');
    verify('updater', userCtx.name);
    if (old) {
      unchanged('owner');
      owner('organization');
      owner('_deleted');
      return organization('*');
    } else {
      verify('owner', userCtx.name);
      return verify('organization', userCtx.roles[0]);
    }
  }
});
