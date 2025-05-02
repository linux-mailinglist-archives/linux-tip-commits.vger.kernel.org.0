Return-Path: <linux-tip-commits+bounces-5196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA82AA77C8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECFF1C20595
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFABB265608;
	Fri,  2 May 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fgWeneZJ"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF702571D5;
	Fri,  2 May 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204766; cv=none; b=cRn2U1ZHZz/BGLpNNEi7qmQpMfu+mJezjKg/fllzM1Wp77zDosFUYiWTonLJUp8wfljDyA3JzCzcZVFCLWjifnT/4fK2ig7dXKUC0UNSnRPVBKK+w9PwzyFPQDl3V0sFNRg87pwassyKpvgn88OZVuFVScP8N6VGU41XiKn5f8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204766; c=relaxed/simple;
	bh=26hkBOX6SosTAb5YFKXego/kgdS2SaV+sWyHWN5vTkY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ze/f0j/iB6LDoTRdwJDriVnl9xMTSLRLUrIDJzNWe+6zc90qeF4u9sccr7QVLr7H1y3s2+/p8miXZ37Bzg0cSHTMyJDho93q3i2Bi6v9d+vyHoG6GRZYj+xlR6IF8zAlkMf7BdPIn84HvcvzvCibVuVrsejakt9qRCnc6HmUTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fgWeneZJ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746204760; x=1777740760;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=26hkBOX6SosTAb5YFKXego/kgdS2SaV+sWyHWN5vTkY=;
  b=fgWeneZJAXMliQNyFxJ84x9mlpcYk0+nn3I95SzaEDUYKxStFyynarXC
   I9+kVINIaEqGzZIkRRu8Yan0x73YXVp3PwYdg2eR8ixQk5Q86kcuLadCY
   +LUoZPZGkLINkF0YS+K7XNGorzrUS7aObiYzGJ44aB1MiymoCImt/YO7F
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,257,1739836800"; 
   d="scan'208";a="401365857"
Subject: Re: EEVDF regression still exists
Thread-Topic: EEVDF regression still exists
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 16:52:40 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:54137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.224:2525] with esmtp (Farcaster)
 id 9bdfdfaf-bb97-4a6a-9618-f4a74663dc15; Fri, 2 May 2025 16:52:39 +0000 (UTC)
X-Farcaster-Flow-ID: 9bdfdfaf-bb97-4a6a-9618-f4a74663dc15
Received: from EX19D002UWA003.ant.amazon.com (10.13.138.235) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 16:52:39 +0000
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19D002UWA003.ant.amazon.com (10.13.138.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 16:52:38 +0000
Received: from EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0]) by
 EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0%5]) with mapi id
 15.02.1544.014; Fri, 2 May 2025 16:52:38 +0000
From: "Prundeanu, Cristian" <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, "Mohamed Abuelfotoh, Hazem"
	<abuehaze@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, "Blake, Geoff"
	<blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>, "Doebel, Bjoern"
	<doebel@amazon.de>, Gautham Shenoy <gautham.shenoy@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>, Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHbuU8Zth8BPweWAUWz5H5EpP8DD7O7MGMA//+vIgCAAK8gAIACE5kAgAFpKQCAADNhAA==
Date: Fri, 2 May 2025 16:52:38 +0000
Message-ID: <935376C2-71B9-4E41-9738-99A4BCC55B48@amazon.com>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
 <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
 <20250502084844.GT4198@noisy.programming.kicks-ass.net>
