import 'package:flutter/material.dart';
import 'package:transaction_dispute/constants/string_constant.dart';

final cardData = [
  {
    'id': 'visa_1234',
    'imgIcon': StringConstant.visa,
    'cardNumber': '**** **** **** 1234',
    'name': 'Yushun Gong',
    'expiryDate': '07/26',
    'dueAmount': '5000',
    'colorCombo': [Color(0xFF1F2A44), Color(0xFF3B4D73)]
  },
  {
    'id': 'mastercard_5678',
    'imgIcon': StringConstant.masterCard,
    'cardNumber': '**** **** **** 5678',
    'name': 'Yushun Gong',
    'expiryDate': '12/25',
    'dueAmount': '12000',
    'colorCombo': [Color(0xFF0A2C47), Color(0xFFDA4D3D)]
  },
  {
    'id': 'amex_9101',
    'imgIcon': StringConstant.amex,
    'cardNumber': '**** **** **** 9101',
    'name': 'Yushun Gong',
    'expiryDate': '09/27',
    'dueAmount': '4500',
    'colorCombo': [Color(0xFF1E2D3B), Color(0xFF6C8B8F)]
  },
  {
    'id': 'discover_2345',
    'imgIcon': StringConstant.discover,
    'cardNumber': '**** **** **** 2345',
    'name': 'Yushun Gong',
    'expiryDate': '03/24',
    'dueAmount': '2010',
    'colorCombo': [Color(0xFF2C3E50), Color(0xFF9B59B6)]
  },
  {
    'id': 'unionpay_1334',
    'imgIcon': StringConstant.unionpay,
    'cardNumber': '**** **** **** 1334',
    'name': 'Yushun Gong',
    'expiryDate': '02/36',
    'dueAmount': '1060',
    'colorCombo': [Color(0xFFDA4D3D), Color(0xFF9B59B6)]
  },
];

