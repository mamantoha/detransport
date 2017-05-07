import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'

Vue.use(VueResource);

let app = new Vue({
  el: '#app',
  data: {
    search: '',
    message: `Hello from Vue ${Vue.version}!`,
    stops: []
  },
  methods: {
    loadStops: function() {
      this.$http.get('/api/stops').then(response => {
        this.stops = response.body.stops
        console.log(response)
      }, response => {
        console.log(response)
      })
    }
  },
  computed: {
    filteredStops() {
      return this.stops.filter(stop => {
        return stop.name.toLowerCase().includes(this.search.toLowerCase())
      })
    }
  },
  mounted: function() {
    this.loadStops();
  }
})
