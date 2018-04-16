require "mojarralog/version"
require "yaml/store"


module Mojarralog
  #Instance Variables
  @store = YAML::Store.new("data.yml")


  def self.log(name, value)
    @store.transaction do
        @store[name] = value
        @store["#{name}_timestamp"] = Time.now
    end
  end

  def self.find_by(name)
    @store.transaction do
      @store[name]
    end
  end

  def self.all
    @store.transaction do
        @store.roots
    end
  end

  def self.destroy(name)
    @store.transaction do
      @store.delete(name)
    end
  end
end
