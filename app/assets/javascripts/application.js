import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'

Vue.use(VueResource);
Vue.use(VueRouter);

const Stops = Vue.component('stops-component', require('./components/Stops.vue'))
const Vehicles = Vue.component('vehicles-component', require('./components/Vehicles.vue'))

const routes = [
  { path: '/stops/:id', name: 'vehicles', component: Vehicles },
]

const router = new VueRouter({
  routes
})

new Vue({
  router: router,
  data: {
    vueVersion: `${Vue.version}`,
  }
}).$mount('#root')

