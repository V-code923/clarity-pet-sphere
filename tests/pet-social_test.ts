import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can create and like posts",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const wallet_1 = accounts.get("wallet_1")!;
    const wallet_2 = accounts.get("wallet_2")!;
    
    let block = chain.mineBlock([
      Tx.contractCall("pet-social", "create-post", [
        types.utf8("My first post about Max!"),
        types.some(types.utf8("QmHash123"))
      ], wallet_1.address),
      Tx.contractCall("pet-social", "like-post", [types.uint(0)], wallet_2.address)
    ]);
    
    assertEquals(block.receipts.length, 2);
    assertEquals(block.receipts[0].result, "(ok u0)");
    assertEquals(block.receipts[1].result, "(ok true)");
  },
});
