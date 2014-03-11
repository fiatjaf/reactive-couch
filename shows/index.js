
(function(head, req) {
  return {
    code: 302,
    headers: {
      location: 'things?include_docs'
    }
  };
});
