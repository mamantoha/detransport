<template>
  <div id="main">
    <div class="search-bar">
      <h4>
        Stops ({{Object.keys(filteredStops).length}}):
      </h4>
      <input type="text" v-model="search" class="form-control" />
    </div>

    <div class="row">
      <div class="col" id="stops">
        <div v-for="stop in filteredStops" :key="stop.id">
          <div class="stop">
            <router-link :to="{name: 'vehicles', params: { id: decodeURIComponent(stop.id) }}">
              {{ stop.name }}
            </router-link>
          </div>
        </div>
      </div>

      <div class="col" id="vehicles">
        <router-view></router-view>
      </div>
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
      this.$axios.get('/api/stops').then(response => {
        this.stops = response.data.stops
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
