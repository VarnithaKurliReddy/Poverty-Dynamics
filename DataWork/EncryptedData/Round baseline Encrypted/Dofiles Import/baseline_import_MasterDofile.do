   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               BASELINE IMPORT MASTER DO_FILE                         *
   *               This master dofile calls all dofiles related           *
   *               to import in the baseline round.                       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

   ** IDS VAR:          list_ID_var_here         //Uniquely identifies households (update for your project)
   ** NOTES:
   ** WRITEN BY:        names_of_contributors
   ** Last date modified: 23 Aug 2018


   * ***************************************************** *
   *                                                       *
   * ***************************************************** *
   *
   *   import dofile 1
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      -what additional data sets does this file require
   *      -what variables are created
   *      -what corrections are made
   *
   * ***************************************************** *

       *do "$baseline_doImp/dofile1.do" //Give your dofile a more informative name, this is just a place holder name

   * ***************************************************** *
   *
   *   import dofile 2
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      -what additional data sets does this file require
   *      -what variables are created
   *      -what corrections are made
   *
   * ***************************************************** *

       *do "$baseline_doImp/dofile2.do" //Give your dofile a more informative name, this is just a place holder name

   * ***************************************************** *
   *
   *   import dofile 3
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      -what additional data sets does this file require
   *      -what variables are created
   *      -what corrections are made
   *
   * ***************************************************** *

       *do "$baseline_doImp/dofile3.do" //Give your dofile a more informative name, this is just a place holder name

   * ************************************
   *   Keep adding sections for all additional dofiles needed
