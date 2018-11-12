using module PSKoans
[Koan()]
param()
<#
    Pipelines

    PowerShell's pipeline structure is implemented partly as a language feature and
    partly as a function/cmdlet feature; you don't have to implement pipeline-supporting
    logic in your functions, and not every cmdlet does.

    However, the vast majority of cmdlets do have pipeline-ready capabilities, and
    many module functions will often also implement pipeline logic. The use of the
    pipeline logic as standard procedure allows cmdlets to remain small and work as
    interchangeable pieces in a larger pipeline, instead of having a large and less
    flexible function that is difficult to maintain, test, and work with.

    The pipeline is a feature that is used to streamline passing objects around, and
    as a part of its processing, it will break up arrays and other collections in order
    to work with objects one after the other.

    The pipeline operates in stages:

        1. Begin {}
            Each command executes its <begin{}> blocks in order. Direct input from parameters can
            be used, but no input passed to pipeline parameters is processed in this step.
            Output can be generated, which will be processed before any other <process{}> steps.
        2. Process {}
            The first statement or command is executed, and the output given one item at a time
            to the <process{}> block of the next command in line. The pipeline sequence executes
            once for each object in the pipe, and output from one function is used as input for
            the next. Each function in turn takes the input, does its job, and provides any output
            to the next command.
        3. End {}
            As with begin, input passed to pipeline parameters is not typically available in this
            step. However, should the author wish to handle all input in bulk, it can be done by
            using the automatic $Input variable in the <end{}> step. Output may still be emitted,
            and will be processed by the next command's <process{}> block after all precending
            <process{}> steps.

            At the end of the pipeline, any resulting objects are packaged as an ArrayList for
            display or to be stored. If the output results in a single object, it will be stored
            as-is; otherwise, all output objects are wrapped in an array of type [object[]]

        Visualizing this process looks something like this:

            Pipeline:
                @(1, 2, 3) | <Command1> | <Command2>

            <Step 1>
                <Command1:begin{}>
                <Command2:begin{}>

            <Step 2>
                <Command1:process{1}>
                <Command2:process{^1}>
                    <Output:{^^1}>

                <Command1:process{2}>
                <Command2:process{^2}>
                    <Output:{^^2}>

                <Command1:process{3}>
                <Command2:process{^3}>
                    <Output:{^^3}>

            <Step 3>
                <Command1:end{}>
                <Command2:end{}>

            <Total Output:{^^1, ^^2, ^^3}>
#>

Describe 'The PowerShell Pipeline' {

    Context 'Working with the Pipeline' {

        It 'can chain sequences of commands' {

        }

        It 'can pass single items' {

        }

        It 'can pass multiple items' {

        }

        It 'can pass items directly' {

        }

        It 'can pass items as a property' {

        }

        It 'can pass properties to specific parameters' {

        }
    }

    Context 'Designing for the Pipeline' {

        It 'requires specifically implemented code patterns' {

        }
    }
}