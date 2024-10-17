Return-Path: <linux-tip-commits+bounces-2502-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8FB9A2C03
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C8A1F22F59
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9A1E00BC;
	Thu, 17 Oct 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TH5hVLHT"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B161E0B74;
	Thu, 17 Oct 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189147; cv=none; b=McUjL/seLxepv3o8z94c3IU3RiiO6sdBoTF5NS7hryNja27lUhemSwPeyxLfCHCYlQy7fCtFSSOulCDl4PEKgkO3fEgDIj0mXvFHq0upjNT1W/OtDlGwQWLxFty0jQ7lNuLtCRnxmbkcwdqIzP4hiwGb+ch2qMmre4xUep5lmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189147; c=relaxed/simple;
	bh=fXEFBLprEv0YLfdPXE1r1CxLoSDsy2diw/4xbhmsTV0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rC9+v3mBf74V3AW6XnBgq2AY6jXXqPFUJC3jhh7ClUj3PmRdQ/xMuTCE5kf55Zp1RAJH4WInYJUXn+N6h9e26VJcTLmd4O31o4YP/HpFJqKCebfPHoGUQFx434e2Po7DIihsT7a3F4vO4v87AAqXFFQjKfCyX+1C4H3oKRdj3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TH5hVLHT; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729189143; x=1760725143;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=fXEFBLprEv0YLfdPXE1r1CxLoSDsy2diw/4xbhmsTV0=;
  b=TH5hVLHTYZghbSUgzAj/RDj7auHGJF4bL6zPiLMOdogDcPCz0tHcjJLY
   T3CBAlbfxtcqXriYAXOJSlOzGsBFxuBPZd0ZKfTzAYV62KRVNY/25F14f
   vZmlqbsyLkjMzQpPMnd9+ZZGTSTs9yvX/p9ib27o+K+IVRNp3JR+2a+wT
   k=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="441687331"
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY
 and move them to sysctl
Thread-Topic: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and
 move them to sysctl
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:19:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63021]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 58932c62-ec00-494b-951d-098c14c64007; Thu, 17 Oct 2024 18:19:00 +0000 (UTC)
X-Farcaster-Flow-ID: 58932c62-ec00-494b-951d-098c14c64007
Received: from EX19D002UWA003.ant.amazon.com (10.13.138.235) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:19:00 +0000
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19D002UWA003.ant.amazon.com (10.13.138.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:19:00 +0000
Received: from EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0]) by
 EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0%5]) with mapi id
 15.02.1258.034; Thu, 17 Oct 2024 18:19:00 +0000
From: "Prundeanu, Cristian" <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Doebel, Bjoern" <doebel@amazon.de>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Blake, Geoff"
	<blakgeof@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Csoma, Csaba"
	<csabac@amazon.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
Thread-Index: AQHbIFRAqYP/Spxn4UemHlrRfl1T1LKKqDIAgABFZAA=
Date: Thu, 17 Oct 2024 18:19:00 +0000
Message-ID: <70D6B66E-B4BC-4A92-9A23-0DADE9B8C3FE@amazon.com>
References: <20241017052000.99200-1-cpru@amazon.com>
 <20241017091036.GT16066@noisy.programming.kicks-ass.net>
