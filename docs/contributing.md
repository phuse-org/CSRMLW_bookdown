# How to Contribute to this Project

The goal of this project is to be a living repository of investigations into best practices when migrating from one language to another in the realm of clinical statistical modeling. Currently, the documentation found here is focused on migrating from SAS to R.  However, we do envision this documentation growing to encompass the questions that should be asked when migrating to any language.  But we cannot do this alone.  If you would like to contribute to this project, continue reading about how to do so via GitHub.

## Using GitHub

When viewing this site on a desktop browser, you will see GitHub icons ![GitHub](images/GitHub-Mark.png){ width=3% } on both the left and right sides of the text.  On the left side, clicking `View Book Source` will take you to the GitHub repository for the files that are used in the creation of this website.  On the right side, clicking `View Source` will take you directly to the raw R Markdown file that was used to create the specific page that you are on.  Finally, clicking on `Edit This Page` will allow you to make your own changes to the documentation.  

Note, if viewing this site on a mobile browser, you will only see the `View Book Source` link when viewing the table of contents.  The options to `View Source` and `Edit This Page` will not be shown.

### Contributing via GitHub Website

A _fork_ is GitHub terminology for making a copy of the repository as it currently exists. After clicking on `Edit This Page`, you will be asked to either create an account, or to log in.  Once you are logged in, you'll be given the option to create a fork of the existing file.  Creating a fork allows you to directly edit the file on the GitHub site.  Generally, these files are in the R Markdown `.Rmd` format, and you may find it useful to [browse the documentation](https://bookdown.org/yihui/rmarkdown/) for this type of file.  

After you have made your changes to the text, scroll to the bottom of the page and provide a write up of the changes you have made, and the reasoning for the change (if applicable).  Click `Propose Changes` when you are ready to submit your proposal for changes.  This will send your changes to the repository administrators for review and acceptance.  

If you want to make changes to more than one file, or if you want to include data or images in a file, the best way to contribute is using the `View Book Source` link described above.  Once you are on the main page for the repository, you can download a ZIP file of the entire repository.  This will allow you to make changes to the files and structure on your own system.  Once you have made your desired changes, use the `Add File` button to add all of the files that you have changed back to the repository.  Again, this will create a fork of the existing repository, and submit your changes for review and acceptance by the administrators.  

### Adding Images and Data

If you want to include images and data in your changes, please use the repository directories `/data` for data files and `/images` for image files.  You'll notice sub-directories dedicated to each of the main sections of the documentation: `linear models`, `mixed models`, `survival`, and `cmh models`.  Place your files in the corresponding directories, or create a new directory if you are creating a new main section.  
