import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'

Vue.use(VueResource);

Vue.component('stops-component', require('./components/Stops.vue'))

new Vue({
  el: '#root',
  data: {
    vueVersion: `${Vue.version}`,
  },
})

