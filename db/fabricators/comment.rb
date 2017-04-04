Fabricator(:comment) do
  commenter     {Fabricate(:user)}
  post          {Fabricate(:post)}
  body          'body'
end
