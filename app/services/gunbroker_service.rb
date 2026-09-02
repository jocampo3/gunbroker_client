class GunbrokerService
  def initialize(username, password)
    @username = username
    @password = password
  end

  def generate_token
    user = GunBroker::User.new(@username, password: @password)
    user.authenticate!
    user.token
  end

  def get_product(upc)
    response = GunBroker::API.get("/Items", { "sku" => upc })
    results = response.body["results"] || []
    raise GunBroker::Error::NotFound, "No product found for UPC #{upc}" if results.empty?

    item_id = results.first["itemID"]
    item = GunBroker::Item.find(item_id)
    item&.attributes
  end

  def get_item(item_id)
    item = GunBroker::Item.find(item_id)
    item&.attributes
  end

  def get_inventory
    user = GunBroker::User.new(@username, password: @password)
    user.authenticate!
    user.items.all.map(&:attributes)
  end

  def end_listing(listing_id)
    token = generate_token
    response = GunBroker::API.delete("/Items/#{listing_id}", {}, { "X-AccessToken" => token })
    response.body
  end
end
