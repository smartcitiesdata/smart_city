defmodule SmartCity.Dataset.TechnicalTest do
  use ExUnit.Case
  import Checkov

  alias SmartCity.Dataset.Technical

  setup do
    message = %{
      "dataName" => "dataset",
      "orgName" => "org",
      "systemName" => "org__dataset",
      "sourceUrl" => "https://example.com",
      "sourceType" => "ingest",
      "cadence" => 30_000,
      "sourceFormat" => "gtfs",
      "sourceHeaders" => %{
        "foo" => "bar"
      },
      "authHeaders" => %{
        "afoo" => "abar"
      }
    }

    {:ok, message: message}
  end

  describe "new/1" do
    test "returns Technical struct" do
      actual =
        Technical.new(%{
          dataName: "dataset",
          orgName: "org",
          systemName: "org__dataset",
          sourceUrl: "https://example.com",
          sourceFormat: "gtfs"
        })

      assert actual.dataName == "dataset"
    end

    test "is idempotent", %{message: tech} do
      actual = tech |> Technical.new() |> Technical.new()
      assert actual.dataName == "dataset"
    end

    data_test "field #{field} has a default value of #{default}" do
      actual =
        Technical.new(%{
          dataName: "dataset",
          orgName: "org",
          systemName: "org__dataset",
          sourceUrl: "https://example.com",
          sourceFormat: "gtfs"
        })

      assert Map.get(actual, field) == default

      where(
        field: [:schema, :cadence, :sourceType, :allow_duplicates],
        default: [[], "never", "remote", true]
      )
    end

    data_test "sourceFormat #{mime_type} based on input type #{extension}" do
      actual =
        Technical.new(%{
          dataName: "dataset",
          orgName: "org",
          systemName: "org__dataset",
          sourceUrl: "https://example.com",
          sourceFormat: extension
        })

      assert Map.get(actual, :sourceFormat) == mime_type

      where([
        [:extension, :mime_type],
        ["gtfs", "application/gtfs+protobuf"],
        ["csv", "text/csv"],
        ["zip", "application/zip"],
        ["kml", "application/vnd.google-earth.kml+xml"],
        ["json", "application/json"],
        ["xml", "text/xml"]
      ])
    end

    test "returns Technical struct when given string keys", %{message: tech} do
      actual = Technical.new(tech)
      assert actual.systemName == "org__dataset"
      assert actual.sourceQueryParams == %{}
      assert actual.cadence == 30_000
      assert actual.sourceType == "ingest"
    end

    test "converts deeply nested string keys to atoms", %{message: tech} do
      actual = Technical.new(tech)
      assert actual.sourceHeaders.foo == "bar"
      assert actual.authHeaders.afoo == "abar"
    end

    data_test "throws error when creating Technical struct without required field: #{field}", %{message: tech} do
      assert_raise ArgumentError, fn -> Technical.new(tech |> Map.delete(field)) end

      where(field: ["dataName", "orgName", "systemName", "sourceUrl"])
    end
  end

  describe "struct" do
    test "can be encoded to JSON", %{message: message} do
      json = Jason.encode!(message)
      assert is_binary(json)
    end
  end
end
