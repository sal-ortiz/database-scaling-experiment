

module.exports = {

  get: (obj, property, proxy) => {
    let val = obj.meta.cache.values[property];

    if (obj[property] && obj[property].constructor == Function) {
      return obj[property].bind(obj);
    }

    if (!val) {
      let handle = obj.meta.cache.values.handle;

      if (handle) {
        let url = obj.constructor.meta.configuration.url;
        let element = obj.constructor.meta.configuration.element;
        let timeout = obj.constructor.meta.configuration.timeout;

        let val = obj.constructor.getValue(
          url, element, property, handle, timeout
        );

        obj.meta.cache.values[property] = val;

        return val;
      }

    }

    return val;
  },

  set: (obj, property, val, proxy) => {
    let url = obj.constructor.meta.configuration.url;
    let element = obj.constructor.meta.configuration.element;
    let timeout = obj.constructor.meta.configuration.timeout;

    if (property == 'handle') {
      let values = obj.constructor.getAllValues(
        url, element, val, timeout
      );

      for (let id in values) {

        if (obj.meta.cache.values[id] === undefined) {
          obj.meta.cache.values[id] = values[id];
        }

      }

      return true;
    }

    let handle = obj.meta.cache.values.handle;

    if (handle) {
      obj.constructor.setValue(
        url, element, property, handle, val, timeout
      );

    }

    obj.meta.cache.values[property] = val;

    return true;
  },

};
