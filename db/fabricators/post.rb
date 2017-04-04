Fabricator(:post) do
  author        {Fabricate(:user)}
  title         'title'
  body          'body'
end
