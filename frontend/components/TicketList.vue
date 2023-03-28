<template>
  <button @click="reloadAllTickets" class="btn btn-primary">
    Refresh All Tickets
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
          <td>{{ ticket.origPrice }}</td>
          <td>{{ ticket.price }}</td>
          <td>{{ ticket.tier }}</td>
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
  {
    ticketId: 2,
    eventId: 0,
    origPrice: 10,
    price: 20,
    tier: "Regular",
    available: true,
  },
  {
    ticketId: 3,
    eventId: 1,
    origPrice: 10,
    price: 20,
    tier: "Regular",
    available: true,
  },
];
const tickets = ref(placeHolderTickets);

function reloadAllTickets() {
  TicketSystemContract.methods
    .getAllTicket()
    .call()
    .then((_tickets: any) => {
      // console.log(events);
      tickets.value = _tickets.map((t: any) => ({
        ticketId: t["id"],
        eventId: t.eventId,
        origPrice: t["originalPrice"],
        price: t.price,
        tier: t.tier === "0" ? "Regular" : "VIP",
        available: t.available,
      }));
    });
}

reloadAllTickets();
</script>
