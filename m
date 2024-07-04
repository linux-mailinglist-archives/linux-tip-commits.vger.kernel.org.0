Return-Path: <linux-tip-commits+bounces-1595-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77627927D14
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F01F21FE5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D9131736;
	Thu,  4 Jul 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2QbzUE1x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WjiQjLEr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DA4964A;
	Thu,  4 Jul 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117977; cv=none; b=M/EDmq72LCGfBnsAoxAL+SIn+v6YQVqheGMnn5L6baDVucDnBXe67vBUdWGX1IsnRigK8BILyc9+3+iV0PU2yJsJQpfANbPvRtwamCXDwuQUlgXC59wwZRbQ18NCDRlqOuqScv9TumI25piN8kWUJxYnAknyRTwz4vbNI1nMbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117977; c=relaxed/simple;
	bh=1+X1oCcDvCWATdr7qSa1yTuIOhQgeE5s9z49A16omkI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DJjcQrRaJzWxu5y7mtdYzPzI9S1oAtW+8h4wYBrBs4CuKGAxz95BMRz6Cvbcn5JnhOIZ25GuoWcT9U914zwzqK/vtnh0Fpq/48DZFJzlbG1+LnzYpkvjYiHFA3tARrVmeBVkt4YYPvKniAeVTFFzuN6c2pJ3o+liKu/Wlyu3rE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2QbzUE1x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WjiQjLEr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jul 2024 18:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720117973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7ilNo4XAnyWs+5oKulgVr0bEO0PJ45PnWrV8YRHpIQ=;
	b=2QbzUE1xdJN4HbhZnI+rRiE9YRgNWlfAucBgmebqwYIxWkpSPto7dx6SRbrWYlf9ptN94i
	mmZnqpLhH0t3gUN/GhEZ+q0++aumbm6eRsASuingo6x6eudSo5NqwPRMhgnog2QTiwO++5
	GwR01QcyDAcV/747crobwMtATS809ifoYh8sR1qM4OmpOFqm05EGHV7SSQf3t+g5byQNpt
	zldEq6OqNIVTdHDn/5wYt2P57nhin/Yw7ERMLvQDbHoU0K303ijg9NOUIu5W9v9+3II3o8
	jAdbVabaE7UVkIXqHvLSGaMdP0WeURAshS21djQVxUEmVmeR/piplcwIoIUOsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720117973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7ilNo4XAnyWs+5oKulgVr0bEO0PJ45PnWrV8YRHpIQ=;
	b=WjiQjLEr+O5Oqu5Z0LxL90r0GdIw8+WpP+adD89qittKYQ5+Ov/wLhhPeedZXAUgqFI2x1
	D/ejZAOa4iFYjkBg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Spare write when nothing changed
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-tmigr-fixes-v3-7-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-7-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172011797324.2215.7387357188188957218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2e0bd37f7b395173f879225b9d8b1811af4a8a35
Gitweb:        https://git.kernel.org/tip/2e0bd37f7b395173f879225b9d8b1811af4a8a35
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 12:18:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Jul 2024 20:24:57 +02:00

timers/migration: Spare write when nothing changed

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move write to the place where wakeup value could have changed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240701-tmigr-fixes-v3-7-25cd5de318fb@linutronix.de

---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9ff61f9..a2d156b 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1215,14 +1215,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		if (nextexp != tmc->cpuevt.nextevt.expires ||
 		    tmc->cpuevt.ignore) {
 			ret = tmigr_new_timer(tmc, nextexp);
+			/*
+			 * Make sure the reevaluation of timers in idle path
+			 * will not miss an event.
+			 */
+			WRITE_ONCE(tmc->wakeup, ret);
 		}
 	}
-	/*
-	 * Make sure the reevaluation of timers in idle path will not miss an
-	 * event.
-	 */
-	WRITE_ONCE(tmc->wakeup, ret);
-
 	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;

