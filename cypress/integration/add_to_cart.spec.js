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