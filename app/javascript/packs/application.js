import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    components: { App },
  });

  return app;
});
