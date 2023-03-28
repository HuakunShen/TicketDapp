<template>
  <button @click="reloadEvents" class="btn btn-primary">Refresh Events</button>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

function reloadEvents() {
  TicketSystemContract.methods
    .getEvents()
    .call()
    .then((events: any) => {
      console.log(events);
      // $store.setEvents(events);
    });
}

reloadEvents();
</script>
