Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD7354F28
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Apr 2021 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbhDFI5C (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 6 Apr 2021 04:57:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:30558 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233699AbhDFI5B (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 6 Apr 2021 04:57:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-126-vPukl6C-OxGNg1paIUO4AQ-1; Tue, 06 Apr 2021 09:56:51 +0100
X-MC-Unique: vPukl6C-OxGNg1paIUO4AQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 6 Apr 2021 09:56:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 6 Apr 2021 09:56:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [tip: x86/core] x86/retpoline: Simplify retpolines
Thread-Topic: [tip: x86/core] x86/retpoline: Simplify retpolines
Thread-Index: AQHXKHopPLGFwLry8kOWcNAZwnZnsaqnMt5w
Date:   Tue, 6 Apr 2021 08:56:50 +0000
Message-ID: <27229f2320a446bf8342233c2555ea8d@AcuMS.aculab.com>
References: <20210326151259.506071949@infradead.org>
 <161744825969.29796.5634030362499829701.tip-bot2@tip-bot2>
In-Reply-To: <161744825969.29796.5634030362499829701.tip-bot2@tip-bot2>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

RnJvbTogdGlwLWJvdDJAbGludXRyb25peC5kZQ0KPiBTZW50OiAwMyBBcHJpbCAyMDIxIDEyOjEx
DQouLi4NCj4gTm90aWNlIHRoYXQgc2luY2UgdGhlIGxvbmdlc3QgYWx0ZXJuYXRpdmUgc2VxdWVu
Y2UgaXMgbm93Og0KPiANCj4gICAgMDogICBlOCAwNyAwMCAwMCAwMCAgICAgICAgICBjYWxscSAg
YyA8LmFsdGluc3RyX3JlcGxhY2VtZW50KzB4Yz4NCj4gICAgNTogICBmMyA5MCAgICAgICAgICAg
ICAgICAgICBwYXVzZQ0KPiAgICA3OiAgIDBmIGFlIGU4ICAgICAgICAgICAgICAgIGxmZW5jZQ0K
PiAgICBhOiAgIGViIGY5ICAgICAgICAgICAgICAgICAgIGptcCAgICA1IDwuYWx0aW5zdHJfcmVw
bGFjZW1lbnQrMHg1Pg0KPiAgICBjOiAgIDQ4IDg5IDA0IDI0ICAgICAgICAgICAgIG1vdiAgICAl
cmF4LCglcnNwKQ0KPiAgIDEwOiAgIGMzICAgICAgICAgICAgICAgICAgICAgIHJldHENCj4gDQo+
IDE3IGJ5dGVzLCB3ZSBoYXZlIDE1IGJ5dGVzIE5PUCBhdCB0aGUgZW5kIG9mIG91ciAzMiBieXRl
IHNsb3QuIChJT1csIGlmDQo+IHdlIGNhbiBzaHJpbmsgdGhlIHJldHBvbGluZSBieSAxIGJ5dGUg
d2UgY2FuIHBhY2sgaXQgbW9yZSBkZW5zZWx5KS4NCg0KRXZlcnkgdGltZSBJIHNlZSB0aGlzIEkg
Y2FuJ3QgaGVscCBmZWVsaW5nIHRoYXQgZG9pbmcgc29tZXRoaW5nDQooYWthIGFueXRoaW5nKSB0
byBnZXQgdGhlICdtb3YnIGFuZCAncmV0cScgaW50byB0aGUgc2FtZSAxNiBieXRlDQpjb2RlIGZl
dGNoL2RlY29kZSBibG9jayBidXQgYmUgYWR2YW50YWdlb3VzLg0KDQpFdmVuIHNvbWV0aGluZyBs
aWtlOg0KCWNhbGwJMWYNCglwYXVzZQ0KCWptcCAJMmYNCjE6CW1vdgklcmF4LCglcnNwKQ0KCXJl
dHENCjI6CXBhdXNlDQoJbGZlbmNlDQoJam1wCTJiDQpNaWdodCBtZWV0IGFsbCB0aGUgcmVxdWly
ZW1lbnRzIGZvciB0aGUgcmV0cG9saW5lIHdoaWxlDQphbGxvd2luZyB0aGUgJ21vdicgYW5kICdy
ZXRxJyBiZSBkZWNvZGVkIGluIHRoZSBzYW1lIGNsb2NrLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

