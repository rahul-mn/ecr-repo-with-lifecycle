#Define the variable values as required

variable "principal_arns" {
    type = list(string)
    description = " Account_IDs to allow Cross-account access of bucket for listing and getting the objects. Ex - arn:aws:iam::ID:root ( Replace ID with account id )"
#   Example = "arn:aws:iam::<account_id>:root"
    default = ["arn:aws:iam::856361924591:root"]
}

variable "countNumber" {
    type = number
    description = "Define the no. of days after which the image should be deleted"
    default = 1
}