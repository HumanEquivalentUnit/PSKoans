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
    each in their turn.

    The pipeline operates in stages:

        1. Begin {}
            All cmdlets in the pipeline, in sequence, execute their begin{} blocks. Input from
            directly-provided parameters can be used, but no input passed to pipeline parameters
            is processed in this step. Output can be generated, and will be processed before any
            other <process{}> steps.
        2. Process {}
            The first statement or command is evaluated and the output passed into the <process{}>
            block of the next function. The pipeline sequence executes once for each object sent in,
            as output is emitted from one function to the next. Each function in turn takes its
            input, and provides any output to the next function in the pipeline.
            At the end of the pipeline, the resulting objects, if any, are collected and packaged as
            an ArrayList for display or to be stored. If they are being stored, they are converted
            into a standard [object[]] array.
        3. End {}
            As with begin, input passed to pipeline parameters is not typically available in this
            step. However, should the author wish to handle all input in bulk, it can be done by
            using the automatic $Input variable in the <end{}> step. Output may still be emitted,
            and will be processed by the next pipeline after all precending <process{}> steps.

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