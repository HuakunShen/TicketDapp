<template>
  <button @click="reloadEvents" class="btn btn-primary">Refresh Events</button>
  <div class="overflow-x-auto mt-4">
    <table class="table w-full">
      <!-- head -->
      <thead>
        <tr>
          <th>Name</th>
          <th>Event Id</th>
          <th>Seller</th>
          <th>Returnable</th>
          <th>Resell Price Max Factor</th>
          <th>Buyback Bonus</th>
          <th>Buybackable</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="evt in events">
          <th>{{ evt.name }}</th>
          <td>{{ evt.id }}</td>
          <td>{{ evt.seller }}</td>
          <td>{{ evt.returnable }}</td>
          <td>{{ evt.resellPriceMaxFactor }}</td>
          <td>{{ evt.buybackBonus }}</td>
          <td>{{ evt.buybackAble }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script lang="ts" setup>
// import Web3 from "web3";

const { $store } = useNuxtApp();

const placeHolderEvents = [
  {
    name: "Concert 1",
    id: 0,
    seller: "0xabc",
    returnable: true,
    resellPriceMaxFactor: 100,
    buybackBonus: 100,
    buybackAble: true,
  },
  {
    name: "Concert 2",
    id: 0,
    seller: "0xabc",
    returnable: true,
    resellPriceMaxFactor: 150,
    buybackBonus: 100,
    buybackAble: true,
  },
];
const events = ref(placeHolderEvents);

function reloadEvents() {
  // const web3 = new Web3(Web3URL);
  // const TicketSystemContract = new web3.eth.Contract(
  //   contractABI,
  //   contractAddress
  // );

  TicketSystemContract.methods
    .getEvents()
    .call()
    .then((_events: any) => {
      // console.log(events);
      events.value = _events.map((evt: any) => ({
        name: evt["name"],
        id: evt["id"],
        seller: evt["seller"],
        returnable: evt["returnable"],
        resellPriceMaxFactor: evt["resellPriceMaxFactor"],
        buybackBonus: evt["buybackBonus"],
        buybackAble: evt["id"],
      }));
      console.log(events.value);

      // $store.setEvents(events);
    });
}

reloadEvents();
</script>
