# Smart Contract Project with Solidity by Alessandro Ponton  
## Fashion Domain

### Testnet Deployment: https://sepolia.etherscan.io/address/0xe2704aa2c89602ce3bb011aaccd0f6a2d08e6ce4

This Solidity smart contract manages an e-commerce system for selling clothing using Ethereum. The contract allows adding products, tracking sales, and handling purchases in Ether. It is divided into two subcontracts: `ProductManager` and `FashionCommerceManager`, with the latter inheriting functionalities from the former.

## Contract Structure

### 1. `ProductManager` Contract

The `ProductManager` contract serves as the foundation for managing products and sales.

#### Structs:

- **Product**: Stores product information, including ID, name, quantity, and price in Ether.
- **Sale**: Contains the ID of the sold product, the buyer's address, and the timestamp of the sale.

#### Functions:

- **getProductsPurchasedBy**: Returns a list of products purchased by a specific customer.
- **calculateSalesAmount**: Calculates the total sales amount within a specified time range.

### 2. `FashionCommerceManager` Contract

The `FashionCommerceManager` contract extends `ProductManager` and adds functionalities for managing the e-commerce process.

#### State Variables:

- **owner**: The address of the contract owner.
- **products**: An array storing all available products.
- **sales**: An array storing all completed sales.
- **totalSales**: A counter for the total number of recorded sales.

#### Events:

- **SaleRecorded**: Emits an event whenever a new sale is added to the sales array. Includes the sale ID, product ID, buyer's address, and timestamp.

#### Modifiers:

- **onlyOwner**: Restricts access to certain functions to the contract owner.

#### Functions:

- **addProduct**: Allows the owner to add a new product to the catalog, specifying name, quantity, and price in Ether.
- **getProduct**: Retrieves product details based on its ID.
- **purchaseProduct**: Allows customers to purchase a product by sending Ether. The function verifies product availability and sufficient funds before recording the sale. After the sale, the product catalog is updated.
- **withdraw**: Allows the owner to withdraw the Ether balance from the contract.
- **getSale**: Retrieves information about a specific sale based on its ID.

## How It Works

1. **Adding Products**: The owner can add new products by specifying their name, quantity, and price in Ether. Each product is assigned a unique ID.
2. **Purchasing Products**: Customers can purchase products by calling the `purchaseProduct` function and sending the required amount of Ether. The product's quantity is reduced, and the sale is recorded in the sales array.
3. **Tracking Sales**: The contract tracks all sales and emits the `SaleRecorded` event for each transaction.
4. **Withdrawing Funds**: The contract owner can withdraw the collected Ether balance using the `withdraw` function.

## Security Considerations

- The contract uses **require** statements to validate conditions, such as checking product availability and sufficient funds.

## Deployment

To deploy this contract, you will need:

- **Solidity Compiler**: Version 0.8.18 or compatible.
- **Ethereum Wallet**: To deploy and interact with the contract on a testnet or mainnet.

## License

MIT License.
