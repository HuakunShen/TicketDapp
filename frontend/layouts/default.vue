<template>
  <div class="grid grid-cols-4 gap-4 mx-5 h-screen pt-3">
    <div class="">
      <AccountList />
      <EventList />
    </div>
    <div class="col-span-3"><slot /></div>
  </div>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();
web3.eth.getAccounts().then((accounts) => {
  $store.setAccounts(accounts);
  if (!$store.curAccount || !accounts.includes($store.curAccount)) {
    $store.setCurAccount(accounts[0]);
  }
});
</script>
