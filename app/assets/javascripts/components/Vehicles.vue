<template>
  <div>
    <strong>{{ stopName }}</strong>
    <div class="reload-button">
      <button @click="fetchData()" class="btn btn-primary" :disabled=isLoading>
        {{ isLoading ? "Loading" : "Reload" }}
      </button>
    </div>
    <div id="vehicles-list">
      <div class="vehicle" v-for="vehicle in sortedVehicles" :key="vehicle.id">
        <strong>{{ vehicle.name }}</strong> через {{ fmtMSS(vehicle.time) }}
      </div>
    </div>
  </div>
</template>

<script>
module.exports = {
  data () {
    return {
      vehicles: [],
      isLoading: false
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
      this.isLoading = true
      this.$http.get(`/api/stops/${this.$route.params.id}`).then(response => {
        console.log(response)
        this.isLoading = true
        this.vehicles = response.body.vehicles
        this.isLoading = false
      }, response => {
        // error callback
        console.log(response)
        this.isLoading = false
      })
    },
    fmtMSS: (s) => {
      return(s - (s%=60))/60 + (9 < s ? ':' : ':0') + s
    },
  },
  computed: {
    stopName: function() {
      function findStopById(stops, id) {
        for (var i = 0; i < stops.length; i++) {
          if (stops[i]["id"] === id) {
              return stops[i];
          }
        }
        return null;
      }

      stop = findStopById(this.$parent.stops, this.$route.params.id)
      return stop ? stop.name : ""
    },
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
