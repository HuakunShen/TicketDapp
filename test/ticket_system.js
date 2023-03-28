const TicketSystem = artifacts.require("TicketSystem");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("TicketSystem", function (/* accounts */) {
  it("Create Event", async function () {
    let app = await TicketSystem.deployed();
    const res = await app.createEvent("concert1", 100, 100, true, false);
    // console.log(res);
    const events = await app.getEvents();
    // console.log(events);
    assert.equal(events.length, 1);
  });

  it("Create Many Events", async function () {
    let app = await TicketSystem.deployed();
    const res = await app.createEvent("concert2", 100, 100, true, false);
    const res2 = await app.createEvent("concert3", 100, 100, true, false);
    const events = await app.getEvents();
    // console.log(events);
    assert.equal(events.length, 3);
  });

  it("Balance", async function () {
    let app = await TicketSystem.deployed();
    let balance = await app.getBalance();
    console.log(balance);
    await app.setBalance(100);
    balance = await app.getBalance();
    console.log(balance["words"][0]);
    // console.log(await app.getBalance());
    // assert.equal(balance, 0);
  });
});
