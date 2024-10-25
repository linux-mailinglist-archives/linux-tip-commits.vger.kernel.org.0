Return-Path: <linux-tip-commits+bounces-2561-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78B9B066A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A7B2414F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9120D4FD;
	Fri, 25 Oct 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ei8Ihh03";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="noWLmiTO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F01FB892;
	Fri, 25 Oct 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868037; cv=none; b=GpIJyVBwOZrRs3n34MDL4y65NDecGRe09UNeif8yCIigPcIesFxCjH/Ly+yybMXvOrgItsgvvtbuSDZgRkY/uPLWDg1e2d2HN13TSfI+s8dGreh5ulq/oQSwOvvtZywEQSJRNhPMkqwn9ggF1pwe5kwzKXuOqi41Rh9TLi2UxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868037; c=relaxed/simple;
	bh=+dnnKMEuS/af66k2kmO5KSo4UuVEiAMGYoHiiAKjsWw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n8injf3UrHHfC9fMcArqLmdSKnTRJZkvjiE3rnwlL9vcC/DG1/iBISwkZx2RR7/9UISwgsdUhAvUradua4gbUn1/NRM79ojjBSBwi1jmRwkWqedEoupAgNgxJ05mtZHtgne9Hdi/lTp+ElcipdXGybaJnogXn/NEgGyvvbmO0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ei8Ihh03; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=noWLmiTO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utiA9j37pvKT3+1Z9NquXoAjAuKhyBOxIsJSxqFcocw=;
	b=Ei8Ihh03nX6qu/SEh2qZgGiOlWgn79x59MO1EonuIX/c/pLlIwrQmx1PdcKoHD11k6UVNU
	bDFFQC3bGVKfUsdSbv1+ycz3Ug8NpmyMxG5bCL2TX0QP48iP1FWevdQTJxB9vrrkkkEV0y
	YbtRFs38ZyM+UaNMmYQ9O/6nQMc0c2j4oDRZ6r7YNaNaxaTcPT1vgtloLLXY/xSu61pTrW
	rNFfqX6UKUFVRBzTh4X+JXn6cHFgJxo7Vz/9QmZScwzkFRh+su8XQ8owSmtovNcwdH4+PI
	PveC5T5CtLts5rDsiNR2qxWXF3uyOLPLVLJ0BsJMd/hbbCt+y6VDdJLAQlY47Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utiA9j37pvKT3+1Z9NquXoAjAuKhyBOxIsJSxqFcocw=;
	b=noWLmiTOUUoUXQSwZNTShJWHHsTDFB4ESaujZkFtA7Mm5f9uF5YayFjNFPit/1j38NtaXY
	rFN8y2sBQQs9mtCg==
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
Message-ID: <172986803272.1442.10417799075715216612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     752bf87c978df9d226b1420d96ad574ff58e73ca
Gitweb:        https://git.kernel.org/tip/752bf87c978df9d226b1420d96ad574ff58e73ca
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:12 +02:00

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

