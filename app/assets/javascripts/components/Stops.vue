<template>
  <div id="main">
    <h4>
      Stops ({{Object.keys(filteredStops).length}}):
    </h4>
    <input type="text" v-model="search" class="form-control" />

    <div class="row">
      <div class="col-md-8" id="stops">
        <div v-for="stop in filteredStops">
          <router-link :to="{name: 'vehicles', params: { id: stop.id }}">{{ stop.name }}</router-link>
        </div>
      </div>

      <div class="col-md-4" id="vehicles">
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
