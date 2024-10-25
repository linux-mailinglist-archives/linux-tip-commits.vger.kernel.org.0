Return-Path: <linux-tip-commits+bounces-2589-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC09B0C81
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB2281D2A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC30215C61;
	Fri, 25 Oct 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTHoayNi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EaNvMjQT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F921218A;
	Fri, 25 Oct 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879286; cv=none; b=DnIMtnDZQSfxzaeNCt6GksFwm8aA0SXzmapZ0FQdRMn6JuSGS3sDyuSW/mV8JleZizPz7CiE5dKfUOreNE8sjazF6sLbGFYaRaHw10m35atJ5A1mzLevWh6ix83O3vO9f0VP5NvseEB8wwKZyF8uRCaepUYhNTuZ4Z3iu+aDALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879286; c=relaxed/simple;
	bh=RZKEb4v9OlAM/5uNiCPCywoe0KnC9EunnJSor+SXZ4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJ9YpS9PH5rtgk00GuFoTBog6Js/lIZbugNCI8fPzw3I+NOK7yu2bArcxFLv5EXT5NlGhERbNu3PZZqF+gSbCurcd1OhSQygKUsXSnxFd05/ConUUUOL8NccZ4yFKoDBh4yVqnzHGgIRv5Uw9Wb4tEBDPifND3bWAmTDLEaxJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTHoayNi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EaNvMjQT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879282;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEp0dozbPTDsCWfDqPPJoBMj/nb3ZnvAZPvhps9h63I=;
	b=VTHoayNiX0DrlnWrOAqS6TFkL1v/2f08bQd4gVmOkjMlLikpaHtx21PtViS6hgQgrtWru1
	rHEBbOvP2FqxNncUdrkQrIqrG2ofXANQ8dbVyXfGJEPP1wmyTT8W1nLkBwWOaMgwTMeqjA
	XUUf9D+IDIj64xa6suAEsuwSR89/PYAe+tTa4OZGKwQJu/0GXktjRqxUGR3DZ61wDn0Fz0
	zsJTY0WVRiM1rQyoQupTbhKpCe1GMKip/8bW9oc4v9fxPp06UOt6gdgSQveTZrVirsKs20
	2+ZWjZgQL++7379EAeHjRP9mD9yFvM0ZLEYrESoDrkp72h7W4IwrDuFtu0MTZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879282;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEp0dozbPTDsCWfDqPPJoBMj/nb3ZnvAZPvhps9h63I=;
	b=EaNvMjQTzcgUIm1NDDvbHTvR90YJbd6xIrQpeP6JSiG3sQu6hkex0IDEcp/cGHRWewBjZ7
	1y1IO8VHuYLK8/Dw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Split out timekeeper update of
 timekeeping_advanced()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-13-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-13-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928188.1442.14692316904096217752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5aa6c43eca21a929ace6a8e31ab3520ddc50dfa9
Gitweb:        https://git.kernel.org/tip/5aa6c43eca21a929ace6a8e31ab3520ddc50dfa9
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Split out timekeeper update of timekeeping_advanced()

timekeeping_advance() is the only optimized function which uses
shadow_timekeeper for updating the real timekeeper to keep the sequence
counter protected region as small as possible.

To be able to transform timekeeper updates in other functions to use the
same logic, split out functionality into a separate function
timekeeper_update_staged().

While at it, document the reason why the sequence counter must be write
held over the call to timekeeping_update() and the copying to the real
timekeeper and why using a pointer based update is suboptimal.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 43 +++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 979687a..b3f4989 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -799,7 +799,32 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
+		memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
+}
+
+static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
+{
+	/*
+	 * Block out readers before invoking timekeeping_update() because
+	 * that updates VDSO and other time related infrastructure. Not
+	 * blocking the readers might let a reader see time going backwards
+	 * when reading from the VDSO after the VDSO update and then
+	 * reading in the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
+	timekeeping_update(tkd, &tkd->shadow_timekeeper, action);
+
+	/*
+	 * Update the real timekeeper.
+	 *
+	 * We could avoid this memcpy() by switching pointers, but that has
+	 * the downside that the reader side does not longer benefit from
+	 * the cacheline optimized data layout of the timekeeper and requires
+	 * another indirection.
+	 */
+	memcpy(&tkd->timekeeper, &tkd->shadow_timekeeper, sizeof(tkd->shadow_timekeeper));
+	write_seqcount_end(&tkd->seq);
 }
 
 /**
@@ -2364,21 +2389,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
-	write_seqcount_begin(&tk_core.seq);
-	/*
-	 * Update the real timekeeper.
-	 *
-	 * We could avoid this memcpy by switching pointers, but that
-	 * requires changes to all other timekeeper usage sites as
-	 * well, i.e. move the timekeeper pointer getter into the
-	 * spinlocked/seqcount protected sections. And we trade this
-	 * memcpy under the tk_core.seq against one before we start
-	 * updating.
-	 */
-	timekeeping_update(&tk_core, tk, clock_set);
-	memcpy(real_tk, tk, sizeof(*tk));
-	/* The memcpy must come last. Do not put anything here! */
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_from_shadow(&tk_core, clock_set);
 
 	return !!clock_set;
 }

