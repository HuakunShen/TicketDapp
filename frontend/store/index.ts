import { defineStore } from "pinia";

type Event = {
  id: number;
  name: string;
  seller: string;
  resellPriceMaxFactor: number;
  returnable: boolean;
  buybackBonus: number;
  buybackAble: boolean;
};

type State = {
  accounts: string[];
  curAccount: string | undefined;
  events: Event[];
};

export const useMainStore = defineStore("main", {
  state: (): State => ({
    accounts: [],
    curAccount: undefined,
    events: [],
  }),
  actions: {
    setAccounts(accounts: string[]) {
      this.accounts = accounts;
    },
    setCurAccount(account: string) {
      this.curAccount = account;
    },
    setEvents(events: Event[]) {
      this.events = events;
    },
  },
});
