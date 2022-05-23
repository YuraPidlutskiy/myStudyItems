lifecyle {
    prevent_destroy = true # for innability to delete resourse
}

lifecyle {
    ignore_changes = ["ami" , " user_data" , "etc"] # for ignore changes 
}

lifecyle {
    create_before_destroy = true # create new before destroy old 
}