In-Reply-To: <20250502084844.GT4198@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D14B31FC3DA854E8AD8251CD7584CBE@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS0wNS0wMiwgMDM6NTAsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZyYWRlYWQu
b3JnIDxtYWlsdG86cGV0ZXJ6QGluZnJhZGVhZC5vcmc+PiB3cm90ZToNCg0KPiBPbiBUaHUsIE1h
eSAwMSwgMjAyNSBhdCAwNDoxNjowN1BNICswMDAwLCBQcnVuZGVhbnUsIENyaXN0aWFuIHdyb3Rl
Og0KPiANCj4+IChQbGVhc2Uga2VlcCBpbiBtaW5kIHRoYXQgdGhlIHRhcmdldCBpc24ndCB0byBn
ZXQgU0NIRURfQkFUQ0ggdG8gdGhlIHNhbWUNCj4+IGxldmVsIGFzIDYuNS1kZWZhdWx0OyBpdCdz
IHRvIHJlc29sdmUgdGhlIHJlZ3Jlc3Npb24gZnJvbSA2LjUtZGVmYXVsdCB0bw0KPj4gNi42KyBk
ZWZhdWx0LCBhbmQgZnJvbSA2LjUtU0NIRURfQkFUQ0ggdG8gNi42KyBTQ0hFRF9CQVRDSCkuDQo+
DQo+IE5vLCB0aGUgdGFyZ2V0IGRlZmluaXRlbHkgaXMgbm90IHRvIG1ha2UgNi42KyBkZWZhdWx0
IG1hdGNoIDYuNSBkZWZhdWx0Lg0KPg0KPiBUaGUgdGFyZ2V0IHZlcnkgbXVjaCBpcyBnZXR0aW5n
IHlvdSBwZXJmb3JtYW5jZSBzaW1pbGFyIHRvIHRoZSA2LjUNCj4gZGVmYXVsdCB0aGF0IHlvdSB3
ZXJlIGhhcHB5IHdpdGggd2l0aCBrbm9icyB3ZSBjYW4gbGl2ZSB3aXRoLg0KDQpJZiB3ZSdyZSB0
YWxraW5nIGFib3V0IG5ldyBrbm9icyBpbiA2LjYrLCBhYnNvbHV0ZWx5Lg0KDQpGb3IgdGhpcyBw
YXJ0aWN1bGFyIGNhc2UsIFNDSEVEX0JBVENIIGV4aXN0ZWQgYmVmb3JlIDYuNi4gVXNlcnMgd2hv
IGFscmVhZHkNCmVuYWJsZSBTQ0hFRF9CQVRDSCBub3cgaGF2ZSBubyByZWNvdXJzZS4gV2UgY2Fu
J3QsIHdpdGggYSBzdHJhaWdodCBmYWNlLA0KY2xhaW0gdGhhdCB0aGlzIGlzIGEgc3VmZmljaWVu
dCBmaXgsIG9yIHRoYXQgdGhlcmUgaXMgbm8gcmVncmVzc2lvbi4NCg0KSSBhbSwgb2YgY291cnNl
LCBpbnRlcmVzdGVkIHRvIGRpc2N1c3MgYW55IGtub2IgdHdlYWtzIGFzIGEgc3RvcC1nYXAgbWVh
c3VyZS4NCihUaGF0IGlzIGFsc28gd2h5IEkgcHJvcG9zZWQgbW92aW5nIE5PX1BMQUNFX0xBRyBh
bmQgTk9fUlVOX1RPX1BBUklUWSB0byBzeXNjdGwNCmEgZmV3IG1vbnRocyBiYWNrOiB0byBnaXZl
IHVzZXJzLCBpbmNsdWRpbmcgZGlzdHJvIG1haW50YWluZXJzLCBhIHJlYXNvbmFibGUNCndheSB0
byBwcmVjb25maWd1cmUgdGhlaXIgc3lzdGVtcyBpbiBhIHN0YW5kYXJkLCBwZXJzaXN0ZW50IHdh
eSwgd2hpbGUgdGhpcyBpcw0KYmVpbmcgd29ya2VkIG9uKS4NCk5vbmUgb2YgdGhpcyBzaG91bGQg
YmUgY29uc2lkZXJlZCBhIHBlcm1hbmVudCBzb2x1dGlvbiB0aG91Z2guIEl0J3Mgbm90IGEgZml4
LA0KYW5kIHdhcyBuZXZlciBtZWFudCB0byBiZSBhbnl0aGluZyBidXQgYSBzaG9ydC10ZXJtIHJl
bGllZiB3aGlsZSBkZWJ1Z2dpbmcgdGhlDQpyZWdyZXNzaW9uIGlzIG9uZ29pbmcuDQoNCg0K

