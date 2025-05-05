# Development Tools Guide

This guide covers the various development tools installed by the setup script.

## 🚀 Core Development Tools

### Git
Enhanced Git commands with better formatting and autocomplete:
```bash
git status    # Check repository status
git add .     # Stage all changes
git commit -m "message"  # Commit changes
git push      # Push to remote
git pull      # Pull from remote
```

### Node.js and npm
```bash
# Create a new project
npm init -y

# Install dependencies
npm install package-name

# Run scripts
npm run script-name

# Global packages
npm install -g package-name
```

### TypeScript
```bash
# Initialize TypeScript in a project
npx tsc --init

# Compile TypeScript
npx tsc

# Run TypeScript with ts-node
npx ts-node file.ts
```

## 🛠️ Additional Tools

### Docker
```bash
# Check Docker status
docker --version
docker ps

# Build and run containers
docker build -t image-name .
docker run -d image-name
```

### Database Tools
- PostgreSQL: `psql` command-line interface
- MongoDB Compass: GUI for MongoDB
- Postman: API testing and documentation

### Cloud Tools
```bash
# AWS CLI
aws configure
aws s3 ls

# Google Cloud
gcloud init
gcloud projects list

# Azure
az login
az account list
```

## 🔍 Development Workflow

### Starting a New Project
1. Create project directory
2. Initialize version control
3. Set up project configuration
4. Install dependencies
5. Start development

### Common Workflows

#### Node.js/TypeScript Project
```bash
# Initialize project
mkdir my-project
cd my-project
npm init -y
npx tsc --init

# Install dependencies
npm install typescript @types/node
npm install -D ts-node nodemon

# Start development
npm run dev
```

#### Python Project
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run project
python main.py
```

#### Go Project
```bash
# Initialize module
go mod init github.com/username/project

# Install dependencies
go get package-name

# Run project
go run main.go
```

## 📦 Package Management

### npm/yarn/pnpm
```bash
# Install packages
npm install package-name
yarn add package-name
pnpm add package-name

# Update packages
npm update
yarn upgrade
pnpm update

# Remove packages
npm uninstall package-name
yarn remove package-name
pnpm remove package-name
```

### Python (pip)
```bash
# Install packages
pip install package-name

# Create requirements file
pip freeze > requirements.txt

# Install from requirements
pip install -r requirements.txt
```

### Go (go get)
```bash
# Install package
go get github.com/package/name

# Update dependencies
go get -u ./...
```

## 📚 Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [Node.js Documentation](https://nodejs.org/en/docs/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [AWS CLI Documentation](https://aws.amazon.com/cli/)
- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/) 