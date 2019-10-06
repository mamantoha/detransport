import Vue from 'vue/dist/vue.esm'
import axios from 'axios';
import VueRouter from 'vue-router'
import 'bootstrap';

Vue.prototype.$axios = axios
Vue.use(VueRouter);

const Stops = Vue.component('stops-component', require('./components/Stops.vue').default)
const Vehicles = Vue.component('vehicles-component', require('./components/Vehicles.vue').default)

const routes = [
  { path: '/stops/:id', name: 'vehicles', component: Vehicles, props: true },
]

const router = new VueRouter({
  routes
})

new Vue({
  router: router,
  data: {
    vueVersion: `${Vue.version}`,
  }
}).$mount('#app')
