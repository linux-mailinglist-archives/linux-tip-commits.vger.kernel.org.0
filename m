Return-Path: <linux-tip-commits+bounces-2584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC279B0C77
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570FF2816BD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0A20F3DE;
	Fri, 25 Oct 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQy5MY9H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtU4oNPe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10420D51A;
	Fri, 25 Oct 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879282; cv=none; b=Ajo0SzzU+YHgWWyXWLG5Afgeg23+cQVqHp6UhaQCFX+swV0pUqx8lcu150yWr9DmYCDWTmA0JJRZ0wvS7u/nuVGy3V2UnA8JJm4iNKRch18s85ioudwH5oY7xKdS/i8F30rSE5mO/aNppN+BowG2rGVK0sQ2KntmZyPns9yw2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879282; c=relaxed/simple;
	bh=9dQjf13OmaHYH6dxaUDG3RO9WibhbdtmSPe5/p2gxFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iswJBF74Sc9M0RroZ3/1xjEpOxKgFD6VoAQ+alXSj24qHffWc49I58u9JOPEqiD/62Hm2sJe0QNBE0K9WGZ+muZLOTIr1+rgS8Um0YnekPB5Qz6Lr/6YM3LIPfBd/XQenHEYb6DQAzH9Pnd1vcNBnG0hzWrwKhJ5K9K+G+YSujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQy5MY9H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtU4oNPe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHQOGIGLqgKZGMQ8o2KAHsrq7ktObAOqdaNn2laDGa4=;
	b=WQy5MY9H7R2J9AIzN65Wuku3xwkhclYxZ8HKAnHANIB3xylpFM0iMZHlOI39D8jY2DklQk
	+Mhn5b4XiiSVcVp3Xh1nn+Aegk1eQBVuArenCYHzH4Tk2X93DL/OMgFpmprZmfKjgiw66L
	KJo1L2ZM/Y1AMsaOy8Zebl7iSDRPOJ1IJxx00Qc0zH7CqpBqXkrTpmq8xhubL1Jc+7Jlb+
	4OCR/H4AYlzWNKez+waYlUmi+PcelLEPR5unmj5fzoBaw52zB/o+CkdUXzRgRWsV2QJAzj
	fup8JPUrosvrfNDOAqaCWZupvpiGs+hmu4D/sFwj7QvRykM1RGhSxA51+j2edA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHQOGIGLqgKZGMQ8o2KAHsrq7ktObAOqdaNn2laDGa4=;
	b=MtU4oNPeKAnLW+GevU22YNOWiENfXy010y+dFVn+Gg75HrM6mw04uz4t3V4QQbpBhUfVlG
	+3BrLaaWu0wqldBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework change_clocksource() to use
 shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-18-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-18-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987927834.1442.11292963436920603065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     351619fc99883d22ba1018b5914ae717bfef4221
Gitweb:        https://git.kernel.org/tip/351619fc99883d22ba1018b5914ae717bfef4221
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:15 +02:00

timekeeping: Rework change_clocksource() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert change_clocksource() to use this scheme.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-18-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e865f0..f77782f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1627,9 +1627,7 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
  */
 static int change_clocksource(void *data)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *new = data, *old = NULL;
-	unsigned long flags;
 
 	/*
 	 * If the clocksource is in a module, get a module reference.
@@ -1645,16 +1643,14 @@ static int change_clocksource(void *data)
 		return 0;
 	}
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-	old = tk->tkr_mono.clock;
-	tk_setup_internals(tk, new);
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks = &tk_core.shadow_timekeeper;
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		timekeeping_forward_now(tks);
+		old = tks->tkr_mono.clock;
+		tk_setup_internals(tks, new);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
 
 	if (old) {
 		if (old->disable)

