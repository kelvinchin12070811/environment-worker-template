This is a template for scripts that setup a Windows pc after reinstall OS. The apps are installed from either winget or
a custom script found under the `custom-installations` folder. List of apps that will be installed via winget can be
configured at `winget_apps_list.rb`

The script must be run in admin for some installation process such as creating symbolic link.
