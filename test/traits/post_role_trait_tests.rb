module PostRoleTraitTests

  def test_includes_post_username
    post = OpenStruct.new username: 'foo', message: ''
    role = subject.new(post)
    role.tags.must_include '@foo'
  end

  def test_includes_usernames
    post = OpenStruct.new username: 'foo', message: 'foo @bar baz'
    role = subject.new(post)
    role.tags.must_include '@bar'
  end

  def test_excludes_usernames_as_hashes
    post = OpenStruct.new username: 'foo', message: 'foo @bar baz'
    role = subject.new(post)
    role.tags.wont_include '#bar'
  end

  def test_includes_tags
    post = OpenStruct.new username: 'foo', message: 'foo #bar baz'
    role = subject.new(post)
    role.tags.must_include '#bar'
  end

  def test_includes_tags_with_dash
    post = OpenStruct.new username: 'foo', message: 'foo #bar-baz bash'
    role = subject.new(post)
    role.tags.must_include '#bar-baz'
  end

  def test_includes_tags_with_ampersand
    post = OpenStruct.new username: 'foo', message: 'foo #bar&baz bash'
    role = subject.new(post)
    role.tags.must_include '#bar&baz'
  end

  def test_includes_tags_with_underscore
    post = OpenStruct.new username: 'foo', message: 'foo #bar_baz bash'
    role = subject.new(post)
    role.tags.must_include '#bar_baz'
  end

  def test_lowercases_tags
    post = OpenStruct.new username: 'foo', message: 'foo #BAR baz'
    role = subject.new(post)
    role.tags.must_include '#bar'
    role.tags.wont_include '#BAR'
  end

  def test_lowercases_usernames
    post = OpenStruct.new username: 'foo', message: 'foo @BAR baz'
    role = subject.new(post)
    role.tags.must_include '@bar'
    role.tags.wont_include '@BAR'
  end

  def test_rejects_duplicates
    post = OpenStruct.new username: 'foo', message: 'foo #bar #bar baz'
    role = subject.new(post)
    role.tags.uniq.count.must_equal role.tags.count
  end

  def test_rejects_short_tags
    post = OpenStruct.new username: 'foo', message: 'foo #b baz'
    role = subject.new(post)
    role.tags.wont_include '#b'
  end

end