<template>
  <div>
    <button @click="loadStops()">Reload stops</button>
    <h4>
      Stops ({{Object.keys(filteredStops).length}}):
    </h4>
    <input type="text" v-model="search" class="form-control" />

    <div v-for="stop in filteredStops">
      {{ stop.name }}
    </div>
  </div>
</template>

<script>
module.exports = {
  data: function() {
    return {
      search: '',
      stops: []
    }
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

}
</script>
