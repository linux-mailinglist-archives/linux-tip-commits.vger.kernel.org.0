Return-Path: <linux-tip-commits+bounces-3411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D681A39766
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BDF18922B8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25E235BF4;
	Tue, 18 Feb 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRW1knA9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3sABTTNQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCF2343AB;
	Tue, 18 Feb 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871994; cv=none; b=tpUEAV0hNltVL77TQfv4uyLRJZPYV/d+jh9EAAeEszZd4MLTh/6I6NlDUCywO3phH4yB3uEBxbqMA9F2Sa1E9KYeKNAfvzCK3ITrmu04EOZEl2vehAJmID1SAhoALZh0NA+6xlii/nbDd5bdbw2mo+SLGLjNHcZxl3Pnn8dG/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871994; c=relaxed/simple;
	bh=NJtKOnxIP1IfIvMiE979mSAZScwzlvnCnioNXbYN3qs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bBVC8H+X/HU6es2Kex+cJIbSmtGK3kw/NxTE3/G6dtfNQ9D+wcde5LnwE/Ee6H/ZaIrjLIY5NjC754LWPO18MM5znAhfUm36eKIvZRbgT5oFo+/x9/UqWITZW7anDhS7M5s561Nn/h9KvgE+xeR969OkKY4TVj/hmxAy7YuMeg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRW1knA9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3sABTTNQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Imp0JsdA7qpFLs6ztWT5MyvxkzqBdNfiS5KxScyVkjg=;
	b=NRW1knA9Z6j6Nc0jRC0k6QVBENNLqcTKxWBaVYwexmCqgq9qNfbxNaP9FtHNRBsatqQdQQ
	oy4rSjEXH0CpbKWlu3FgXfPHqdE2wTHEa2B8dinmha6+6wCEc1wW/MaxqOin0E0Q/+Ok1r
	+QTFSTEyVCe2NfNnyMeA3Lfj2n/ol88FPsmI8OSNldMm1m7opS70G9dkP+Dcibui54Mgvx
	vmAKRD49ZFbY4rMOoeoUg4nIEQdOTPJ3USIwCruQRMuXw1BaKW/MRxH6nuzWOJU6U8+/Sz
	Z7Iy4FsMb7Bt2u9bW9vFxWWSS9B1lT1UGKl0TRVDq6S+cpN9dh2wdXEGg6qToA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Imp0JsdA7qpFLs6ztWT5MyvxkzqBdNfiS5KxScyVkjg=;
	b=3sABTTNQurbE011PCAEB9QQt+JI3upgxRyKMxSbT2WMOf6NedBlOASHcR9foGZk6pO5Hb+
	qM5g5GeaVUgIUeBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] block, bfq: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd0d57e1dab46b617856dfb93c721d221cc31ab0b=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd0d57e1dab46b617856dfb93c721d221cc31ab0b=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199009.10177.1611648539497449194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     2414f15910c50a714a4f9aa5aa874f0682648536
Gitweb:        https://git.kernel.org/tip/2414f15910c50a714a4f9aa5aa874f0682648536
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

block, bfq: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d0d57e1dab46b617856dfb93c721d221cc31ab0b.1738746821.git.namcao@linutronix.de

---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1675422..abd80dc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7315,9 +7315,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
-	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
+	hrtimer_setup(&bfqd->idle_slice_timer, bfq_idle_slice_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED

