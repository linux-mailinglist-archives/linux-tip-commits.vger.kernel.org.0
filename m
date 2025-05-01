Return-Path: <linux-tip-commits+bounces-5154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C68AA6142
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 May 2025 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1084C09E9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 May 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7701DDC07;
	Thu,  1 May 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HqI8NTZg"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562583D6A;
	Thu,  1 May 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116174; cv=none; b=fD/59Qii+wv2cVBaUxx7K63RV6qSJ2P+cHJJLBrci/mJvY3nuJY/YRjgsjuXN8nHIFGsCif9mRlxQivxr4S1C8FMmX7qW2kh8duw/VPe591+9NSIS4B62z6TN/e6OF2dQf7x1swvdQLYFV4daCKD4JtMEEA4DBhRe+ee3cQYYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116174; c=relaxed/simple;
	bh=68WD7LAngpU8BrmhTtDG4Cffchmjc7fJ7Z8I1OciBtw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4VRj98VhSc3z/Kwlxg+vFgG2TQyZxdIToh/nNTQykBp8K7ZUir8bNSnzy0lIAWFwJvg7U4u7JWBvthzjfMDXKHqbbjKpoUvN55+wVBgKzGQiv3rVgnvz6ew5Ri5sMo77f5qgDxGjEiYEvHjBSnhZ3O8VhWY21nYwsSsm0G6vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HqI8NTZg; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746116172; x=1777652172;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=68WD7LAngpU8BrmhTtDG4Cffchmjc7fJ7Z8I1OciBtw=;
  b=HqI8NTZgnZGCMs9Z8/bhZBTFD1VfpKBoVDW+COegMhr1qSvkU7lEvIfv
   A/Ba9Tzq1fM3wxGRhhzBQuJNID92KqGFxRycliOjZQcnikpA+bqSsD2U1
   G14g72RP28MUAcoFt/iHjvDmEYLQiPQ+PZZoHtmklgQJHc6Rg1JT/onV5
   U=;
X-IronPort-AV: E=Sophos;i="6.15,254,1739836800"; 
   d="scan'208";a="88886624"
Subject: Re: EEVDF regression still exists
Thread-Topic: EEVDF regression still exists
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 16:16:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:27702]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.121:2525] with esmtp (Farcaster)
 id 283e62a4-dd8d-48b5-a701-5daaa4902eb2; Thu, 1 May 2025 16:16:09 +0000 (UTC)
X-Farcaster-Flow-ID: 283e62a4-dd8d-48b5-a701-5daaa4902eb2
Received: from EX19D002UWA003.ant.amazon.com (10.13.138.235) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 16:16:08 +0000
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19D002UWA003.ant.amazon.com (10.13.138.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 16:16:08 +0000
Received: from EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0]) by
 EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0%5]) with mapi id
 15.02.1544.014; Thu, 1 May 2025 16:16:08 +0000
From: "Prundeanu, Cristian" <cpru@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Blake, Geoff" <blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>,
	"Doebel, Bjoern" <doebel@amazon.de>, Gautham Shenoy <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Joseph Salisbury
	<joseph.salisbury@oracle.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHbuU8Zth8BPweWAUWz5H5EpP8DD7O7MGMA//+vIgCAAK8gAIACE5kA
