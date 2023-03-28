// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./StringCon.sol";

// library StringUtils {
//     function concatenate(string memory a, uint b) internal pure returns (string memory) {
//         return string(abi.encodePacked(a, b.toString()));
//     }
// }


contract TicketSystem {

    // using StringUtils for string;

    // function concatenateStringAndNumber(string memory a, uint b) public pure returns (string memory) {
    //     return a.concatenate(b);
    // }


    struct Event {
        uint256 id;
        string name;
        address seller;
        uint256 resellPriceMaxFactor; // ticket for resell can be sold at max resellPriceMaxFactor% original price, e.g. 150 means max resell price is 150% of original price
        bool returnable; // ticket can be returned to seller
        uint256 buybackBonus; // if ticket is removed, seller have to buy back with ticket's current price + buybackBonus
        bool buybackAble; // whether seller can force buy back ticket at a higher price
    }

    enum TicketTier {
        Regular,
        VIP
    }

    struct Ticket {
        uint256 id;
        uint256 eventId;
        address owner;
        uint256 originalPrice;
        uint256 price;
        TicketTier tier;
        bool available; // owner of ticket is reselling it
    }

    uint256 public eventCount = 0;
    uint256 public ticketCount = 0;

    Ticket[] public tickets;
    Event[] public events;

    constructor() {
        for (uint i = 0; i < 5; i++) {
            createEvent(Strings.append("concert", i), 100, 100, true, true);
        }

        for (uint256 i = 0; i < 5; i++) {
            createTicket(0, 10, TicketTier.Regular);
        }
        for (uint256 i = 0; i < 5; i++) {
            createTicket(0, 20, TicketTier.VIP);
        }
    }

    // the avaiable event is to notify the network that a ticket is available for sale, so that people do not need to query all tickets
    event TicketAvailable(
        uint256 ticketId,
        uint256 eventId,
        address owner,
        uint256 price,
        TicketTier tier
    );
    event TicketSold(
        uint256 ticketId,
        uint256 eventId,
        address seller,
        address buyer,
        uint256 price
    );

    // create an event with msg sender and return event id
    function createEvent(
        string memory name,
        uint256 resellPriceMaxFactor,
        uint256 buybackBonus,
        bool returnable,
        bool buybackAble
    ) public returns (uint256) {
        Event memory evt = Event(
            eventCount,
            name,
            msg.sender,
            resellPriceMaxFactor,
            returnable,
            buybackBonus,
            buybackAble
        );
        events.push(evt);
        eventCount++;
        return eventCount;
    }

    // get all events
    function getEvents() public view returns (Event[] memory) {
        return events;
    }

    // seller create tickets, make ticket available
    function createTicket(
        uint256 eventId,
        uint256 price,
        TicketTier tier
    ) public {
        require(eventId <= eventCount, "Event not found");
        Event storage evt = events[eventId];
        require(msg.sender == evt.seller, "Only seller can create ticket");
        Ticket memory ticket = Ticket(
            ticketCount,
            eventId,
            msg.sender,
            price,
            price,
            tier,
            true
        );
        tickets.push(ticket);
        ticketCount++;
        emit TicketAvailable(ticketCount, eventId, msg.sender, price, tier);
    }

    function getAllTicket() public view returns (Ticket[] memory) {
        return tickets;
    }

    // anyone can buy a ticket, transfer money from msg.sender to ticket owner
    function buyTicket(uint256 ticketId) public payable {
        require(ticketId <= ticketCount, "Ticket not found");
        Ticket storage ticket = tickets[ticketId];
        require(ticket.available, "Ticket not available");
        require(msg.value == ticket.price, "Incorrect payment amount");
        payable(ticket.owner).transfer(msg.value);
        ticket.available = false;
        emit TicketSold(
            ticketId,
            ticket.eventId,
            ticket.owner,
            msg.sender,
            ticket.price
        );
    }

    function getTicketCountByTier(uint256 eventId, TicketTier tier)
        public
        view
        returns (uint256)
    {
        uint256 count = 0;
        for (uint256 i = 1; i <= ticketCount; i++) {
            Ticket memory ticket = tickets[i];
            if (ticket.eventId == eventId && ticket.tier == tier) {
                count++;
            }
        }
        return count;
    }

    // return ticket to seller, only if ticket is returnable. Refund is the original price
    function returnTicket(uint256 ticketId) public {
        require(ticketId <= ticketCount, "Ticket not found");
        Ticket storage ticket = tickets[ticketId];
        require(
            msg.sender == ticket.owner,
            "Only ticket owner can return ticket"
        );
        Event storage evt = events[ticket.eventId];
        require(evt.returnable, "Ticket not returnable");
        payable(evt.seller).transfer(ticket.originalPrice);
        ticket.owner = evt.seller; // reset ticket owner to seller
        ticket.price = ticket.originalPrice; // reset ticket listed price to original price
        ticket.available = true; // ticket is still available for resell
        emit TicketAvailable(
            ticketId,
            ticket.eventId,
            evt.seller,
            ticket.originalPrice,
            ticket.tier
        );
    }

    // function getTicketsForEvent(uint eventId, TicketTier tier) public view returns (Ticket [] memory) {
    //   Ticket [] memory _tickets;
    //   uint count = 0;
    //   for (uint i = 1; i <= ticketCount; i++) {
    //     Ticket memory ticket = tickets[i];
    //     if (ticket.eventId == eventId && ticket.tier == tier) {
    //       // _tickets[count] = ticket;
    //       _tickets.push(ticket);
    //       count++;
    //     }
    //   }
    //   return _tickets;
    // }

    // list ticket for resell, make it available
    function resellTicket(uint256 ticketId, uint256 price) public {
        require(ticketId <= ticketCount, "Ticket not found");
        Ticket storage ticket = tickets[ticketId];
        require(
            msg.sender == ticket.owner,
            "Only ticket owner can resell ticket"
        );
        Event storage evt = events[ticket.eventId];
        require(
            price <= (ticket.originalPrice * evt.resellPriceMaxFactor) / 100,
            "Resell price too high"
        );
        ticket.price = price;
        ticket.available = true;
        emit TicketAvailable(
            ticketId,
            ticket.eventId,
            msg.sender,
            price,
            ticket.tier
        );
    }

    // seller can force buy back ticket, but have to pay current price + buybackBonus. Only ticket's event seller can buy back
    function buyback(uint256 ticketId) public {
        require(ticketId <= ticketCount, "Ticket not found");
        Ticket storage ticket = tickets[ticketId];
        Event storage evt = events[ticket.eventId];
        require(
            msg.sender == evt.seller,
            "Only event seller can buy back ticket"
        );
        require(evt.buybackAble, "Buy back not allowed for this event");
        payable(ticket.owner).transfer(ticket.price + evt.buybackBonus);
        ticket.owner = evt.seller; // reset ticket owner to seller
        ticket.price = ticket.originalPrice; // reset ticket listed price to original price
        ticket.available = false; // by default, ticket is not available after buy back, seller can resell it
    }
}
