Return-Path: <linux-tip-commits+bounces-5197-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B31AA78A3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 19:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84A15A099C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497C2571A9;
	Fri,  2 May 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u9cpXScg"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532D256C8B;
	Fri,  2 May 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206722; cv=none; b=c6UVFJn0xmkwD2jlvGCWs7eo3jboyfm9YSdpdF/YBMHyEjwlVsIFXCrvhz1VX4XhbnMHIGgBewxzdK5ImrBDLrpuSQd5Vgt1SkHbcTKVJrR9uQ5pnMrtvVgo9Y12d9B7VRVB4ANhVYK2raUdPq6+MI0ryn06mPum1wCrYNAMGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206722; c=relaxed/simple;
	bh=UtQh+/YSXXqkRAun9KktFMfLGSEdqy4gdJOL8UsStjU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1f0TJ8+88+1CLlTa5L8Ad2+6zfuFanK+CeUZgfZDq00zeghqvCdOAyQ1SmRrcKCsMb68295mwVp2jU1Z0dUP//lFPnwMO6K+agK8dwUgij9kXq97UhbBuDqm2PHybGKwTLdCvqT6SbQzWQisxyTZJtXzQ6gxrnz+6IqcJrHwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u9cpXScg; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746206720; x=1777742720;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=UtQh+/YSXXqkRAun9KktFMfLGSEdqy4gdJOL8UsStjU=;
  b=u9cpXScgSFK3Hjhr2QPpl4jKXRNdRPZfqLXF2ziF1jauzMtGP3dGF1gn
   aznB/tGnPSzfFfBpkngy/57spIkvnAFZ3+uRBiUmh8/xs/+ZxjLpOJc1O
   gWuUwMl//8FiYhAX/lm8l3hlgSxwGARsiiPYAHXt7czGseeDmtQysGJLk
   w=;
X-IronPort-AV: E=Sophos;i="6.15,257,1739836800"; 
   d="scan'208";a="192951124"
Subject: Re: EEVDF regression still exists
Thread-Topic: EEVDF regression still exists
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 17:25:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:26814]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.224:2525] with esmtp (Farcaster)
 id 68d9cd7a-6a75-4597-83ee-277d0e2c4386; Fri, 2 May 2025 17:25:15 +0000 (UTC)
