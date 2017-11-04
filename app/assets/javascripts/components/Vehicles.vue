<template>
  <div>
    <button @click="fetchData()" class="btn btn-primary">Reload</button>
    <br/>
    <div v-for="vehicle in sortedVehicles">
      <div>Name: {{ vehicle.name }}</div>
      <div>Time: {{ vehicle.time }}sec</div>
      <hr/>
    </div>
  </div>
</template>

<script>
module.exports = {
  data () {
    return {
      vehicles: []
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.$http.get(`/api/stops/${this.$route.params.id}`).then(response => {
        console.log(response)
        this.vehicles = response.body.vehicles
      }, response => {
      })
    }
  },
  computed: {
    sortedVehicles: function() {
      function compare(a, b) {
        if (a.time < b.time)
          return -1;
        if (a.time > b.time)
          return 1;
        return 0;
      }
      return this.vehicles.sort(compare)
    }
  },
}
</script>
