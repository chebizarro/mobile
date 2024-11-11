Feature: Taking a Sell Order

  Scenario: Buyer initiates a sell order
    Given the order amount is "0"
    And the order ID is "ede61c96-4c13-4519-bf3a-dcf7f1e9d842"
    When the buyer sends a "take-sell" message in a Gift wrap Nostr event to Mostro
    Then Mostro should receive a Nostr event with:
      | id            | cade205b849a872d74ba4d2a978135dbc05b4e5f483bb4403c42627dfd24f67d |
      | kind          | 1059                                                             |
      | pubkey        | 9a42ac72d6466a6dbe5b4b07a8717ee13e55abb6bdd810ea9c321c9a32ee837b |
      | content       | sealed-rumor-content                                             |
      | created_at    | 1234567890                                                       |
      | sig           | a21eb195fe418613aa9a3a8a78039b090e50dc3f9fb06b0f3fe41c63221adc07 |

  Scenario: Mostro responds with LN invoice request
    Given the order amount is "0"
    And the order ID is "ede61c96-4c13-4519-bf3a-dcf7f1e9d842"
    When Mostro needs to calculate the amount of sats for the order
    Then Mostro sends a message requesting a lightning invoice with the correct amount:
      """
      {
        "order": {
          "version": 1,
          "id": "ede61c96-4c13-4519-bf3a-dcf7f1e9d842",
          "action": "add-invoice",
          "content": {
            "order": {
              "id": "ede61c96-4c13-4519-bf3a-dcf7f1e9d842",
              "amount": 7851,
              "fiat_code": "VES",
              "fiat_amount": 100,
              "payment_method": "face to face",
              "premium": 1,
              "buyer_pubkey": null,
              "seller_pubkey": null
            }
          }
        }
      }
      """
    And Mostro updates the addressable event with status "waiting-buyer-invoice"

  Scenario: Buyer sends LN invoice back to Mostro
    Given the buyer has received the LN invoice request from Mostro
    And the buyer has generated a lightning invoice with ID "ede61c96-4c13-4519-bf3a-dcf7f1e9d842"
    When the buyer sends a Gift wrap Nostr event to Mostro with the lightning invoice
    Then the Nostr event should contain:
      """
      {
        "order": {
          "version": 1,
          "id": "ede61c96-4c13-4519-bf3a-dcf7f1e9d842",
          "action": "add-invoice",
          "content": {
            "payment_request": [
              null,
              "lnbcrt1pn9dvx0pp5935mskms2uf8wx90m8dlr60ytwn5vxy0e65ls42h7y7exweyvekqdqqcqzzsxqyz5vqsp5xjmllv4ta7jkuc5nfgqp8qjc3amzfewmlycpkkggr7q2y5mjfldq9qyyssqncpf3vm8hwujutqc99f0vy45zh8es54mn6u99q9t6rwm0q80dxszskzrp24y46lxqkc7ly9p80t6lalc8x8xhsn49yhy70a7wqyygugpv7chqs",
              3922
            ]
          }
        }
      }
      """
    And the amount is set to "3922" if known, otherwise "null"

  Scenario: Mostro acknowledges the buyer's LN invoice
    Given Mostro has received the buyer's lightning invoice
    When Mostro verifies the invoice content
    Then Mostro responds with a Nostr event indicating:
      """
      {
        "order": {
          "version": 1,
          "id": "ede61c96-4c13-4519-bf3a-dcf7f1e9d842",
          "action": "waiting-seller-to-pay",
          "content": null
        }
      }
      """
    And Mostro updates the addressable event with status "waiting-payment"
