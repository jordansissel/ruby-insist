# insist { on readable assertions }

I like rspec, but I don't like the '#should' junk. It scratches me the wrong
way, I guess. I find this to be an unreadable mess:

    somevalue.should eq(0)

On the flip side, I like the idea (make tests read like english).

So instead of slapping '#should' on all objects and doing weird stuff like
`expect { block }.to raise_error(thing)`, I just use blocks for everything in a
kind of lazy-evaluation wrapping:

    # Check equality
    insist { value } == 30

    # Insist an exception is raised
    insist { code }.raises(exception_class)

Reads well, I think.


