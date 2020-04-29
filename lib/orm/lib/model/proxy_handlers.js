

module.exports = {

  get: (obj, key, proxy) => {
    let meta = obj.meta;
    let cfg = meta.configuration;
    let cache = meta.cache;

    let val = cache.values[key];

    if (obj[key] && obj[key].constructor == Function) {
      return obj[key].bind(obj);
    }

    if (!val) {
      let handle = cache.values.handle;

      if (handle) {
        let url = cfg.url;
        let schema = cfg.schema;
        let timeout = cfg.timeout;
        let constr = obj.constructor;

        let val = constr.getValue(url, schema, key, handle, timeout);

        obj.meta.cache.values[key] = val;

        return val;
      }

    }

    return val;
  },

  set: (obj, key, val, proxy) => {
    let meta = obj.meta;
    let cfg = meta.configuration;
    let cache = meta.cache;

    let url = cfg.url;
    let schema = cfg.schema;
    let timeout = cfg.timeout;

    let constr = obj.constructor;

    if (key == 'handle') {
      let values = constr.getAllValues(url, schema, val, timeout);

      for (let key in values) {

        if (cache.values[key] === undefined) {
          obj.meta.cache.values[key] = values[key];
        }

      }

      obj.meta.cache.values = values;
      obj.meta.cache.values.handle = val;

      return true;
    }

    let handle = cache.values.handle;

    if (handle) {
      constr.setValue(url, schema, key, handle, val, timeout);

    }

    obj.meta.cache.values[key] = val;

    return true;
  },

};
