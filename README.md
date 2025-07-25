# parquet-tools

A nix flake to make a nix derivation of parquet-tools.

Based on build description by given by [rengareddy](https://rangareddy.github.io/ParquetTools/).

### nix shell
```
nix shell github:OleJoik/parquet-tools
```

or in flake.nix with `nix develop`

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    parquet-tools.url = "github:<your-user>/parquet-tools-flake";
  };

  outputs = { self, nixpkgs, parquet-tools, ... }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [
        parquet-tools.packages.x86_64-linux.default
      ];
    };
  };
}
```

### Help output

```
parquet-tools -h                      
parquet-tools cat:
Prints the content of a Parquet file. The output contains only the data, no
metadata is displayed
usage: parquet-tools cat [option...] <input>
where option is one of:
       --debug     Enable debug output
    -h,--help      Show this help string
    -j,--json      Show records in JSON format.
       --no-color  Disable color output even if supported
where <input> is the parquet file to print to stdout

parquet-tools head:
Prints the first n record of the Parquet file
usage: parquet-tools head [option...] <input>
where option is one of:
       --debug          Enable debug output
    -h,--help           Show this help string
    -n,--records <arg>  The number of records to show (default: 5)
       --no-color       Disable color output even if supported
where <input> is the parquet file to print to stdout

parquet-tools schema:
Prints the schema of Parquet file(s)
usage: parquet-tools schema [option...] <input>
where option is one of:
    -d,--detailed      Show detailed information about the schema.
       --debug         Enable debug output
    -h,--help          Show this help string
       --no-color      Disable color output even if supported
    -o,--originalType  Print logical types in OriginalType representation.
where <input> is the parquet file containing the schema to show

parquet-tools meta:
Prints the metadata of Parquet file(s)
usage: parquet-tools meta [option...] <input>
where option is one of:
       --debug         Enable debug output
    -h,--help          Show this help string
       --no-color      Disable color output even if supported
    -o,--originalType  Print logical types in OriginalType representation.
where <input> is the parquet file to print to stdout

parquet-tools dump:
Prints the content and metadata of a Parquet file
usage: parquet-tools dump [option...] <input>
where option is one of:
    -c,--column <arg>  Dump only the given column, can be specified more than
                       once
    -d,--disable-data  Do not dump column data
       --debug         Enable debug output
    -h,--help          Show this help string
    -m,--disable-meta  Do not dump row group and page metadata
    -n,--disable-crop  Do not crop the output based on console width
       --no-color      Disable color output even if supported
where <input> is the parquet file to print to stdout

parquet-tools merge:
Merges multiple Parquet files into one. The command doesn't merge row groups,
just places one after the other. When used to merge many small files, the
resulting file will still contain small row groups, which usually leads to bad
query performance.
usage: parquet-tools merge [option...] <input> [<input> ...] <output>
where option is one of:
       --debug     Enable debug output
    -h,--help      Show this help string
       --no-color  Disable color output even if supported
where <input> is the source parquet files/directory to be merged
   <output> is the destination parquet file

parquet-tools rowcount:
Prints the count of rows in Parquet file(s)
usage: parquet-tools rowcount [option...] <input>
where option is one of:
    -d,--detailed  Detailed rowcount of each matching file
       --debug     Enable debug output
    -h,--help      Show this help string
       --no-color  Disable color output even if supported
where <input> is the parquet file to count rows to stdout

parquet-tools size:
Prints the size of Parquet file(s)
usage: parquet-tools size [option...] <input>
where option is one of:
    -d,--detailed      Detailed size of each matching file
       --debug         Enable debug output
    -h,--help          Show this help string
       --no-color      Disable color output even if supported
    -p,--pretty        Pretty size
    -u,--uncompressed  Uncompressed size
where <input> is the parquet file to get size & human readable size to stdout

parquet-tools column-index:
Prints the column and offset indexes of a Parquet file.
usage: parquet-tools column-index [option...] <input>
where option is one of:
    -c,--column <arg>     Shows the column/offset indexes for the given column
                          only; multiple columns shall be separated by commas
       --debug            Enable debug output
    -h,--help             Show this help string
    -i,--column-index     Shows the column indexes; active by default unless -o
                          is used
       --no-color         Disable color output even if supported
    -o,--offset-index     Shows the offset indexes; active by default unless -i
                          is used
    -r,--row-group <arg>  Shows the column/offset indexes for the given
                          row-groups only; multiple row-groups shall be
                          speparated by commas; row-groups are referenced by
                          their indexes from 0
where <input> is the parquet file to print the column and offset indexes for
```


# WSL Usage

Install nix package manager
```sh <(curl -L https://nixos.org/nix/install) --daemon```

~/.config/nix/nix.conf
```
experimental-features = nix-command flakes
```
