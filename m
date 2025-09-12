Return-Path: <linux-tip-commits+bounces-6571-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346AB549A7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Sep 2025 12:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3502B626C9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Sep 2025 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C82E9EB1;
	Fri, 12 Sep 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="q988zjXQ"
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8702DFA21
	for <linux-tip-commits@vger.kernel.org>; Fri, 12 Sep 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672513; cv=none; b=IS2z2cwmLo3Dx9t1tWhLHIIDbQjWAitb0Z8imxb0Ax2yV6mlE74ruaBxj6fIHdq3VmiCEw5P8dq93hohMPBaoSWsQ8Wz3awiZ+NtUyb4Cn0fLV3fn/ZxCdk2tMyNOdoFJlCfsuxj7aLdmoOL9CmuLO5v3D2iJXu+ffeNZPMXzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672513; c=relaxed/simple;
	bh=BeneFGIGFLDf8N6hnBvoQCYDT8JAXCjMJ5AonYV5nLo=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=r4AKBNCUQ2hvzdkwP+XOJMh0xZFOyPWoSbiW9laezV9RZIa18gb56R2Kc7GjxCE9YyvZwQwAM4neArVkTjtFDmTCc2wByi8nPz7kjlmi02ydnKKknFNNwL0r1ZMVR6S4IcPkpc/0dUFc2guMrg9b4D376JwjFRsB+kC266Ym2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=q988zjXQ; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58CALkW4161050
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-tip-commits@vger.kernel.org>; Fri, 12 Sep 2025 18:21:49 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757672509; bh=6twFzTKAfUkrHodgDr4LVZSazIU=;
	h=From:To:Subject:Date;
	b=q988zjXQ3JiqBJgYjglVg+SWcMru5fwCeeRXYuwKoBCheHjY6pTwQoz2fadKizkBR
	 bacue7ugCMv2BN8Lc1QrgtRnToS29sVLAd9LWJM9vKX/wO5Llts9pu0LWLBPcVtqIi
	 6y+hbOOw6/2kyg8XHeRiCmYLoLY0uEkl4C1HTz9Y=
Received: from [127.0.0.1] (61-228-55-181.dynamic-ip.hinet.net [61.228.55.181])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 58CAF6Le511552
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-tip-commits@vger.kernel.org>; Fri, 12 Sep 2025 18:15:57 +0800
From: "Info - Albinayah 497" <Linux-tip-commits@ms29.hinet.net>
To: linux-tip-commits@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNTY5ODQgRnJpZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjUgYXQgMTI6MTU6NTYgUE0=?=
Message-ID: <0524c9cd-ad28-f16a-5ee5-8613b2289c2f@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Sep 2025 10:15:57 +0000
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=Au5N3/9P c=0 sm=1 tr=0 ts=68c3f2de
	p=OrFXhexWvejrBOeqCD4A:9 a=yt2vnJcufJgYEsdr2blA5A==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-tip-commits,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

