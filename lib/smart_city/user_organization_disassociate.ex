defmodule SmartCity.UserOrganizationDisassociate do
  @moduledoc """
  Defines a user organization association.
  """
  alias SmartCity.BaseStruct

  @type user_id :: String.t()
  @type org_id :: SmartCity.Organization.id()
  @type t :: %SmartCity.UserOrganizationDisassociate{
          :user_id => user_id(),
          :org_id => org_id()
        }

  @derive Jason.Encoder
  defstruct user_id: nil,
            org_id: nil

  @doc """
  Instantiates an instance of a user organization disassociate event struct.
  """
  @spec new(String.t() | map()) :: {:ok, map()} | {:error, String.t()}
  def new(msg) do
    BaseStruct.new(msg)
    |> create()
  end

  defp create(%{user_id: _, org_id: _} = msg) do
    user_organization_disassociate = struct(%__MODULE__{}, msg)

    {:ok, user_organization_disassociate}
  end

  defp create(msg) do
    {:error, "Invalid user:organization:disassociate: #{inspect(msg)}"}
  end
end