In-Reply-To: <20241017091036.GT16066@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F9FFA42DE25784ABF5266EF6A736DD5@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC0xMC0xNywgMDQ6MTEsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZyYWRlYWQu
b3JnPiB3cm90ZToNCg0KPj4gRm9yIGV4YW1wbGUsIHJ1bm5pbmcgbXlzcWwraGFtbWVyZGIgcmVz
dWx0cyBpbiBhIDEyLTE3JSB0aHJvdWdocHV0DQo+IEdhdXRoYW0sIGlzIHRoaXMgYSBiZW5jaG1h
cmsgeW91J3JlIHJ1bm5pbmc/DQoNCk1vc3Qgb2YgbXkgdGVzdGluZyBmb3IgdGhpcyBpbnZlc3Rp
Z2F0aW9uIGlzIG9uIG15c3FsK2hhbW1lcmRiIGJlY2F1c2UgaXQNCnNpbXBsaWZpZXMgZGlmZmVy
ZW50aWF0aW5nIHN0YXRpc3RpY2FsbHkgbWVhbmluZ2Z1bCByZXN1bHRzLCBidXQNCnBlcmZvcm1h
bmNlIGltcGFjdCAoYW5kIGltcHJvdmVtZW50IGZyb20gZGlzYWJsaW5nIHRoZSB0d28gZmVhdHVy
ZXMpIGFsc28NCnNob3dzIG9uIHdvcmtsb2FkcyBiYXNlZCBvbiBwb3N0Z3Jlc3FsIGFuZCBvbiB3
b3JkcHJlc3MrbmdpbnguDQoNCj4gSG93IGRvZXMgdXNpbmcgU0NIRURfQkFUQ0ggY29tcGFyZT8N
Cg0KSSBoYXZlbid0IHRlc3RlZCB3aXRoIFNDSEVEX0JBVENIIHlldCwgd2lsbCB1cGRhdGUgdGhl
IHRocmVhZCB3aXRoIHJlc3VsdHMgDQphcyB0aGV5IGFjY3VtdWxhdGUgKGVhY2ggdmFyaWF0aW9u
IG9mIHRoZSB0ZXN0IHRha2VzIG11bHRpcGxlIGhvdXJzLCBub3QNCmNvdW50aW5nIHJlc3VsdCBw
cm9jZXNzaW5nIGFuZCBldmFsdWF0aW9uKS4NCg0KTG9va2luZyBhdCBtYW4gc2NoZWQgZm9yIFND
SEVEX0JBVENIOiAidGhlIHNjaGVkdWxlciB3aWxsIGFwcGx5IGEgc21hbGwNCnNjaGVkdWxpbmcg
cGVuYWx0eSB3aXRoIHJlc3BlY3QgdG8gd2FrZXVwIGJlaGF2aW9yLCBzbyB0aGF0IHRoaXMgdGhy
ZWFkIGlzDQptaWxkbHkgZGlzZmF2b3JlZCBpbiBzY2hlZHVsaW5nIGRlY2lzaW9ucyIuIFdvdWxk
IHRoaXMgY29ycmVjdGx5IHRyYW5zbGF0ZQ0KdG8gInRoZSB0aHJlYWQgd2lsbCBydW4gbW9yZSBk
ZXRlcm1pbmlzdGljYWxseSwgYnV0IGJlIHNjaGVkdWxlZCBsZXNzDQpmcmVxdWVudGx5IHRoYW4g
b3RoZXIgdGhyZWFkcyIsIGkuZS4gZXhwZWN0ZWRseSBsb3dlciBwZXJmb3JtYW5jZSBpbiANCmV4
Y2hhbmdlIGZvciBsZXNzIHZhcmlhYmlsaXR5Pw0KDQo+IFNvIGRpc2FibGluZyB0aGVtIGJ5IGRl
ZmF1bHQgd2lsbCB1bmRvdWJ0ZWRseSBhZmZlY3QgYSB0b24gb2Ygb3RoZXINCj4gd29ya2xvYWRz
Lg0KDQpUaGF0J3MgdmVyeSBsaWtlbHkgZWl0aGVyIHdheSwgYXMgdGhlIHRlc3Rpbmcgc3BhY2Ug
aXMgbmVhciBpbmZpbml0ZSwgYnV0IA0KaXQgc2VlbXMgbW9yZSBwcmFjdGljYWwgdG8gZmlyc3Qg
YWRkcmVzcyB0aGUgaXNzdWUgd2UgYWxyZWFkeSBrbm93IGFib3V0Lg0KDQpBdCB0aGlzIHRpbWUs
IEkgZG9uJ3QgaGF2ZSBhbnkgZGF0YSBwb2ludHMgdG8gaW5kaWNhdGUgYSBuZWdhdGl2ZQ0KaW1w
YWN0IG9mIGRpc2FibGluZyB0aGVtIGZvciBwb3B1bGFyIHByb2R1Y3Rpb24gd29ya2xvYWRzIChh
cyBvcHBvc2VkIHRvDQp0aGUgZmxpcCBjYXNlKS4gTW9yZSB0ZXN0aW5nIGlzIGluIHByb2dyZXNz
IChsb29raW5nIGF0IHRoZSBtYWpvciBhcmVhczoNCndvcmtsb2FkcyBoZWF2eSBvbiBDUFUsIFJB
TSwgZGlzaywgYW5kIG5ldHdvcmtpbmcpOyBzbyBmYXIsIHRoZSByZXN1bHRzDQpzaG93IG5vIGRv
d25zaWRlLg0KDQo+IEFuZCBzeXNjdGwgaXMgYXJndWFibHkgbW9yZSBvZiBhbiBBQkkgdGhhbiBk
ZWJ1Z2ZzLCB3aGljaA0KPiBkb2Vzbid0IHJlYWxseSBzb3VuZCBzdWl0YWJsZSBmb3Igd29ya2Fy
b3VuZC4NCj4NCj4gQW5kIEkgZG9uJ3Qgc2VlIGhvdyBhZGRpbmcgYSBsaW5lIHRvIC9ldGMvcmMu
bG9jYWwgaXMgaGFyZGVyIHRoYW4gYWRkaW5nDQo+IGEgbGluZSB0byAvZXRjL3N5c2N0bC5jb25m
DQoNCkFkZGluZyBhIGxpbmUgaXMgZXF1YWxseSBkaWZmaWN1bHQgYm90aCB3YXlzLCB5b3UncmUg
cmlnaHQuIEJ1dCBhcmVuJ3QgDQptb3N0IGRpc3Ryb3MgYmV0dGVyIGVxdWlwcGVkIHRvIG1hbmFn
ZSAocGVyc2lzdCwgbW9kaWZ5LCBhdXRvbWF0ZSkgc3lzY3RsIA0KcGFyYW1ldGVycyBpbiBhIHN0
YW5kYXJkaXplZCBtYW5uZXI/DQpXaGVyZWFzIHJjLmxvY2FsIHNlZW1zIG1vcmUgImluZGl2aWR1
YWwgbmVlZCAvIGVkZ2UgY2FzZSIgb3JpZW50ZWQuIEZvcg0KaW5zdGFuY2U6IGNoYW5nZXMgYXJl
IGRvbmUgYnkgZWRpdGluZyB0aGUgZmlsZSwgd2hpY2ggaXMgcG9vcmx5IHNjcmlwdGFibGUNCih1
bmxpa2UgdGhlIHN5c2N0bCBjb21tYW5kLCB3aGljaCBpcyBhIHVuaWZpZWQgaW50ZXJmYWNlIHRo
YXQgcmVjb25jaWxlcw0KY2hhbmdlcyk7IHRoZSBsb2FkIG9yZGVyIGlzIGFsc28gdHlwaWNhbGx5
IGxhdGUgaW4gdGhlIGJvb3Qgc3RhZ2UsIG1ha2luZyAgIA0KaXQgbm90IGFuIGlkZWFsIHBsYWNl
IGZvciBzZXR0aW5ncyB0aGF0IGFmZmVjdCBzeXN0ZW0gcHJvY2Vzc2VzLg0KDQo=

