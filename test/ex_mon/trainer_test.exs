defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset" do
      params = %{name: "Patrique", password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
          changes: %{
          name: "Patrique",
          password: "123456",
           },
           errors: [],
           data: %ExMon.Trainer{},
           valid?: true
          } = response
  end

  test "When there are invalid params, returns an invalid chageset" do
    params = %{password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
          changes: %{
          password: "123456",
           },
           data: %ExMon.Trainer{},
           valid?: false
          } = response

      assert errors_on(response) ==  %{name: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "When all params are valid, returns a trainer struct" do
      params = %{name: "Patrique", password: "123456"}

      response = Trainer.build(params)

      assert {:ok, %Trainer {name: "Patrique", password: "123456"} } = response
  end

  test "When there are invalid params, returns an error" do
    params = %{password: "123456"}

    {:error, response} = Trainer.build(params)

    assert %Ecto.Changeset {valid?: false} = response

    assert errors_on(response) ==  %{name: ["can't be blank"]}
    end
  end
end