const transactionData = [
  {
    "transactionId": "txn_1a2b3c",
    "refNumber": "REF-AB1234567890",
    "cardId": "visa_1234",
    "transactionName": "Uber Ride",
    "amount": "\$12",
    "credited": false,
    "date": "2024-10-01"
  },
  {
    "transactionId": "txn_4d5e6f",
    "refNumber": "REF-BC2345678901",
    "cardId": "visa_1234",
    "transactionName": "McDonald's",
    "amount": "\$8.50",
    "credited": false,
    "date": "2024-09-28"
  },
  {
    "transactionId": "txn_7g8h9i",
    "refNumber": "REF-CD3456789012",
    "cardId": "visa_1234",
    "transactionName": "Amazon Purchase",
    "amount": "\$45.99",
    "credited": false,
    "date": "2024-09-26"
  },
  {
    "transactionId": "txn_0j1k2l",
    "refNumber": "REF-DE4567890123",
    "cardId": "mastercard_5678",
    "transactionName": "Salary Credited",
    "amount": "\$3000",
    "credited": true,
    "date": "2024-09-25"
  },
  {
    "transactionId": "txn_3m4n5o",
    "refNumber": "REF-EF5678901234",
    "cardId": "mastercard_5678",
    "transactionName": "Gas Station",
    "amount": "\$40",
    "credited": false,
    "date": "2024-11-22"
  },
  {
    "transactionId": "txn_6p7q8r",
    "refNumber": "REF-FG6789012345",
    "cardId": "mastercard_5678",
    "transactionName": "Netflix Subscription",
    "amount": "\$15.99",
    "credited": false,
    "date": "2024-09-20"
  },
  {
    "transactionId": "txn_9s0t1u",
    "refNumber": "REF-GH7890123456",
    "cardId": "amex_9101",
    "transactionName": "Starbucks",
    "amount": "\$5.25",
    "credited": false,
    "date": "2024-10-18"
  },
  {
    "transactionId": "txn_2v3w4x",
    "refNumber": "REF-HI8901234567",
    "cardId": "amex_9101",
    "transactionName": "Flight Ticket",
    "amount": "\$250",
    "credited": false,
    "date": "2024-11-15"
  },
  {
    "transactionId": "txn_5y6z7a",
    "refNumber": "REF-IJ9012345678",
    "cardId": "mastercard_5678",
    "transactionName": "ATM Withdrawal",
    "amount": "\$100",
    "credited": false,
    "date": "2024-10-12"
  },
  {
    "transactionId": "txn_8b9c0d",
    "refNumber": "REF-JK0123456789",
    "cardId": "discover_2345",
    "transactionName": "Medical Insurance",
    "amount": "\$75",
    "credited": false,
    "date": "2024-10-10"
  },
  {
    "transactionId": "txn_1e2f3g",
    "refNumber": "REF-KL1234567890",
    "cardId": "amex_9101",
    "transactionName": "Freelance Payment",
    "amount": "\$500",
    "credited": true,
    "date": "2024-10-08"
  },
  {
    "transactionId": "txn_4h5i6j",
    "refNumber": "REF-LM2345678901",
    "cardId": "visa_1234",
    "transactionName": "Grocery Shopping",
    "amount": "\$60",
    "credited": false,
    "date": "2024-11-05"
  },
  {
    "transactionId": "txn_7k8l9m",
    "refNumber": "REF-MN3456789012",
    "cardId": "discover_2345",
    "transactionName": "Gym Membership",
    "amount": "\$25",
    "credited": false,
    "date": "2024-11-03"
  },
  {
    "transactionId": "txn_0n1o2p",
    "refNumber": "REF-NO4567890123",
    "cardId": "visa_1234",
    "transactionName": "Movie Tickets",
    "amount": "\$30",
    "credited": false,
    "date": "2024-12-02"
  },
  {
    "transactionId": "txn_3q4r5s",
    "refNumber": "REF-OP5678901234",
    "cardId": "mastercard_5678",
    "transactionName": "Online Course",
    "amount": "\$99.99",
    "credited": false,
    "date": "2024-12-01"
  },
  {
    "transactionId": "txn_6t7u8v",
    "refNumber": "REF-PQ6789012345",
    "cardId": "amex_9101",
    "transactionName": "Restaurant Bill",
    "amount": "\$85.75",
    "credited": false,
    "date": "2024-10-15"
  },
  {
    "transactionId": "txn_9w0x1y",
    "refNumber": "REF-QR7890123456",
    "cardId": "discover_2345",
    "transactionName": "Electricity Bill",
    "amount": "\$120",
    "credited": false,
    "date": "2024-10-20"
  },
  {
    "transactionId": "txn_2z3a4b",
    "refNumber": "REF-RS8901234567",
    "cardId": "mastercard_5678",
    "transactionName": "Concert Tickets",
    "amount": "\$150",
    "credited": false,
    "date": "2024-10-25"
  },
  {
    "transactionId": "txn_5c6d7e",
    "refNumber": "REF-ST9012345678",
    "cardId": "visa_1234",
    "transactionName": "Spotify Subscription",
    "amount": "\$9.99",
    "credited": false,
    "date": "2024-10-30"
  },
  {
    "transactionId": "txn_8f9g0h",
    "refNumber": "REF-TU0123456789",
    "cardId": "amex_9101",
    "transactionName": "Hotel Stay",
    "amount": "\$200",
    "credited": false,
    "date": "2024-11-05"
  },
  {
    "transactionId": "txn_1x2y3z",
    "refNumber": "REF-UV1234567890",
    "cardId": "discover_2345",
    "transactionName": "Bookstore Purchase",
    "amount": "\$35.50",
    "credited": false,
    "date": "2024-11-10"
  },
  {
    "transactionId": "txn_4a5b6c",
    "refNumber": "REF-VW2345678901",
    "cardId": "visa_1234",
    "transactionName": "Theme Park Tickets",
    "amount": "\$120",
    "credited": false,
    "date": "2024-11-15"
  },
  {
    "transactionId": "txn_7d8e9f",
    "refNumber": "REF-WX3456789012",
    "cardId": "mastercard_5678",
    "transactionName": "Furniture Shopping",
    "amount": "\$400",
    "credited": false,
    "date": "2024-11-20"
  },
  {
    "transactionId": "txn_0g1h2i",
    "refNumber": "REF-XY4567890123",
    "cardId": "amex_9101",
    "transactionName": "Tech Gadget Purchase",
    "amount": "\$199.99",
    "credited": false,
    "date": "2024-11-25"
  },
  {
    "transactionId": "txn_3j4k5l",
    "refNumber": "REF-YZ5678901234",
    "cardId": "discover_2345",
    "transactionName": "Fast Food Order",
    "amount": "\$15.75",
    "credited": false,
    "date": "2024-11-30"
  },
  {
    "transactionId": "txn_6m7n8o",
    "refNumber": "REF-ZA6789012345",
    "cardId": "visa_1234",
    "transactionName": "Grocery Shopping",
    "amount": "\$75.25",
    "credited": false,
    "date": "2024-12-05"
  },
  {
    "transactionId": "txn_9p0q1r",
    "refNumber": "REF-AB7890123456",
    "cardId": "mastercard_5678",
    "transactionName": "Movie Tickets",
    "amount": "\$25",
    "credited": false,
    "date": "2024-12-10"
  },
  {
    "transactionId": "txn_2s3t4u",
    "refNumber": "REF-BC8901234567",
    "cardId": "amex_9101",
    "transactionName": "Online Course",
    "amount": "\$99.99",
    "credited": false,
    "date": "2024-12-15"
  },
  {
    "transactionId": "txn_5v6w7x",
    "refNumber": "REF-CD9012345678",
    "cardId": "discover_2345",
    "transactionName": "Clothing Purchase",
    "amount": "\$60",
    "credited": false,
    "date": "2024-12-20"
  },
  {
    "transactionId": "txn_8y9z0a",
    "refNumber": "REF-DE0123456789",
    "cardId": "visa_1234",
    "transactionName": "Car Maintenance",
    "amount": "\$150",
    "credited": false,
    "date": "2024-12-25"
  },
  {
    "transactionId": "txn_1b2c3d",
    "refNumber": "REF-EF1234567890",
    "cardId": "mastercard_5678",
    "transactionName": "Gym Membership",
    "amount": "\$50",
    "credited": false,
    "date": "2024-12-30"
  },
  {
    "transactionId": "txn_4e5f6g",
    "refNumber": "REF-FG2345678901",
    "cardId": "amex_9101",
    "transactionName": "New Year Party",
    "amount": "\$100",
    "credited": false,
    "date": "2025-01-01"
  },
  {
    "transactionId": "txn_7h8i9j",
    "refNumber": "REF-GH3456789012",
    "cardId": "discover_2345",
    "transactionName": "Flight Tickets",
    "amount": "\$300",
    "credited": false,
    "date": "2025-01-05"
  },
  {
    "transactionId": "txn_0k1l2m",
    "refNumber": "REF-HI4567890123",
    "cardId": "visa_1234",
    "transactionName": "Restaurant Dinner",
    "amount": "\$90",
    "credited": false,
    "date": "2025-01-10"
  },
  {
    "transactionId": "txn_3n4o5p",
    "refNumber": "REF-IJ5678901234",
    "cardId": "mastercard_5678",
    "transactionName": "Mobile Recharge",
    "amount": "\$20",
    "credited": false,
    "date": "2025-01-15"
  },
  {
    "transactionId": "txn_6q7r8s",
    "refNumber": "REF-JK6789012345",
    "cardId": "amex_9101",
    "transactionName": "Netflix Subscription",
    "amount": "\$15",
    "credited": false,
    "date": "2025-01-20"
  },
  {
    "transactionId": "txn_9t0u1v",
    "refNumber": "REF-KL7890123456",
    "cardId": "discover_2345",
    "transactionName": "Coffee Shop",
    "amount": "\$10",
    "credited": false,
    "date": "2025-01-25"
  },
  {
    "transactionId": "txn_2w3x4y",
    "refNumber": "REF-LM8901234567",
    "cardId": "visa_1234",
    "transactionName": "Pet Supplies",
    "amount": "\$45",
    "credited": false,
    "date": "2025-01-30"
  },
  {
    "transactionId": "txn_5z6a7b",
    "refNumber": "REF-MN9012345678",
    "cardId": "mastercard_5678",
    "transactionName": "Home Decor",
    "amount": "\$80",
    "credited": false,
    "date": "2025-02-05"
  }
];

List<String> creditCardServices = [
  "Transaction History & Statements",
  "Real-time Spending Alerts",
  "Bill Payments & Autopay",
  "Rewards & Cashback Management",
  "Credit Score Monitoring",
  "EMI Conversion & Loan Offers",
  "Card Controls & Security",
  "Virtual Card & Contactless Payments",
  "Dispute Resolution & Fraud Reporting",
  "Offers, Discounts & Personalized Insights",
];