X-Farcaster-Flow-ID: 68d9cd7a-6a75-4597-83ee-277d0e2c4386
Received: from EX19D001UWB004.ant.amazon.com (10.13.138.4) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 17:25:15 +0000
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19D001UWB004.ant.amazon.com (10.13.138.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 17:25:15 +0000
Received: from EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0]) by
 EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0%5]) with mapi id
 15.02.1544.014; Fri, 2 May 2025 17:25:15 +0000
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
Thread-Index: AQHbuU8Zth8BPweWAUWz5H5EpP8DD7O7+3yAgANMZ4A=
Date: Fri, 2 May 2025 17:25:14 +0000
Message-ID: <B27ECDA1-632D-44CD-AB99-B7A9C27393E4@amazon.com>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250430100259.GK4439@noisy.programming.kicks-ass.net>
In-Reply-To: <20250430100259.GK4439@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <65213DACC676A045A3614A07465F5362@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS0wNC0zMCwgMDU6MDMsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZyYWRlYWQu
b3JnIDxtYWlsdG86cGV0ZXJ6QGluZnJhZGVhZC5vcmc+PiB3cm90ZToNCg0KPiBBbnl3YXksIGxv
b2tpbmcgYXQgdGhlIHR3byBpbmRpdmlkdWFsIHJlcG9ydHMgc2lkZSBieSBzaWRlOg0KPg0KPiAt
IHNjaGVkdWxlKCkgbGVmdCB0aGUgcHJvY2Vzc29yIGlkbGUgLS0gaXMgdXANCj4NCj4gdnMuDQo+
DQo+IC0gcHVsbF90YXNrKCkgY291bnQgb24gY3B1IG5ld2x5IGlkbGUgLS0gaXMgZG93bg0KPiAt
IGxvYWRfYmFsYW5jZSgpIHN1Y2Nlc3MgY291bnQgb24gY3B1IG5ld2x5IGlkbGUgLS0gaXMgZG93
bg0KPg0KPiBXaGljaCBzZWVtIHJlbGF0ZWQgYW5kIHdvdWxkIHN1Z2dlc3Qgd2UgbG9vayBhdCBu
ZXdpZGxlIGJhbGFuY2UuIE9uZSBvZg0KPiB0aGUgdGhpbmdzIHdlJ3ZlIHNlZW4gYmVmb3JlIGlz
IHRoYXQgbmV3aWRsZSB3YXMgYWZmZWN0ZWQgYnkgdGhlIHNob3J0ZXINCj4gc2xpY2Ugb2YgRUVW
REYuIEJ1dCBpdCBpcyBhbHNvIHF1aXRlIHBvc3NpYmxlIHNvbWV0aGluZyBjaGFuZ2VkIGluIHRo
ZQ0KPiBsb2FkLWJhbGFuY2VyIGhlcmUuDQo+DQo+IEFsc28gb2Ygbm90ZSBpcyB0aGF0IC4xNSBz
ZWVtcyB0byBoYXZlIGEgbG93ZXIgbnVtYmVyIG9mICd0dHd1KCkgd2FzDQo+IGNhbGxlZCB0byB3
YWtlIHVwIG9uIHRoZSBsb2NhbCBjcHUnIC0tIHdoaWNoIEknbSBub3QgcXVpdGUgc3VyZSBob3cg
dG8NCj4gcmh5bWUgd2l0aCB0aGUgcHJldmlvdXMgb2JzZXJ2YXRpb24uIFRoZSBuZXdpZGxlIHRo
aW5nIHNlZW1zIHRvIHN1Z2dlc3QNCj4gbm90IGVub3VnaCBtaWdyYXRpb25zLCB3aGlsZSB0aGlz
IHdvdWxkIHN1Z2dlc3QgdG9vIG1hbnkgbWlncmF0aW9ucy4NCg0KQSAyeCBsb25nZXIgc2xpY2Ug
b24gNi4xNSBkb2VzIGltcHJvdmUgcGVyZm9ybWFuY2Ugc29tZSwgYnV0IG5vdCBieSBhIGxvdC4N
Ckkgd2VudCBiYWNrIHRvIGxvb2sgYXQgbXkgcHJldmlvdXMgdGVzdHMsIGFuZCBiYWNrIGluIFNl
cHRlbWJlciBJIGRpZCB0cnkNCm11bHRpcGxlIHNsaWNlIHZhbHVlcyAoMS41bXMsIDNtcywgNm1z
LCAxMm1zKSBvbiA2LjUgYW5kIDYuNi4gVGhlIHJlc3BvbnNlDQp3YXMgbm9pc3kgKG11Y2ggbGVz
cyBvbiBDRlMgaG93ZXZlciksIGFuZCBub3QgbGluZWFyLCBwZWFraW5nIGF0IDNtcy4NCkRvZXMg
dGhlIGxhY2sgb2YgbGluZWFyaXR5IG1hdGNoIHlvdXIgZXhwZWN0YXRpb25zPyBXb3VsZCBpdCBo
YXZlIHJlYXNvbg0KdG8gY2hhbmdlIGluIG1vcmUgcmVjZW50IGtlcm5lbHM/DQoNCkFub3RoZXIs
IG1vcmUgcmVjZW50IG9ic2VydmF0aW9uIGlzIHRoYXQgNi4xNS1yYzQgaGFzIHdvcnNlIHBlcmZv
cm1hbmNlIHRoYW4NCnJjMyBhbmQgZWFybGllciBrZXJuZWxzLiBNYXliZSB0aGF0IGNhbiBoZWxw
IG5hcnJvdyBkb3duIHRoZSBjYXVzZT8NCkkndmUgYWRkZWQgdGhlIHBlcmYgcmVwb3J0cyBmb3Ig
cmMzIGFuZCByYzIgaW4gdGhlIHNhbWUgbG9jYXRpb24gYXMgYmVmb3JlLg0KDQpodHRwczovL2dp
dGh1Yi5jb20vYXdzL3JlcHJvLWNvbGxlY3Rpb24vYmxvYi9tYWluL3JlcHJvcy9yZXByby1teXNx
bC1FRVZERi1yZWdyZXNzaW9uL3Jlc3VsdHMvMjAyNTA0MjgvUkVBRE1FLm1kI3Jhdy1kYXRhDQoN
Cg0K

