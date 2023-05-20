$(document).ready(function() {

    //Khi bàn phím được nhấn và thả ra thì sẽ chạy phương thức này
    $("#create-form").validate({
        rules: {                                         //product
            name: {
                required: true,
                maxLength: 100
            },
            price: {
                required: true,
            
                min:0
            },
            images: {
                required: true,
            },
            //                             //oder_detail
            
            // quantity: {
            //     required: true
            // },
            // unitprice: {
            //     required: true,
            //     minlength: 2
            // },
            // clientId: {                                    //oder
            //     required: true,
            //     minlength: 2
            // },
            // total: {
            //     required: true,
            //     minlength: 2
            // },
            description: {                                      //category , brand
                required: true,
                minlength: 250,
            },       
            title: {                                            //article
                required: true,
                minlength: 20
            },
            author: {
                required: true,
            },
            content: {
                required: true,
                minlength: 2
            },
            id: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            name: {
                required: "This field is required",
                maxLength: "This field has to be shorter than 100 characters"
            },
            price: {
                required: "This field is required",
                min: "This field has to be greater than 0",
                integrity: true
            },
            description: {
                required: "This field is required",
                minlength: "This field has to be greater than 250 characters",
            },
            title: {
                required: "This field is required",
                minlength: "This field has to be greater than 20 characters"
            },
            author: {
                required: "This field is required",
            },
            content: {
                required: "This field is required",
                minlength: "This field has to be greater than 250 characters"
            },
        }
    });

    $("#create-form-edit").validate({
        rules: {                                         //product
            name: {
                required: true,
                maxLength: 100
            },
            price: {
                required: true,
                minlength: 2,
                min:0
            },
            //                             //oder_detail
            
            // quantity: {
            //     required: true
            // },
            // unitprice: {
            //     required: true,
            //     minlength: 2
            // },
            // clientId: {                                    //oder
            //     required: true,
            //     minlength: 2
            // },
            // total: {
            //     required: true,
            //     minlength: 2
            // },
            description: {                                      //category , brand
                required: true,
                minlength: 250,
            },       
            title: {                                            //article
                required: true,
                minlength: 20
            },
            author: {
                required: true,
            },
            content: {
                required: true,
                minlength: 2
            },
            id: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            name: {
                required: "This field is required",
                maxLength: "This field has to be shorter than 100 characters"
            },
            price: {
                required: "This field is required",
                min: "This field has to be greater than 0",
                integrity: true
            },
            description: {
                required: "This field is required",
                minlength: "This field has to be greater than 250 characters",
            },
            title: {
                required: "This field is required",
                minlength: "This field has to be greater than 20 characters"
            },
            author: {
                required: "This field is required",
            },
            content: {
                required: "This field is required",
                minlength: "This field has to be greater than 250 characters"
            },
        }
    });
});