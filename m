Return-Path: <linux-tip-commits+bounces-2585-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B6B9B0C79
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021A11F24DBA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E8E212163;
	Fri, 25 Oct 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1JXcAM3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFVk5n0C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E420EA36;
	Fri, 25 Oct 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879283; cv=none; b=BnSfiBjlNCcPK6apDu2PcYmmLs90oYAhLSca+UnNzLPG+bpjeteaXYTfLVa7THXMvhhoZfDU+U6ayGaWFfF1kwG+FVNokDtkAJv2n8wp43G0rkO4FmjFJiPt1MaXsOwcsLwIWj7HC43GetUE4Vn86U9ORPS1aF7loIQGvx/HLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879283; c=relaxed/simple;
	bh=8lQhwWzMIUn+O+CRBjAWJL+Ibx4OaBkPgmcl47mqlKs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cDxvxAR5wSEfn/r+llijkQ8XJVZs17FppReVJwejogGg7NqJmiadsbrSkImopXOTC+vz/yekgdAFbipvISxZJ6VPv2U3TU9Jyv1KD/0iCTLyUz5+KWzOKoypn4P2PVNyJvzEfHZ42NQZhjyEzVa/uluxSyGut2O1+a6empCr0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1JXcAM3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFVk5n0C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKPyYxBSYiJ6jYXeCHfPkzJOPeL1qXDul/HH9V2//Rs=;
	b=a1JXcAM38alJZrmeI17ZLClcwU6I9/k0BiX/vb/VdmpXhSkVWlnmecG1TC+ZrhUXYDENXV
	ZUQqhTa07KqxD8+e5mKDo7ynTJas7SzJczP2UFB7fXOKDtKu44U9tkfVnFYeCnC+Ny5DuI
	18nCBmtB1UndmJza1A2fKqt6eULSzrbMh+il9snQyzz2WC8K0w0J4n9qD69lElOrQK/OiZ
	new1ku2BfP2HkEXSCI3zcXvn5CkqmqTIb89phuYgu2s2XWRoSJc1t8f3CdGI58q/Hi2djU
	o9Rih9+0ANqLNDN1WYA+aWhNfAWRHwwZGqZQmQeTJRl0SM4Ftjrydwkh8TClOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKPyYxBSYiJ6jYXeCHfPkzJOPeL1qXDul/HH9V2//Rs=;
	b=iFVk5n0CZ9BfRsfZFEkX5Q/KI23Mb4b7+FQb1XuJ3gTqzYNZmhaGfHn9YTbfyE4CsUd7Pl
	jAR2p8/tikE5SBBg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework timekeeping_inject_offset() to
 use shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-17-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-17-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987927903.1442.6753504312627902580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     82214756d35f48056fe36aa4d95a22e44a3b2619
Gitweb:        https://git.kernel.org/tip/82214756d35f48056fe36aa4d95a22e44a3b2619
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:15 +02:00

timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert timekeeping_inject_offset() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-17-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 41 ++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1b8db11..7e865f0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1550,40 +1550,31 @@ EXPORT_SYMBOL(do_settimeofday64);
  */
 static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64 tmp;
-	int ret = 0;
-
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tk), *ts);
-	if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		ret = -EINVAL;
-		goto error;
-	}
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks = &tk_core.shadow_timekeeper;
+		struct timespec64 tmp;
 
-	tk_xtime_add(tk, ts);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_forward_now(tks);
 
-error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tks), *ts);
+		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_xtime_add(tks, ts);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
-
-	return ret;
+	return 0;
 }
 
 /*

