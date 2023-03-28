<template>
  <h1>Accounts</h1>
  <ul>
    <li v-for="account in $store.accounts" :key="account">
      <button
        :class="`btn btn-block mt-3 ${
          $store.curAccount == account ? 'btn-success' : ''
        }`"
        @click="() => selectAccount(account)"
      >
        {{ account }}
      </button>
    </li>
  </ul>
</template>
<script lang="ts" setup>
const { $store } = useNuxtApp();

function selectAccount(account: string) {
  console.log(account);

  $store.setCurAccount(account);
}
</script>
