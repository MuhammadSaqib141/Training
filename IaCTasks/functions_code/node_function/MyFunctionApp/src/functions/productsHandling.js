const { app } = require('@azure/functions');

const products = [
    { 
        id: '1', 
        name: 'Product A', 
        price: 10.99, 
        payments: { 
            payment_id: "PAY12345", 
            date: "2024-01-01", 
            amount: 10.99 
        },
        reviews: [
            { review_id: "REV12345", rating: 5, comment: "Excellent product!" },
            { review_id: "REV12346", rating: 4, comment: "Very good, just a bit pricey." }
        ]
    },
    { 
        id: '2', 
        name: 'Product B', 
        price: 15.99, 
        payments: { 
            payment_id: "PAY12346", 
            date: "2024-02-01", 
            amount: 15.99 
        },
        reviews: [
            { review_id: "REV22345", rating: 4, comment: "Satisfied with the product." }
        ]
    },
    { 
        id: '3', 
        name: 'Product C', 
        price: 12.49, 
        payments: { 
            payment_id: "PAY12347", 
            date: "2024-03-01", 
            amount: 12.49 
        },
        reviews: [
            { review_id: "REV32345", rating: 3, comment: "Average quality." }
        ]
    },
    { 
        id: '4', 
        name: 'Product D', 
        price: 22.00, 
        payments: { 
            payment_id: "PAY12348", 
            date: "2024-04-01", 
            amount: 22.00 
        },
        reviews: [
            { review_id: "REV42345", rating: 5, comment: "High quality and worth the price!" },
            { review_id: "REV42346", rating: 4, comment: "Great product, would recommend." }
        ]
    },
    { 
        id: '5', 
        name: 'Product E', 
        price: 5.99, 
        payments: { 
            payment_id: "PAY12349", 
            date: "2024-05-01", 
            amount: 5.99 
        },
        reviews: [
            { review_id: "REV52345", rating: 4, comment: "Good value for money." },
            { review_id: "REV52346", rating: 2, comment: "Not what I expected." }
        ]
    },
    { 
        id: '6', 
        name: 'Product F', 
        price: 35.00, 
        payments: { 
            payment_id: "PAY12350", 
            date: "2024-06-01", 
            amount: 35.00 
        },
        reviews: [
            { review_id: "REV62345", rating: 5, comment: "Absolutely love it!" },
            { review_id: "REV62346", rating: 3, comment: "Okay, but could be better." }
        ]
    },
    { 
        id: '7', 
        name: 'Product G', 
        price: 45.75, 
        payments: { 
            payment_id: "PAY12351", 
            date: "2024-07-01", 
            amount: 45.75 
        },
        reviews: [
            { review_id: "REV72345", rating: 5, comment: "Top-notch product." }
        ]
    },
    { 
        id: '8', 
        name: 'Product H', 
        price: 8.99, 
        payments: { 
            payment_id: "PAY12352", 
            date: "2024-08-01", 
            amount: 8.99 
        },
        reviews: [
            { review_id: "REV82345", rating: 3, comment: "It’s okay for the price." }
        ]
    },
    { 
        id: '9', 
        name: 'Product I', 
        price: 27.89, 
        payments: { 
            payment_id: "PAY12353", 
            date: "2024-09-01", 
            amount: 27.89 
        },
        reviews: [
            { review_id: "REV92345", rating: 5, comment: "Highly recommended!" }
        ]
    },
    { 
        id: '10', 
        name: 'Product J', 
        price: 3.49, 
        payments: { 
            payment_id: "PAY12354", 
            date: "2024-10-01", 
            amount: 3.49 
        },
        reviews: [
            { review_id: "REV102345", rating: 2, comment: "Not satisfied with the quality." },
            { review_id: "REV102346", rating: 3, comment: "It’s alright." }
        ]
    }
];


