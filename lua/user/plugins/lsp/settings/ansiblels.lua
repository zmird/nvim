return {
  settings = {
    ansible = {
      ansible = {
        path = "ansible",
        useFullyQualifiedCollectionNames = false,
      },
      ansibleLint = {
        enabled = true,
        path = "ansible-lint",
        arguments = "-c$HOME/.config/ansible-lint/config.yml",
      },
      executionEnvironment = {
        enabled = false
      },
      python = {
        interpreterPath = "python3"
      }
    }
  }
}
