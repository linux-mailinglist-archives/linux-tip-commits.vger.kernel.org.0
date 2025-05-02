Return-Path: <linux-tip-commits+bounces-5199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F1AA791C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681D67B31FA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085942A87;
	Fri,  2 May 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eZoJnBhc"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D63D6F;
	Fri,  2 May 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746209168; cv=none; b=TGtjeTEfHJJzZlxYEdexQXt3rwuKys1Dr1ONKETj/hnALfOYals5oOLK3l4XBuC9+LoeS/UNtfsujK20AKZFsDGE1tjw+NuUW+ZkNKn384+/kL+mSczPs+s8bJD7SfE/5B24VITiKqrt/CIBmNmhjAKsZo7bfhVYjSI7X5RTV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746209168; c=relaxed/simple;
	bh=x/dFk48f7VSDO8MaFHLbXTmrEKYB/ZJL5VKCMV+8zzo=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyg3JOMjUTwOaKK8VB46JMSS7Ov/ikyjP6b4VLPD8DwKB0LkPiKCiQuLOSBDj1vtC2sDctM54EzIF0/FCwuksH37PlBRK7mqyscvPRSEuxcxYQjUl2FYjbL2VH8+7CNXAfb7LZtDP2ewUTeN0cMEtU2nKGPsZaTvEkKns2ktyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eZoJnBhc; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746209167; x=1777745167;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=x/dFk48f7VSDO8MaFHLbXTmrEKYB/ZJL5VKCMV+8zzo=;
  b=eZoJnBhc21LCfGxiN44vMqCe5K6yH3dtlp1bUgSK2Bx26Rckyo9ihKUT
   Vfwjo1jby55LC8xfsTbjI+QTXlGn/zJxI4jWibMXhandj88pVw+WDh46c
   RfPsG5jRkeyBAc/msPkgZ9E2uBl8ZGBMhkOJui6cz/U2NenrSkAdC4CQ6
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,257,1739836800"; 
   d="scan'208";a="821188942"
Subject: Re: EEVDF regression still exists
Thread-Topic: EEVDF regression still exists
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 18:06:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:55999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id eac2cf77-2b8f-461f-9975-96b0cd0fa940; Fri, 2 May 2025 18:06:05 +0000 (UTC)
X-Farcaster-Flow-ID: eac2cf77-2b8f-461f-9975-96b0cd0fa940
Received: from EX19D002UWA001.ant.amazon.com (10.13.138.247) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 18:06:05 +0000
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19D002UWA001.ant.amazon.com (10.13.138.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 18:06:05 +0000
Received: from EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0]) by
 EX19D016UWA004.ant.amazon.com ([fe80::92ec:e30c:889c:c2c0%5]) with mapi id
 15.02.1544.014; Fri, 2 May 2025 18:06:05 +0000
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
Thread-Index: AQHbuU8Zth8BPweWAUWz5H5EpP8DD7O7MGMA//+vIgCAAK8gAIACE5kAgAE45gCAAAphgIAAbcaA
Date: Fri, 2 May 2025 18:06:05 +0000
Message-ID: <E120CFCF-8BFF-44BB-96B7-C70E020E2A31@amazon.com>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
 <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
 <d875adc0-744e-4b1f-a1bf-7e051298a0ae@amd.com>
 <7d3bd258-fa45-4e85-8700-90203bacdeea@amd.com>
