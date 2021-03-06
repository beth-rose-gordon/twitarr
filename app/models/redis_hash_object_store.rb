class RedisHashObjectStore

  attr_reader :hash, :clazz

  def initialize(hash, clazz)
    @hash = hash
    @clazz = clazz
  end

  def get(id_or_ids)
    unless id_or_ids.is_a? Enumerable
      data = hash[id_or_ids]
      return if data.nil?
      return clazz.new(JSON.parse(data))
    end
    return [] if id_or_ids.blank?
    hash.bulk_get(*id_or_ids).values.compact.map { |x| clazz.new(JSON.parse x) }
  end

  def has_key?(id)
    hash.has_key? id
  end

  def save(obj, id)
    hash[id] = obj.to_hash.to_json
  end

  def delete(id)
    hash.delete(id)
  end

  # this is likely to be a very slow operation - use with care
  def keys
    hash.keys
  end

  def all
    keys.map { |x| get x }
  end

end