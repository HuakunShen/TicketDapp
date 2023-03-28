<template>
  <div class="card w-96 bg-neutral text-neutral-content">
    <div class="card-body">
      <h1 class="text-xl mb-3">Create Ticket</h1>
      <div class="form-control">
        <label class="input-group input-group-md">
          <span>Event ID</span>
          <input
            type="number"
            placeholder="Type here"
            class="input input-bordered input-md"
            v-model="ticketPayload.eventId"
          />
        </label>
      </div>

      <div class="form-control">
        <label class="input-group input-group-md">
          <span>Price</span>
          <input
            type="number"
            placeholder="Type here"
            class="input input-bordered input-md"
            v-model="ticketPayload.price"
          />
        </label>
      </div>

      <div class="form-control">
        <label class="input-group input-group-md">
          <span>Ticket Tier</span>
          <input
            type="number"
            placeholder="Type here"
            class="input input-bordered input-md"
            v-model="ticketPayload.tier"
          />
        </label>
      </div>
      <button class="btn btn-primary" @click="createTicket">Submit</button>
    </div>
  </div>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

const ticketPayload = reactive({
  eventId: 0,
  price: 100,
  tier: 1,
});

async function createTicket() {
  const res = await TicketSystemContract.methods
    .createTicket(
      ticketPayload.eventId,
      ticketPayload.price,
      ticketPayload.tier
    )
    .send({ from: $store.curAccount, gasPrice: 276314047, gas: 3000000 });
  console.log(res);
}
</script>
