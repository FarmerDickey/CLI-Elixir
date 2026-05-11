defmodule AgendaCli do
  alias AgendaCli.Store
  alias AgendaCli.Contacts

  def main do
    contacts = Store.load()
    loop(contacts)
  end

  # =========================
  # LOOP PRINCIPAL
  # =========================
  def loop(contacts) do
    input = IO.gets("agenda> ")
    command = String.trim(input || "")

    case parse(command) do
      {:list} ->
        IO.inspect(contacts)
        loop(contacts)

      {:exit} ->
        IO.puts("Encerrando...")
        :ok

      {:add, contact} ->
        updated = Contacts.add(contacts, contact)
        Store.save(updated)
        IO.puts("Contato adicionado com sucesso!")
        loop(updated)

      :invalid ->
        IO.puts("Comando inválido")
        loop(contacts)
    end
  end

  # =========================
  # PARSER DE COMANDOS
  # =========================
  def parse("list"), do: {:list}
  def parse("exit"), do: {:exit}
  def parse("add " <> args), do: {:add, parse_add(args)}
  def parse(_), do: :invalid

  # =========================
  # PARSE ADD
  # =========================
  def parse_add(command) do
    %{
      id: System.system_time(:millisecond),
      name: extract_value(command, "--name"),
      company: extract_value(command, "--company"),
      phone: extract_value(command, "--phone"),
      email: extract_value(command, "--email")
    }
  end

  # =========================
  # EXTRACT FLAG VALUE
  # =========================
  def extract_value(command, flag) do
    case String.split(command, flag) do
      [_before, after_flag] ->
        after_flag
        |> String.trim()
        |> String.split(" --")
        |> hd()
        |> String.trim()

      _ ->
        ""
    end
  end
end