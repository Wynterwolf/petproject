# Dog Adoption App

Dog adoption app is a quick and easy way for foster parents to list their pets that are looking for a furever home.

## Installation

To fork and clone this repo from your terminal window:

```git clone https://github.com/Wynterwolf/petproject```

Open the project in your favorite code editor. Open a term window and do the following command:

```bundle install```

If you are using Windows OS, working through the Ubuntu WSL terminal, you may need to run this command in your terminal.

```sudo apt install libsqlite3-dev```

Create  a file in the root of our project called `.env` Add the following text.

```SESSION_SECRET=```

now in your terminal, run

```generate_secret```

paste the output into your `.env` file after the `=` sign, like so:

```SESSION_SECRET=3688fd1c5e985597198a7d918d6937994356f4ae232dae625e7f8f83228378f786761c9fc778cc4cf823f2e09e11c5ed18eac69019de217eb32ddac81e0f74f7```

**Don't use the same one as I have here!!!**

Remember to add your `.env` file to a file called `.gitignore` so that it's not tracked in git. Create a file in the root of your project called `.gitignore` and put the following line in it:

```.env```

You will need to start the app with the following command in your terminal.

```shotgun```

This will enable you to open the app by clicking the link in your terminal.

## Usage

Sign In -- If the user already has an account

Sign Up -- Where to sign up for an account

Create New Adoptable! -- Once logged in, you can access this button to add your foster pet to the list.

Once logged in you have access to edit, delete, and create your adoption records.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
