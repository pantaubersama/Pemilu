shared_examples 'presents pagination meta' do
  it 'presents pagination meta' do
    expect(json_response).to match(
      data: a_hash_including(
        meta: a_hash_including(
          pages: a_hash_including(:total, :per_page, :page)
        )
      )
    )
  end
end
