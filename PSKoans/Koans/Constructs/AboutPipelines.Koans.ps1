using module PSKoans
[Koan()]
param()

<#
    Pipelines

    PowerShell's pipeline structure is implemented as partly a language feature and
    partly a function/cmdlet feature; you don't have to implement pipeline-supporting
    logic in your functions, and not every cmdlet does.

    However, the vast majority of cmdlets do have pipeline-ready capabilities, and
    many module functions will often also implement pipeline logic.

    The pipeline is a feature that is used to streamline passing objects around, and
    as a basic tenet of its functionality, it by default enumerates (i.e., breaks apart)
    collections in order to be able to pass objects around one at a time and operate on
    each in their turn. It functions somewhat like this:

        $Collection = @( 1, 2, 3, 4, 5 )

        $Collection | <Function1> | <Function2> | <Function 3>

        Step 1:----- All cmdlets in the pipeline run their begin{} blocks in sequence
            @( 1, 2, 3, 4, 5 ) | <begin{}> | <begin{}> | <begin{}>

        Step 2:----- Function1 executes its process{} block with the first item as input
            @( 2, 3, 4, 5 ) | <process{1}> | <waiting> | <waiting>

        Step 3:----- Function1 provides output to Function2's input, and takes the next item
            @( 3, 4, 5 ) | <process{2}> | <process{>1}> | <waiting>

        Step 4:----- Functions complete processing, passing output down, Function1 takes next item
            @( 4, 5 ) | <process{3}> | <process{>2}> | <process{>>1}>

        Step 5:----- Output is passed down, 'falling off' the pipe into the output stream
            @( 5 ) | <process{4}> | <process{>3}> | <process{>>2}> ==>> ( >>>1 )

        This continues until all available input has been processed. As input runs out, each cmdlet in
        the pipeline executes its end{} block in sequence.

        Step 6:----- The resulting output is stored internally as an ArrayList until either sent to display or stored.
            <end{}> | <end{}> | <end{}>     ==>> @( >>>1, >>>2, >>>3, >>>4, >>>5 )

        Step 7:----- The pipeline is terminated.


#>