app.http('reviews', {
    methods: ['GET', 'DELETE', 'PUT'],
    route: 'products/{id}/reviews/{review_id?}', 
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const productId = request.params.id;
        const reviewId = request.params.review_id;
        const method = request.method;

        console.log(method);

        const product = products.find(p => p.id === productId);
        if (!product) {
            return {
                status: 404,
                body: JSON.stringify({ error: 'Product not found' }),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'GET') {
            if (reviewId) {
                const review = product.reviews?.find(r => r.review_id === reviewId);
                if (review) {
                    return {
                        status: 200,
                        body: JSON.stringify(review),
                        headers: { 'Content-Type': 'application/json' }
                    };
                }
                return {
                    status: 404,
                    body: JSON.stringify({ error: 'Review not found' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }
            return {
                status: 200,
                body: JSON.stringify(product.reviews || []),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        // Handle DELETE request
        if (method === 'DELETE') {
            if (!reviewId) {
                return {
                    status: 400,
                    body: JSON.stringify({ error: 'Review ID is required for deletion' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            const reviewIndex = product.reviews?.findIndex(r => r.review_id === reviewId);
            if (reviewIndex === -1 || reviewIndex === undefined) {
                return {
                    status: 404,
                    body: JSON.stringify({ error: 'Review not found' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            product.reviews.splice(reviewIndex, 1);
            return {
                status: 200,
                body: JSON.stringify({ message: 'Review deleted successfully' }),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'PUT') {
            if (!reviewId) {
                return {
                    status: 400,
                    body: JSON.stringify({ error: 'Review ID is required for update' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            const { rating, comment } = await request.json();
            const review = product.reviews?.find(r => r.review_id === reviewId);

            if (!review) {
                return {
                    status: 404,
                    body: JSON.stringify({ error: 'Review not found' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            if (rating) review.rating = rating;
            if (comment) review.comment = comment;

            return {
                status: 200,
                body: JSON.stringify(review),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        return {
            status: 405,
            body: JSON.stringify({ error: 'Method not allowed' }),
            headers: { 'Content-Type': 'application/json' }
        };
    }
});

app.http('payments', {
    methods: ['GET', 'DELETE', 'PUT'],
    route: 'products/{id}/payments', 
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const productId = request.params.id;
        const method = request.method;

        console.log(method);

        const product = products.find(p => p.id === productId);
        if (!product) {
            return {
                status: 404,
                body: JSON.stringify({ error: 'Product not found' }),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'GET') {
            return {
                status: 200,
                body: JSON.stringify(product.payments || { error: 'No payments found' }),
                headers: { 'Content-Type': 'application/json' }
            };
        }
        if (method === 'DELETE') {
            product.payments = null;  // Clear payments
            return {
                status: 200,
                body: JSON.stringify({ message: 'Payments deleted successfully' }),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'PUT') {
            const { payment_id, date, amount } = await request.json();

            product.payments = {
                payment_id: payment_id || product.payments?.payment_id || '',
                date: date || product.payments?.date || '',
                amount: amount || product.payments?.amount || 0
            };

            return {
                status: 200,
                body: JSON.stringify(product.payments),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        return {
            status: 405,
            body: JSON.stringify({ error: 'Method not allowed' }),
            headers: { 'Content-Type': 'application/json' }
        };
    }
});

app.http('productRetrieveAdd', {
    methods: ['GET', 'DELETE', 'PUT'],
    route: 'products/{id}', 
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const productId = request.params.id;
        const method = request.method;

        console.log(method)

        if (method === 'GET') {
            if (productId) {
                const product = products.find(p => p.id === productId);
                if (product) {
                    return {
                        status: 200,
                        body: JSON.stringify(product),
                        headers: { 'Content-Type': 'application/json' }
                    };
                } else {
                    return {
                        status: 404,
                        body: JSON.stringify({ error: 'Product not found' }),
                        headers: { 'Content-Type': 'application/json' }
                    };
                }
            }
            return {
                status: 200,
                body: JSON.stringify(products),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'DELETE') {
            if (!productId) {
                return {
                    status: 400,
                    body: JSON.stringify({ error: 'Product ID is required for deletion' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            const productIndex = products.findIndex(p => p.id === productId);
            if (productIndex === -1) {
                return {
                    status: 404,
                    body: JSON.stringify({ error: 'Product not found' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            products.splice(productIndex, 1);
            return {
                status: 200,
                body: JSON.stringify({ message: 'Product deleted successfully' }),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'PUT') {
            if (!productId) {
                return {
                    status: 400,
                    body: JSON.stringify({ error: 'Product ID is required for update' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            const { name, price } = await request.json();
            const productIndex = products.findIndex(p => p.id === productId);

            if (productIndex === -1) {
                return {
                    status: 404,
                    body: JSON.stringify({ error: 'Product not found' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            if (name) products[productIndex].name = name;
            if (price) products[productIndex].price = price;

            return {
                status: 200,
                body: JSON.stringify(products[productIndex]),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        return {
            status: 405,
            body: JSON.stringify({ error: 'Method not allowed' }),
            headers: { 'Content-Type': 'application/json' }
        };
    }
});

app.http('productCreateUpdate', {
    methods: ['POST', 'GET'],
    route: 'products', 
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const method = request.method;
        console.log(method)


        if (method === 'POST') {
            const { name, price } = await request.json();

            if (!name || !price) {
                return {
                    status: 400,
                    body: JSON.stringify({ error: 'Product name and price are required' }),
                    headers: { 'Content-Type': 'application/json' }
                };
            }

            const newProduct = { id: `${Date.now()}`, name, price };
            products.push(newProduct);

            return {
                status: 201,
                body: JSON.stringify(newProduct),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        if (method === 'GET') {
            return {
                status: 200,
                body: JSON.stringify(products),
                headers: { 'Content-Type': 'application/json' }
            };
        }

        return {
            status: 405,
            body: JSON.stringify({ error: 'Method not allowed' }),
            headers: { 'Content-Type': 'application/json' }
        };
    }
});