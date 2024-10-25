Return-Path: <linux-tip-commits+bounces-2556-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB49B0660
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313A8B2747D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193A188703;
	Fri, 25 Oct 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3liLzO8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IB8zXcEC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039717624D;
	Fri, 25 Oct 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868033; cv=none; b=CjETo8gQ8sVP/ASGjS+MjgKNsXlBr5WZexq3iXtQ45CJnyn5rwmCGw/iYNz5tJlVfCot+NXLRzZvkecq3yS0DaKO/qjdgE3V7YF7joCvMjdUpNEzmAWQh0fuc5dh0VMPWP/rFhB0CbSerdb8UfeaoNO2UomeijcZR5wcUcT1/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868033; c=relaxed/simple;
	bh=O7u/44TDwgcTS3YGQ86K1uC9DdBbJNK+U9e/FuQ2pio=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gzoRZuWwj+x2cw/t9nqkWxcvNgz4qvKTZDwYTIT9D2yFkHpc0fquNivWl2Hl+T00HiMFQn5Ay2ZrQKVRRn2fKMTkwOCE7TlZH0WtSeS9SIZLwHe55xz9TB8qIKSrEE2UqQEmLY355O6FPEVDpDA1rRt4V0hkn4oekQxOQkHPcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3liLzO8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IB8zXcEC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3r1aIm2kxTV6yTq1X8fdTNYIi25K+L9RJCHo8A03Liw=;
	b=3liLzO8iYXUZMw0f/bZRIFyN/c9ZgrNXN1P9kBrk8ndfmvmrgx2dI6+GMp8WsJNp5ZkGH/
	VezXjVxiGZ4fMj+CMa6IHliyLQfqqX0j0/CqQ9/XUs/8Cn8ZegmmKLPsxihHFZMq8UGeJ3
	MDI4gxln/y6vZL/riQ3D9Fj3xS85/f0/gKtxH2nOCXfNI/HGdpmay6vspaYBuyCB1AvMwq
	/roQAi7SUv1badpej+eQF5t7sdMGp1Yp1LfI0xVLqN66HdgqeWXoSVAsFoPgviGX7Kup1+
	C2Ww5Ub1kK+WVuoq1Q+KCK+L3EMi8vbEI455ovtmJ46okDUBEpfd5Dfj94+b4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3r1aIm2kxTV6yTq1X8fdTNYIi25K+L9RJCHo8A03Liw=;
	b=IB8zXcECiY6ceu0mLnnSfE6X1hEroJTU2vgFjWlqhOmuBq434Uo+sYB8IX8REUECMTVcGZ
	5nsCs/c2gD5/3nBA==
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
Message-ID: <172986802931.1442.17694267899406047615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d1189b155ecedbc136b1ed505f300d1184f9784c
Gitweb:        https://git.kernel.org/tip/d1189b155ecedbc136b1ed505f300d1184f9784c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:13 +02:00

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

