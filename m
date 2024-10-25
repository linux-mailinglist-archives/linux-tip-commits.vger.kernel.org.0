Return-Path: <linux-tip-commits+bounces-2595-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CE9B0C8B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3102850B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF69217454;
	Fri, 25 Oct 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezdmRyOr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdLqK4uQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170118CC19;
	Fri, 25 Oct 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879291; cv=none; b=gQ0HPV4gV4wnhIaZLiSIbprzkWRyCehkgf40xPfIEN08kWdup8SprAPwDHGuWnajx4fEnPiBf9ZQnrOJo/OCM8UVxi8Fk9wul1BMWm1tS8vHNulyPOYQKgZswLLjmbalguZT8CtBmfIr6B2ltDmDv1j7PeTjdUmv2376yGdkxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879291; c=relaxed/simple;
	bh=lwfUDRJ+NChzzJ2FhnDvWPsSA6tq0Kl8I8wHbW26KTg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=alxajBWVNXauJLJ+PmosCNmXZ/RT40cVELuJ0zhrauaNSbRmLGELsUGQLWKB6fXn3I7SaRaa9hT0fWVdko45N6ExLpjWVxmLlFEdx3hI556kNJu5cQTjf5bx/CmteKIZ5YmV7SIricoU8+OKynlIW3A/NBIjDmxmtnJzCKth3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezdmRyOr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdLqK4uQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jayfL55IMo3YRas60A3sDO/ul2II2GWZv55v48v4+Ow=;
	b=ezdmRyOro8tG95AWZJt6WFLz2pK68cONVu6YebYIhdgAL29Mnk8t4MejEUE77y4LdYWF/O
	rEAR7DwHvyLR4xPeBTnRW8FPxO3B1FoHoABTBIwDFkszEAJVrwieHQ5b4Dz5SqGlStkcmP
	sLAg3FtCauI34XPZ5i29yLpK8ScT2xFXU7zD9kZnLB4HvhbNIaC1lHBBN3UVIXh68rJ/pm
	TLP2E9igvGcYlhOWQKjpDYXHRLVOLGWM04dy9POdBHTm0+3ZvLLHfihj0RZvfvag9JNRya
	9VVzHK+RahA53TJ2sBJHBivs67+7QKFY+49RzcOmC18WPs51fN0IPrrlksiEjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jayfL55IMo3YRas60A3sDO/ul2II2GWZv55v48v4+Ow=;
	b=cdLqK4uQxCx12HYZSOyC4i6woKLZM0W2axCAiJ01754Mx2tFDV28cRd4LS5tP13Njlbyky
	8MILcFId8/3DIOBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Move shadow_timekeeper into tk_core
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-7-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-7-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928629.1442.8678689040140797589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     20c7b582e88b8a72832637cd1754e5622aa8a92d
Gitweb:        https://git.kernel.org/tip/20c7b582e88b8a72832637cd1754e5622aa8a92d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Move shadow_timekeeper into tk_core

tk_core requires shadow_timekeeper to allow timekeeping_advance() updating
without holding the timekeeper sequence count write locked. This allows the
readers to make progress up to the actual update where the shadow
timekeeper is copied over to the real timekeeper.

As long as there is only a single timekeeper, having them separate is
fine. But when the timekeeper infrastructure will be reused for per ptp
clock timekeepers, shadow_timekeeper needs to be part of tk_core.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cfb718d..848d2b1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,11 +50,11 @@ DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
+	struct timekeeper	shadow_timekeeper;
 } tk_core ____cacheline_aligned = {
 	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static struct timekeeper shadow_timekeeper;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -795,8 +795,7 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
-		       sizeof(tk_core.timekeeper));
+		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
 }
 
 /**
@@ -2305,8 +2304,8 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  */
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
-	struct timekeeper *tk = &shadow_timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
 	u64 offset;

