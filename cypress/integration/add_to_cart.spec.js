describe('Home page displays', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("Should click the 'Add to Cart' button for a product and see the cart count increase", () => {

    cy.get('.nav-link').contains('My Cart').should('include.text', '0');

    // Click the 'Add to Cart' button on the first product
    cy.viewport(1000, 1500)
    cy.get('.products article').first().find('button').click();

    // Get the cart count element again and assert it has text '1'
    cy.get('.nav-link').contains('My Cart').should('include.text', '1');

  });

});


{/* <article>
  <%= link_to product_path(product) do %>
    <%= image_tag product.image.thumb.url , alt: product.name %>
    <h1>
      <span><%= product.name %></span>
      <span><%= humanized_money_with_symbol product.price %></span>
    </h1>
  <% end%>
  <div>
  <% if product.quantity < 1 %>
  <button class="soldout">Sold Out</button>
  <% end %>
    <%= button_to add_item_cart_path(product_id: product.id), class: 'btn'  + (product.quantity < 1 ? ' btn-semi-transparent' : '') ,
    method: :post do %>
      <%= fa_icon "shopping-cart", text: 'Add' %> 
    <% end %>
   
  </div>
</article> */}