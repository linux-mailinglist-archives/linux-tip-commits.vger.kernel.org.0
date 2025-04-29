Return-Path: <linux-tip-commits+bounces-5137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50AAA3AFE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 00:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995187B61A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 22:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B126B972;
	Tue, 29 Apr 2025 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m1wyhlQZ"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D726A0CA;
	Tue, 29 Apr 2025 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964404; cv=none; b=iaTopyu93/x3YO0V0B2Mh9g35UZdlg/jAmWFKbSGaH9LpDXilucpRfzkAeXigEehfvGHhRAColJ9WBBG8rrrI26oMX7IaK4iabcyY24VqusTxr/o7a/BEG7wfrKQgWP6oS2Bp+mExyLQyPXIFq2UjmOk67BVESpxUio51O6P5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964404; c=relaxed/simple;
	bh=1qtA1j0MhbLF0zo1Nt4V6pirpw6boJzLVrd/FQprni8=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fP3Qn7HddIrKF0YUYDrqpjocX7aRN2sg0xtQl+WYrJer1r+taWdPR7TE5Ni0SJYNrLNEhNVOscBUkgKyRGQqHO2vhzFxadN6rafS3U+iRA6q/goWx9fOfeYjb9L1W4nnEQF0oVWebnOdHy8W7uSHwGbf+NLr4GEBmLhhKDm+D6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m1wyhlQZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745964403; x=1777500403;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=1qtA1j0MhbLF0zo1Nt4V6pirpw6boJzLVrd/FQprni8=;
  b=m1wyhlQZSobXjYzA6xxyv//pscYIfsExd42SCsbrG/84602FKiO+/whp
   7iB9fhkArDdv6hjuSUGrUGHpt97ALX79i6lqFYbdEDrAaWDP7jWiPxEZ0
   r1OcuQ8Nfy5BlImIAGTuA9XUARZccu1EWlvDXVzS/uMHwqQD+tl1Sp+sL
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,250,1739836800"; 
   d="scan'208";a="195640350"
Subject: Re: EEVDF regression still exists
Thread-Topic: EEVDF regression still exists
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 22:06:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:17678]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id 6f501886-48f9-40e5-bb89-67048c5aa3e8; Tue, 29 Apr 2025 22:06:41 +0000 (UTC)
X-Farcaster-Flow-ID: 6f501886-48f9-40e5-bb89-67048c5aa3e8
Received: from EX19D002UWC001.ant.amazon.com (10.13.138.148) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 22:06:40 +0000
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19D002UWC001.ant.amazon.com (10.13.138.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 22:06:40 +0000
Received: from EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0]) by
 EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0%5]) with mapi id
 15.02.1544.014; Tue, 29 Apr 2025 22:06:40 +0000
From: "Prundeanu, Cristian" <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, "Mohamed Abuelfotoh, Hazem"
	<abuehaze@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, "Blake, Geoff"
	<blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>, "Doebel, Bjoern"
	<doebel@amazon.de>, Gautham Shenoy <gautham.shenoy@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>, Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov
	<bp@alien8.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHbuU8Zth8BPweWAUWz5H5EpP8DD7O7MGMA//+vIgA=
Date: Tue, 29 Apr 2025 22:06:40 +0000
Message-ID: <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
In-Reply-To: <20250429215604.GE4439@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA0471B48DE52F47B5D491744D0CD7D6@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS0wNC0yOSwgMTY6NTcsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZyYWRlYWQu
b3JnIDxtYWlsdG86cGV0ZXJ6QGluZnJhZGVhZC5vcmc+PiB3cm90ZToNCg0KPj4gSGVyZSBhcmUg
dGhlIGxhdGVzdCByZXN1bHRzIGZvciB0aGUgRUVWREYgaW1wYWN0IG9uIGRhdGFiYXNlIHdvcmts
b2Fkcy4NCj4+IFRoZSByZWdyZXNzaW9uIGludHJvZHVjZWQgaW4ga2VybmVsIDYuNiBzdGlsbCBw
ZXJzaXN0cyBhbmQgZG9lc24ndCBsb29rDQo+PiBsaWtlIGl0IGlzIGltcHJvdmluZy4NCj4NCj4g
V2VsbCwgSSB3YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gaXQgaGFkIGFjdHVhbGx5IGJlZW4gc29s
dmVkIDotKA0KPg0KPiBNeSB1bmRlcnN0YW5kaW5nIGZyb20gdGhlIGxhc3Qgcm91bmQgd2FzIHRo
YXQgUHJhdGVlayBhbmQgY28gaGFkIGl0DQo+IHNvcnRlZCAtLSB3aXRoIHRoZSBjYXZlYXQgYmVp
bmcgdGhhdCB5b3UgaGFkIHRvIHN0aWNrIFNDSEVEX0JBVENIIGluIGF0DQo+IHRoZSByaWdodCBw
bGFjZSBpbiBNeVNRTCBzdGFydCBzY3JpcHRzIG9yIHNvbWVzdWNoLg0KDQpUaGUgc3RhdGVtZW50
IGluIHRoZSBwcmV2aW91cyB0aHJlYWQgWzFdIHdhcyB0aGF0IHVzaW5nIFNDSEVEX0JBVENIIGlt
cHJvdmVzIA0KcGVyZm9ybWFuY2Ugb3ZlciBkZWZhdWx0LiBXaGlsZSB0aGF0IHN0aWxsIGhvbGRz
IHRydWUsIGl0IGlzIGFsc28gZXF1YWxseSB0cnVlDQphYm91dCB1c2luZyBTQ0hFRF9CQVRDSCBv
biBrZXJuZWwgNi41Lg0KDQpTbywgd2hlbiB3ZSBjb21wYXJlIDYuNSB3aXRoIHJlY2VudCBrZXJu
ZWxzLCBib3RoIHVzaW5nIFNDSEVEX0JBVENILCB0aGUNCnJlZ3Jlc3Npb24gaXMgc3RpbGwgdmlz
aWJsZS4gKFByZXZpb3VzbHksIHdlIG9ubHkgY29tcGFyZWQgU0NIRURfQkFUQ0ggd2l0aCANCjYu
NSBkZWZhdWx0LCBsZWFkaW5nIHRvIHRoZSB3cm9uZyBjb25jbHVzaW9uIHRoYXQgaXQncyBhIGZp
eCkuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZmViMzFiNmUtNjQ1Ny00NTRj
LWE0ZjMtY2U4YWQ5NmJmOGRlQGFtZC5jb20vDQoNCg==

