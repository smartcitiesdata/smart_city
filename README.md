# SmartCity

This library defines helper functions that are used across SmartCity modules.

## Installation

```elixir
def deps do
  [
    {:smart_city, "~> 2.1.1", organization: "smartcolumbus_os"}
  ]
end
```

## Basic Usage

```elixir
iex> SmartCity.Helpers.to_atom_keys(%{"a" => 1, "b" => 2, "c" => 3})
%{a: 1, b: 2, c: 3}

iex> SmartCity.Helpers.to_atom_keys(%{"a" => %{"b" => "c"}})
%{a: %{b: "c"}}

iex> SmartCity.Helpers.deep_merge(%{a: 1, b: 2}, %{a: 3, c: 4})
%{a: 3, b: 2, c: 4}
```

Full documentation can be found at [https://smartcolumbus_os.hexdocs.pm/smart_city/api-reference.html](https://smartcolumbus_os.hexdocs.pm/smart_city/api-reference.html).

## Contributing

Make your changes and run `docker build .`. This is exactly what our CI will do. The build process runs these commands:

```bash
mix deps.get
mix test
mix format --check-formatted
mix credo
```

## License

SmartCity is released under the Apache 2.0 license - see the license at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
