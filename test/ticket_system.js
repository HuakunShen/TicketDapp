const TicketSystem = artifacts.require("TicketSystem");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("TicketSystem", function (/* accounts */) {
  it("should assert true", async function () {
    let app = await TicketSystem.deployed();
    console.log(await app.getEvents());
  });
});
