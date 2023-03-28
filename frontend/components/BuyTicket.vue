<template>
  <div class="card w-96 bg-neutral text-neutral-content">
    <div class="card-body">
      <h1 class="text-xl mb-3">Buy Ticket</h1>
      <div class="form-control">
        <label class="input-group input-group-md">
          <span>Ticket ID</span>
          <input
            type="number"
            placeholder="Type here"
            class="input input-bordered input-md"
            v-model="ticketId"
          />
        </label>
        <label class="input-group input-group-md">
          <span>Value</span>
          <input
            type="number"
            placeholder="Type here"
            class="input input-bordered input-md"
            v-model="value"
          />
        </label>
      </div>
      <button class="btn btn-primary" @click="buy">Submit</button>
    </div>
  </div>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

const ticketId = ref(0);
const value = ref(10);
function buy() {
  console.log({
    ticketId: ticketId.value,
    value: value.value,
  });

  TicketSystemContract.methods
    .buyTicket(ticketId.value)
    .send({
      from: $store.curAccount,
      value: 10,
      gasPrice: 276314047,
      gas: 3000000,
    })
    .then(() => {
      alert("Success");
    })
    .catch((err: any) => {
      alert(err);
    });
}
</script>
