// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract TicketSystem {

  struct Event {
    uint id;
    address seller;
    uint nTickets;  // finite number of ticket in an event
  }

  enum TicketTier {Regular, VIP}

  struct Ticket {
    uint id;
    uint eventId;
    address owner;
    uint price;
    TicketTier tier;
  }


  uint public eventCount = 0;
  uint public ticketCount = 0;

  mapping(uint => Ticket) public tickets;
  mapping(uint => Event) public events;

  // create an event with msg sender and return event id
  function createEvent(uint nTicket) public returns (uint) {
    eventCount++;
    Event memory evt = Event(eventCount, msg.sender, nTicket);
    events[eventCount] = evt;
    return eventCount;
  }

  // create ticket of event and return ticket id
  // function createTicket(uint eventId) public returns (uint) {
  //   require(events.contains(eventId), "Event Doesn't Exist");
  //   Event memory targetEvt = events[eventId];

  // }
  
}
