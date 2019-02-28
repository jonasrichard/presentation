# Faulty

A faulty application to demonstrate tracing.

TODO:
 * disable console log, enable file log
 * show redbug more
 * show recon

## Trace with Rexbug

## Trace with dbg

`dbg` seems to be more powerful than `Rexbug`.

Let us what messages the queue gets.

```elixir
Dbg.trace(Faulty.Queue, [:messages, :receive])
Dbg.clear(Faulty.Queue)
```

What messages the input generator sends.

```elixir
Supervisor.which_children(Faulty.InputSup)
Dbg.trace(Faulty.Input, [:messages, :send])
Dbg.clear(Faulty.Input)
```

## Trace with :dbg

A low-level tracer application

```
:dbg.tracer()
:dbg.p(:all, :c)
:dbg.tp(:lists, :seq:, 2, [])
:dbg.tpl # local calls
```

