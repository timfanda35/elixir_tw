defmodule ElixirTw.OauthProviderTest do
  use ElixirTw.ModelCase

  alias ElixirTw.OauthProvider

  @valid_attrs %{uid: "some content", provider: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OauthProvider.changeset(%OauthProvider{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OauthProvider.changeset(%OauthProvider{}, @invalid_attrs)
    refute changeset.valid?
  end
end
