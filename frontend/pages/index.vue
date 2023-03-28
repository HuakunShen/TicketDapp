<script lang="ts" setup></script>

<template>
  <NuxtLayout>
    <div class="grid grid-cols-3 gap-4">
      <CreateEvent />
      <CreateTicket />
      <BuyTicket />
      <SellTicket />
      <ReturnTicket />
      <BuyBackEvent />
    </div>
    <div class="gird grid-cols-2 mt-2">
      <MyTicketList />
      <!-- <EventList /> -->
      <TicketList />
    </div>
  </NuxtLayout>
</template>
