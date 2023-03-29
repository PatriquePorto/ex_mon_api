defmodule ExMonWeb.TrainersControllerTest do
  use ExMonWeb.ConnCase
  import ExMonWeb.Auth.Guardian

  alias ExMon.Trainer

  describe "show/2" do
    setup %{conn: conn} do #Function inject token in the connection
      params = %{name: "Patrique", password: "123456"}
      {:ok, trainer} = ExMon.create_trainer(params) #create the trainer
      {:ok, token, _claims} = encode_and_sign(trainer) #create the token trainer

      conn = put_req_header(conn, "authorization", "Bearer #{token}") #inject the token in the connection
      {:ok, conn: conn}
    end

    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "Patrique", password: "123456"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

       response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "inserted_at" => _inserted_at, "name" => "Patrique"} = response
    end

    test "when there is an error, returns the error", %{conn: conn} do

       response =
        conn
        |> get(Routes.trainers_path(conn, :show, "1234"))
        |> json_response(:bad_request)

        expected_response = %{"message" => "Invalid ID format!"}

      assert response == expected_response
    end
  end
end