Date: Thu, 1 May 2025 16:16:07 +0000
Message-ID: <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
In-Reply-To: <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <484B6C8D7F1B3F4A8E437F24A6B4BA6E@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUHJhdGVlaywNCg0K77u/T24gMjAyNS0wNC0yOSwgMjI6MzMsICJLIFByYXRlZWsgTmF5YWsi
IDxrcHJhdGVlay5uYXlha0BhbWQuY29tIDxtYWlsdG86a3ByYXRlZWsubmF5YWtAYW1kLmNvbT4+
IHdyb3RlOg0KDQo+Pj4+IEhlcmUgYXJlIHRoZSBsYXRlc3QgcmVzdWx0cyBmb3IgdGhlIEVFVkRG
IGltcGFjdCBvbiBkYXRhYmFzZSB3b3JrbG9hZHMuDQo+Pj4+IFRoZSByZWdyZXNzaW9uIGludHJv
ZHVjZWQgaW4ga2VybmVsIDYuNiBzdGlsbCBwZXJzaXN0cyBhbmQgZG9lc24ndCBsb29rDQo+Pj4+
IGxpa2UgaXQgaXMgaW1wcm92aW5nLg0KPj4+DQo+Pj4gV2VsbCwgSSB3YXMgdW5kZXIgdGhlIGlt
cHJlc3Npb24gaXQgaGFkIGFjdHVhbGx5IGJlZW4gc29sdmVkIDotKA0KPj4+DQo+Pj4gTXkgdW5k
ZXJzdGFuZGluZyBmcm9tIHRoZSBsYXN0IHJvdW5kIHdhcyB0aGF0IFByYXRlZWsgYW5kIGNvIGhh
ZCBpdA0KPj4+IHNvcnRlZCAtLSB3aXRoIHRoZSBjYXZlYXQgYmVpbmcgdGhhdCB5b3UgaGFkIHRv
IHN0aWNrIFNDSEVEX0JBVENIIGluIGF0DQo+Pj4gdGhlIHJpZ2h0IHBsYWNlIGluIE15U1FMIHN0
YXJ0IHNjcmlwdHMgb3Igc29tZXN1Y2guDQo+Pg0KPj4gVGhlIHN0YXRlbWVudCBpbiB0aGUgcHJl
dmlvdXMgdGhyZWFkIFsxXSB3YXMgdGhhdCB1c2luZyBTQ0hFRF9CQVRDSCBpbXByb3Zlcw0KPj4g
cGVyZm9ybWFuY2Ugb3ZlciBkZWZhdWx0LiBXaGlsZSB0aGF0IHN0aWxsIGhvbGRzIHRydWUsIGl0
IGlzIGFsc28gZXF1YWxseSB0cnVlDQo+PiBhYm91dCB1c2luZyBTQ0hFRF9CQVRDSCBvbiBrZXJu
ZWwgNi41Lg0KPj4NCj4+IFNvLCB3aGVuIHdlIGNvbXBhcmUgNi41IHdpdGggcmVjZW50IGtlcm5l
bHMsIGJvdGggdXNpbmcgU0NIRURfQkFUQ0gsIHRoZQ0KPj4gcmVncmVzc2lvbiBpcyBzdGlsbCB2
aXNpYmxlLiAoUHJldmlvdXNseSwgd2Ugb25seSBjb21wYXJlZCBTQ0hFRF9CQVRDSCB3aXRoDQo+
PiA2LjUgZGVmYXVsdCwgbGVhZGluZyB0byB0aGUgd3JvbmcgY29uY2x1c2lvbiB0aGF0IGl0J3Mg
YSBmaXgpLg0KPg0KPiBQLlMuIEFyZSB0aGUgbnVtYmVycyBmb3IgdjYuMTUtcmM0ICsgU0NIRURf
QkFUQ0ggY29tcGFyYWJsZSB0byB2Ni41DQo+IGRlZmF1bHQ/DQoNClNDSEVEX0JBVENIIGRvZXMg
aW1wcm92ZSB0aGUgcGVyZm9ybWFuY2UgYm90aCBvbiA2LjUgYW5kIG9uIDYuMTIrOyBpbiBteSAN
CnRlc3RpbmcsIDYuMTItU0NIRURfQkFUQ0ggZG9lcyBub3QgcXVpdGUgcmVhY2ggdGhlIDYuNS1k
ZWZhdWx0ICh3aXRob3V0DQpTQ0hFRF9CQVRDSCkgcGVyZm9ybWFuY2UuIEJlc3QgY2FzZSAoNi4x
NS1yYzMtU0NIRURfQkFUQ0gpIGlzIC0zLjYlLCBhbmQNCndvcnN0IGNhc2UgKDYuMTUtcmM0LVND
SEVEX0JBVENIKSBpcyAtNy4wJSB3aGVuIGNvbXBhcmVkIHRvIDYuNS4xMy1kZWZhdWx0Lg0KDQoo
UGxlYXNlIGtlZXAgaW4gbWluZCB0aGF0IHRoZSB0YXJnZXQgaXNuJ3QgdG8gZ2V0IFNDSEVEX0JB
VENIIHRvIHRoZSBzYW1lDQpsZXZlbCBhcyA2LjUtZGVmYXVsdDsgaXQncyB0byByZXNvbHZlIHRo
ZSByZWdyZXNzaW9uIGZyb20gNi41LWRlZmF1bHQgdG8NCjYuNisgZGVmYXVsdCwgYW5kIGZyb20g
Ni41LVNDSEVEX0JBVENIIHRvIDYuNisgU0NIRURfQkFUQ0gpLg0KDQo+IE9uZSBtb3JlIGN1cmlv
dXMgcXVlc3Rpb246IERvZXMgY2hhbmdpbmcgdGhlIGJhc2Ugc2xpY2UgdG8gYSBsYXJnZXINCj4g
dmFsdWUgKHNheSA2bXMpIGluIGNvbmp1bmN0aW9uIHdpdGggc2V0dGluZyBTQ0hFRF9CQVRDSCBv
biB2Ni4xNS1yYzQNCj4gYWZmZWN0IHRoZSBiZW5jaG1hcmsgcmVzdWx0IGluIGFueSB3YXk/DQoN
CkkgcmVyYW4gNi4xNS1yYzQsIHdpdGggYm90aCAzbXMgKGRlZmF1bHQpIGFuZCA2bXMuIFRoZSBs
YXJnZXIgYmFzZSBzbGljZQ0Kc2xpZ2h0bHkgaW1wcm92ZXMgcGVyZm9ybWFuY2UsIG1vcmUgZm9y
IFNDSEVEX0JBVENIIHRoYW4gZm9yIGRlZmF1bHQuDQoNCjZtcyBjb21wYXJlZCB0byAzbXMgc2Ft
ZSBrZXJuZWwgKG5vdCBjb21wYXJlZCB0byA2LjUpOg0KDQpLZXJuZWwgICAgICAgICAgICAgICB8
IFRocm91Z2hwdXQgfCBMYXRlbmN5DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLQ0KNi4xNS1yYzQgZGVmYXVsdCAgICAgfCAgKzEuMSUgICAgIHwgIC0xLjMlDQo2
LjE1LXJjNCBTQ0hFRF9CQVRDSCB8ICArMi45JSAgICAgfCAgLTIuNyUNCg0KRnVsbCBkZXRhaWxz
LCByZXBvcnRzIGFuZCBkYXRhOg0KaHR0cHM6Ly9naXRodWIuY29tL2F3cy9yZXByby1jb2xsZWN0
aW9uL2Jsb2IvbWFpbi9yZXByb3MvcmVwcm8tbXlzcWwtRUVWREYtcmVncmVzc2lvbi9yZXN1bHRz
LzIwMjUwNDMwL1JFQURNRS5tZA0KKFRoZXNlIHBlcmYgZmlsZXMgYWxsIGhhdmUgdGhlIHNhbWUg
c2NoZWRzdGF0IHZlcnNpb24sIGhvcGVmdWxseSAicGVyZg0Kc2NoZWQgc3RhdHMgZGlmZiIgd29y
a2VkIGJldHRlciB0aGlzIHRpbWUpLg0KDQotQ3Jpc3RpYW4NCg0K

