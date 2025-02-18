Return-Path: <linux-tip-commits+bounces-3436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40288A3982C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95AF188BBD2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48696232395;
	Tue, 18 Feb 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zv40QsrL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZ7EO/nA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE922FAE1;
	Tue, 18 Feb 2025 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873203; cv=none; b=UrrytHyYRtJsGmPHwU2RyU5bLHDxRQ3KIP6o681GGIBoyjCIJTL2UmsZhqDs/CZl84J2HdE5EIQ/EjVBX7V2u7dz/HgKDwo3KcghjHiOxRX3NOb1PVZ9oqT/iWo9eJMV7ckIWKRpSVhmgsdw4M1n6ge4hXcmgjIF0LOKYHj9zKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873203; c=relaxed/simple;
	bh=Hq6ZY5xmRWFjosBm8mkAd/kjuDQ3NGycYD8Wiy2IT6c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KaRPWQOVtMvdRNfOgBySM4uyAJnTY6VxArD0I7tfl3S+53EFC5qGrzDWAFrFNFbgdUTde6EsJzCQDXiPjb/AJdMCpQS4kVQe1jPPzBHYrKFy2yM+qaslLNMX0aYyuhPbzjC6UPMmk7Ht9wjfpTSA356ZVRpjE2/i7jyAhsNvhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zv40QsrL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZ7EO/nA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cN3a4pDQ2B+o9buo3DOTycAcGW0vZvYxkfuzJ08j7U8=;
	b=Zv40QsrLpJl1h5UyNojgVRF901IDZ39tiJctm+mnWlpoZ3yoU2u7ssKXfrASutW1O81J2c
	nObxMdFQxqQURga0yCBkhF6DZ13Jmpg++O2tU8hd35zf1aPUI5LhYL7wIcIihud07cd3vB
	VZmxr1hXlKgnka/HwIOI51Ts7GxNMuIEqhdz7FRvXTFhgz+xQMOFCC7QSYHcOLIcyzg4tL
	cQxeCMTuNoCybRHB4qYSsl+pX+HlqffSrVJk8fbVP8qUDZL20Q5TW+Fce9TJNS1zIPH6t0
	CispAgb1r8IvoSY4hjchKAT8ngoGaPSV36BaHCsFIGmLraHLw2cFLAUE5N9FEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cN3a4pDQ2B+o9buo3DOTycAcGW0vZvYxkfuzJ08j7U8=;
	b=aZ7EO/nAGfALyVVYNuze0PVzihdnWVtQiXmPFOXzpUmLO6bIVGwNoWu4RcJrquxAO33v7h
	329FP1cZftppFqDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] xfrm: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd338b246f087ee2b2a305348c896449e107a7ff4=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd338b246f087ee2b2a305348c896449e107a7ff4=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987319854.10177.2315963857927707295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     1417c85d16257f4cc581acca218f4f9fb17ef952
Gitweb:        https://git.kernel.org/tip/1417c85d16257f4cc581acca218f4f9fb17ef952
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:47 +01:00

xfrm: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d338b246f087ee2b2a305348c896449e107a7ff4.1738746872.git.namcao@linutronix.de

---
 net/xfrm/xfrm_iptfs.c | 6 ++----
 net/xfrm/xfrm_state.c | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 755f1ee..3b6d728 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2625,12 +2625,10 @@ static void __iptfs_init_state(struct xfrm_state *x,
 			       struct xfrm_iptfs_data *xtfs)
 {
 	__skb_queue_head_init(&xtfs->queue);
-	hrtimer_init(&xtfs->iptfs_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
-	xtfs->iptfs_timer.function = iptfs_delay_timer;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
 
 	spin_lock_init(&xtfs->drop_lock);
-	hrtimer_init(&xtfs->drop_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
-	xtfs->drop_timer.function = iptfs_drop_timer;
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
 
 	/* Modify type (esp) adjustment values */
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202f..9bd14fd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -746,8 +746,8 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
 		INIT_HLIST_NODE(&x->byseq);
-		hrtimer_init(&x->mtimer, CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
-		x->mtimer.function = xfrm_timer_handler;
+		hrtimer_setup(&x->mtimer, xfrm_timer_handler, CLOCK_BOOTTIME,
+			      HRTIMER_MODE_ABS_SOFT);
 		timer_setup(&x->rtimer, xfrm_replay_timer_handler, 0);
 		x->curlft.add_time = ktime_get_real_seconds();
 		x->lft.soft_byte_limit = XFRM_INF;

