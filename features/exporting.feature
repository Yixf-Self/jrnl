Feature: Exporting a Journal

    Scenario: Exporting to json
        Given we use the config "tags.yaml"
        When we run "jrnl --export json"
        Then we should get no error
        and the output should be parsable as json
        and "entries" in the json output should have 2 elements
        and "tags" in the json output should contain "@idea"
        and "tags" in the json output should contain "@journal"
        and "tags" in the json output should contain "@dan"

    Scenario: Exporting using filters should only export parts of the journal
        Given we use the config "tags.yaml"
        When we run "jrnl -until 'may 2013' --export json"
        # Then we should get no error
        Then the output should be parsable as json
        and "entries" in the json output should have 1 element
        and "tags" in the json output should contain "@idea"
        and "tags" in the json output should contain "@journal"
        and "tags" in the json output should not contain "@dan"

    Scenario: Exporting dayone to json
        Given we use the config "dayone.yaml"
        When we run "jrnl --export json"
        Then we should get no error
        and the output should be parsable as json
        and the json output should contain entries.0.uuid = "4BB1F46946AD439996C9B59DE7C4DDC1"

    Scenario: Increasing Headings on Markdown export
        Given we use the config "markdown-headings-335.yaml"
        When we run "jrnl --export markdown"
        Then we should get error
        """
        WARNING: Headings increased past H6 on export - 2015-04-14 13:23 Heading Test
        """
        and the output should be
        """
        2015
        ====

        April
        -----

        ### 2015-04-14 13:23 Heading Test

        #### H1-1

        #### H1-2

        #### H1-3

        ##### H2-1

        ##### H2-2

        ##### H2-3

        Horizontal Rules (ignore)

        ---

        ===

        #### ATX H1

        ##### ATX H2

        ###### ATX H3

        ####### ATX H4

        ######## ATX H5

        ######### ATX H6

        Stuff

        More stuff
        more stuff agains
        """
