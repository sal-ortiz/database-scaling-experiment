

module.exports = {

  get: (obj, key, proxy) => {
    let val = obj.meta.cache.values[key];

    if (obj[key] && obj[key].constructor == Function) {
      return obj[key].bind(obj);
    }

    if (!val) {
      let handle = obj.meta.cache.values.handle;

      if (handle) {
        let url = obj.constructor.meta.configuration.url;
        let schema = obj.constructor.meta.configuration.schema;
        let timeout = obj.constructor.meta.configuration.timeout;

        let val = obj.constructor.getValue(
          url, schema, key, handle, timeout
        );

        obj.meta.cache.values[key] = val;

        return val;
      }

    }

    return val;
  },

  set: (obj, key, val, proxy) => {
    let url = obj.constructor.meta.configuration.url;
    let schema = obj.constructor.meta.configuration.schema;
    let timeout = obj.constructor.meta.configuration.timeout;

    if (key == 'handle') {
      let values = obj.constructor.getAllValues(
        url, schema, val, timeout
      );

      for (let key in values) {

        if (obj.meta.cache.values[key] === undefined) {
          obj.meta.cache.values[key] = values[key];
        }

      }

      return true;
    }

    let handle = obj.meta.cache.values.handle;

    if (handle) {
      obj.constructor.setValue(
        url, schema, key, handle, val, timeout
      );

    }

    obj.meta.cache.values[key] = val;

    return true;
  },

};
