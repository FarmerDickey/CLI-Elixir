defmodule AgendaCli.Store do
  @file_path "contacts.json"

  def load do
    case File.read(@file_path) do
      {:ok, content} ->
        Jason.decode!(content, keys: :atoms)

      {:error, _reason} ->
        []
    end
  end

  def save(contacts) do
    json = Jason.encode!(contacts)
    File.write(@file_path, json)
  end
end