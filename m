Return-Path: <linux-tip-commits+bounces-3458-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B431DA3987B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68883BA70F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59F245030;
	Tue, 18 Feb 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAhKx9s/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDv3kGP8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85CC243384;
	Tue, 18 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873218; cv=none; b=HmWSCPEHjKIU75gPkhu5E+eV3Q5K+OOj3lNml/KlaMFuSTgV5Q1TwjNX1K3A4mN9hu2tK3+9ro/OtNgQd3ZIKy8CMo/NHEAtEYUtbYvQc4RT1DRRVer4BiMCnNiuO3Y8FfyJkQ7t0DqNh5c8HJvAlXEReUT+uVvKT7BINQYSwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873218; c=relaxed/simple;
	bh=NPESV6Hps7ZUw8Q8EtCHFlJKYmMVk6wQxgz4qVMjHVA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bpvRlmgMNR2jgPHoGytwaGu4b157fWnsFwU1XzlrELfIGvMOjOzKQJ9acLEdLQIXOFxN+MySawpcrniWdLusFllz6vakQxPAX34AmSdXe4mB8qYXHQelxwKeVALwhmffenOBxjmN9qaXJdwkn3YVqQmDErNBMZz4nXezPEUsxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAhKx9s/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDv3kGP8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7bVIQUKMRXuM1QDgCbOXkaXnRQrh0s+zpyQWWMnAtk=;
	b=YAhKx9s/P+GcvSEAND5nkg6aim25WZBL0HkExUhzB8cC3jH5oior4uaYAdNgVS8yiXD7F+
	iB1msM5eniado87ZpVFd7FHm1wPFG5JsmcXQPxnG6VlC80Mpt4Ds0KcWv4/LgNFfXj2DE5
	oIv9+x/9M/NDyQ8C2foBPSezb8kfBgquDZqHsrBxuPSDUJTjOApV7hv68/7SpBm8B2sWFZ
	B13m2zTPuVJcS6LAuWU2N5teUqtJtA347tb7gRTvF2mM+iJukzpiTa5vM0pXrI060IgSUG
	/JWZR+2pAwKYRSkSGo5VDS/17oZZYZC2EMylvyi10AkDHIfKIk+GbcIbYRbIDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7bVIQUKMRXuM1QDgCbOXkaXnRQrh0s+zpyQWWMnAtk=;
	b=aDv3kGP8A5KrklREaWmjwHWx2UDaWuEvlfO9PNUe4sP9IBi4YE6VpnQWM5W6Jf8aHYRlTz
	qmo0eSFYmCBhj9Ag==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] netdev: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C861d9b287f2b5206b853dbcc0f302127f2a7f8ac=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C861d9b287f2b5206b853dbcc0f302127f2a7f8ac=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321507.10177.14552014682427922141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     fe0b776543e986249f48611387c847e5564a3647
Gitweb:        https://git.kernel.org/tip/fe0b776543e986249f48611387c847e5564a3647
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:44 +01:00

netdev: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/861d9b287f2b5206b853dbcc0f302127f2a7f8ac.1738746872.git.namcao@linutronix.de

---
 net/core/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b91658e..1ad2ca4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6931,8 +6931,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 
 	INIT_LIST_HEAD(&napi->poll_list);
 	INIT_HLIST_NODE(&napi->napi_hash_node);
-	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	napi->timer.function = napi_watchdog;
+	hrtimer_setup(&napi->timer, napi_watchdog, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);