In-Reply-To: <7d3bd258-fa45-4e85-8700-90203bacdeea@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8682AA6145737418B1459D6E080A3BD@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUHJhdGVlaywNCg0K77u/T24gMjAyNS0wNS0wMiwgMDE6MzMsICJLIFByYXRlZWsgTmF5YWsi
IDxrcHJhdGVlay5uYXlha0BhbWQuY29tIDxtYWlsdG86a3ByYXRlZWsubmF5YWtAYW1kLmNvbT4+
IHdyb3RlOg0KDQo+PiBDb3VsZCB5b3UgYWxzbyBwcm92aWRlIHNvbWUgaW5mb3JtYXRpb24gb24g
eW91ciBMREcgbWFjaGluZSAtIGl0cw0KPj4gY29uZmlndXJhdGlvbiBhbmQgaGUga2VybmVsIGl0
IGlzIHJ1bm5pbmcgKGFsdGhvdWdoIHRoaXMgc2hvdWxkbid0DQo+PiByZWFsbHkgbWF0dGVyIGFz
IGxvbmcgYXMgaXQgaXMgc2FtZSBhY3Jvc3MgcnVucykNCj4NCj4gU28gSSdtIGxvb2tpbmcgYXQg
bG9ncyBhdCBMREcgc2lkZSB3aGljaCBpcyBhIDR0aCBHZW5lcmF0aW9uIEVQWUMgc3lzdGVtDQo+
IHdpdGggMTkyQ1BVcyBydW5uaW5nIHRoZSByZXBybyBvbiBiYXJlbWV0YWwgYW5kIEkgc2VlOg0K
Pg0KPiBbMjAyNTA1MDIuMDYxNjI3XSBbSU5GT10gU1RBUlRJTkcgVEVTVA0KPiBbMjAyNTA1MDIu
MDYxNjI3XSBbSU5GT10gNzY4IFZVDQo+DQo+IDc2OFZVIGVhY2ggcHJvY2Vzc2luZyAxMDAwMDAw
MDAwMDAwIHRyYW5zYWN0aW9ucyBzZW50IHRvIGEgMTZ2Q1BVDQo+IFNVVCBpbnN0YW5jZSBzZWVt
cyBsaWtlIGEgaGlnaGx5IG92ZXJsb2FkZWQgKGFuZCB1bnJlYWxpc3RpYykgc2NlbmFyaW8NCj4g
YnV0IHBlcmhhcHMgeW91ciBMREcgaXMgYWxzbyBhIHNpbWlsYXIgMTZ2Q1BVIGluc3RhbmNlIHdo
aWNoIGNhcHMgdGhlDQo+IFZVIGF0IDY0Pw0KDQpZb3UncmUgcmlnaHQsIG15IExERyBpcyBzbWFs
bGVyLiBJJ20gdXNpbmcgYSA2NCB2Q1BVIDEyOEdCIFJBTSBHcmF2aXRvbjMNCmluc3RhbmNlICh0
aGlzIGlzIG1lbnRpb25lZCBpbiB0aGUgdGVzdCByZXN1bHRzIFJFQURNRSBbMV0pLCByZXN1bHRp
bmcNCmluIDI1NiBWVXMuDQoNClRoZSBWVSBjb3VudCBzaG91bGQgcmVhbGx5IGJlIGJhc2VkIG9u
IHRoZSBTVVQgY29yZSBjb3VudCwgYW5kIGJlIGF0IGxlYXN0DQo4ICogU1VUIHZDUFVzIHRvIGVu
c3VyZSBhIGZ1bGwgbG9hZC4gQ3VycmVudGx5IHRoZSByZXByb2R1Y2VyIGRvZXMgbm90DQpzdXBw
b3J0IHF1ZXJ5aW5nIHRoZSBTVVQgdkNQVXMgZnJvbSB0aGUgTERHIHNpZGUsIHdoaWNoIGlzIHdo
eSBpdCBkZWZhdWx0cw0KdG8gdXNpbmcgdGhlIExERyBjb3JlIGNvdW50IGluc3RlYWQgLSBidXQg
dGhlIGFzc3VtcHRpb24gb2YgdGhvc2UgY291bnRzDQpiZWluZyBjb3JyZWxhdGVkIG5lZWRzIHJl
dmlzaXRpbmcuDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vYXdzL3JlcHJvLWNvbGxlY3Rpb24v
YmxvYi9tYWluL3JlcHJvcy9yZXByby1teXNxbC1FRVZERi1yZWdyZXNzaW9uL3Jlc3VsdHMvMjAy
NTA0MjgvUkVBRE1FLm1kDQoNCj4gQ3VycmVudGx5IGRvaW5nIGEgdHJpYWwgcnVuLCBzdGFyaW5n
IGF0IGxvZ3MgdG8gc2VlIHdoYXQgSSBuZWVkIHRvDQo+IGFkanVzdCBiYXNlZCBvbiB0aGUgZXJy
b3JzLiBJJ2xsIGFkanVzdCB0aGUgTERHIGJhc2VkIG9uIHlvdXIgY29tbWVudHMNCj4gYW5kIHRy
eSB0byByZXByb2R1Y2UgdGhlIHNjZW5hcmlvIG92ZXIgdGhlIHdlZWtlbmQuDQoNCllvdXIgaGVs
cCBpcyBtdWNoIGFwcHJlY2lhdGVkIQ0KDQpBIGNvdXBsZSBtb3JlIHRob3VnaHRzIG9uIHRoZSBz
ZXR1cDoNClRoZSBMREcgc2hvdWxkIG1haW5seSBiZSBhYmxlIHRvIGNvdmVyIGVub3VnaCBsb2Fk
IHRvIG5vdCBiZSBhIGJvdHRsZW5lY2suDQpTYW1lIGdvZXMgZm9yIHRoZSBuZXR3b3JrIGNvbm5l
Y3Rpb24uIEF0IHRoZSBzYW1lIHRpbWUsIHRoZSBTVVQgbmVlZHMgdG8NCmhhdmUgYSBmYXN0IGVu
b3VnaCBkaXNrIHNvIGl0IGRvZXNuJ3QgYmVjb21lIHRoZSBsaW1pdGluZyBmYWN0b3IgKEkndmUg
c2Vlbg0KdGhpcyBpc3N1ZSBpbiB0aGUgcGFzdDsgdGhlIHJlc3VsdHMgd2lsbCBzaG93IGEgbWlu
aW1hbCBkaWZmZXJlbmNlIG9ubHkpLg0KDQoNCg==

