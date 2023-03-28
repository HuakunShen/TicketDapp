<template>
  <div class="card w-96 bg-neutral text-neutral-content">
    <div class="card-body">
      <h1 class="text-xl mb-3">Buy Back Ticket</h1>
      <div class="form-control">
        <label class="input-group input-group-md">
          <span>Event ID</span>
          <input
            type="number"
            placeholder="Type here"
            class="input input-bordered input-md"
            v-model="eventId"
          />
        </label>
      </div>
      <small>To buy back all tickets, it will cost you more than the original price of the tickets.</small>
      <button class="btn btn-secondary" @click="buy">Estimate Cost</button>
      <button class="btn btn-primary" @click="buy">Submit</button>
    </div>
  </div>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

const eventId = ref(0);
function buy() {
  // TicketSystemContract.methods
  //   .buy(eventId)
  //   .send({ from: $store.curAccount })
  //   .then(() => {
  //     alert("Success");
  //   })
  //   .catch((err: any) => {
  //     alert(err);
  //   });
}
</script>
