defmodule AgendaCli.Contacts do

  def add(contacts, contact) do
    [contact | contacts]
  end

  def list(contacts) do
    contacts
  end

  def find_by_id(contacts, id) do
    Enum.find(contacts, fn contact ->
      contact.id == id
    end)
  end

  def delete(contacts, id) do
    Enum.reject(contacts, fn contact ->
      contact.id == id
    end)
  end

end