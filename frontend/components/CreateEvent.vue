<template>
  <h1 class="text-xl mb-3">Create Event</h1>
  <div class="grid grid-cols-1 gap-3">
    <div class="form-control">
      <label class="input-group input-group-md">
        <span>Name</span>
        <input
          type="text"
          placeholder="Type here"
          class="input input-bordered input-md"
          v-model="name"
        />
      </label>
    </div>
    <div class="form-control">
      <label class="input-group input-group-md">
        <span>Resell Price Max Factor</span>
        <input
          type="number"
          placeholder="Type here"
          class="input input-bordered input-md"
          v-model="resellPriceMaxFactor"
        />
      </label>
    </div>
    <div class="form-control">
      <label class="input-group input-group-md">
        <span>Buy Back Bonus</span>
        <input
          type="number"
          placeholder="Type here"
          class="input input-bordered input-md"
          v-model="buybackBonus"
        />
      </label>
    </div>
    <div class="form-control">
      <label for="buybackAble"
        >Buy Back Bonus
        <input
          type="checkbox"
          id="buybackAble"
          v-model="buybackAble"
          class="checkbox translate-y-2"
        />
      </label>
    </div>

    <div class="form-control">
      <label for="returnable"
        >Returnable
        <input
          type="checkbox"
          id="returnable"
          v-model="returnable"
          class="checkbox translate-y-2"
        />
      </label>
    </div>
  </div>
  <!-- <p>{{ buybackAble }}</p>
  <p>{{ returnable }}</p>
  <p>{{ resellPriceMaxFactor }}</p>
  <p>{{ buybackBonus }}</p>
  <p>{{ name }}</p> -->
  <button class="btn btn-primary" @click="createEvent">Submit</button>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

const buybackAble = ref(false);
const returnable = ref(false);
const resellPriceMaxFactor = ref(100);
const buybackBonus = ref(100);
const name = ref("");

const createEvent = async () => {
  let balance = await TicketSystemContract.methods.getBalance().call();
  console.log(balance);

  let res = await TicketSystemContract.methods
    .setBalance(130)
    .send({ from: $store.curAccount });
  console.log(res);

  balance = await TicketSystemContract.methods.getBalance().call();
  console.log(balance);

  TicketSystemContract.methods
    .createEvent(
      name.value,
      resellPriceMaxFactor.value,
      buybackBonus.value,
      returnable.value,
      buybackAble.value
    )
    .send({ from: $store.curAccount })
    .then((createEventRes: unknown) => {
      console.log(createEventRes);
    })
    .catch((err: unknown) => {
      console.log(err);
    });

  //   TicketSystemContract.methods
  //     .createEvent(
  //       name.value,
  //       resellPriceMaxFactor.value,
  //       buybackBonus.value,
  //       returnable.value,
  //       buybackAble.value
  //     )
  //     .call()
  //     .then((res: any) => {
  //       console.log(res);
  //     })
  //     .catch((err: unknown) => {
  //       console.error(err);
  //     });
};
</script>
<!-- name, uint resellPriceMaxFactor, uint buybackBonus, bool returnable, bool buybackAble -->
