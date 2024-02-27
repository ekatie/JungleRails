describe('Product details page functionality', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("Clicks on a product to navigate to product details page", () => {
    cy.get(".products article").first().click();
    cy.url().should('include', '/products/');
  });
});