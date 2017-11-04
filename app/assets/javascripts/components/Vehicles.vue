<template>
  <div>
    <div class="reload-button">
      <button @click="fetchData()" class="btn btn-primary">Reload</button>
    </div>
    <div id="vehicles-list">
      <div v-for="vehicle in sortedVehicles">
        <strong>{{ vehicle.name }}</strong> через {{ fmtMSS(vehicle.time) }}
        <hr/>
      </div>
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
    },
    fmtMSS: (s) => {
      return(s - (s%=60))/60 + (9 < s ? ':' : ':0') + s
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
    },
  },
}

</script>
