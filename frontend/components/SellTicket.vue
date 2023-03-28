<template>
  <div class="card w-96 bg-neutral text-neutral-content">
    <div class="card-body">
      <h1 class="text-xl mb-3">Resell Ticket</h1>
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
      </div>
      <button class="btn btn-primary" @click="buy">Submit</button>
    </div>
  </div>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

const ticketId = ref(0);
function buy() {
  TicketSystemContract.methods
    .resellTicket(ticketId)
    .send({ from: $store.curAccount })
    .then(() => {
      alert("Success");
    })
    .catch((err: any) => {
      alert(err);
    });
}
</script>
