<template>
  <button @click="reloadAllTickets" class="btn btn-primary">
    Refresh My Tickets
  </button>
  <div class="overflow-x-auto mt-4">
    <table class="table w-full">
      <thead>
        <tr>
          <th>Ticket Id</th>
          <th>Event Id</th>
          <th>Original Price</th>
          <th>Price</th>
          <th>Tier</th>
          <th>Available</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="ticket in tickets">
          <th>{{ ticket.ticketId }}</th>
          <td>{{ ticket.eventId }}</td>
          <td>{{ ticket.eventId }}</td>
          <td>{{ ticket.origPrice }}</td>
          <td>{{ ticket.price }}</td>
          <td>{{ ticket.available }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

const placeHolderTickets = [
  {
    ticketId: 0,
    eventId: 0,
    origPrice: 20,
    price: 30,
    tier: "VIP",
    available: true,
  },
  {
    ticketId: 1,
    eventId: 0,
    origPrice: 20,
    price: 20,
    tier: "VIP",
    available: true,
  },
];
const tickets = ref(placeHolderTickets);

function reloadAllTickets() {
  //   TicketSystemContract.methods
  //     .getTickets()
  //     .call()
  //     .then((events: any) => {
  //       console.log(events);
  //       // $store.setEvents(events);
  //     });
}

reloadAllTickets();
</script>
