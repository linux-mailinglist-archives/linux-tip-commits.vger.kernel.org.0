Return-Path: <linux-tip-commits+bounces-2571-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D69B0681
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A701C23597
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F121888F;
	Fri, 25 Oct 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JrODuZhO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2zXuGnQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABF3DAC17;
	Fri, 25 Oct 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868043; cv=none; b=D5NR0359TK88ctB8mDOgMZwpJHLs/N1cuhUwMUeMtVGKjWJamEqtpOCG2UnlZoByOofNSWkpo9BaYpyRlt+Ihfo7GrLj+ytBQRDgabh+a7suQf+HE5sEYPg+XyeH+YQIMI+jUGG1pWj9hNOgrwW1z8z1c4QZqhal4+ZDIl70meQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868043; c=relaxed/simple;
	bh=ZL1+HhAVfkHLoO3UqpdVNWCDHJaUwC6HgckQVW9buFo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=alNzPq4ytW9SF/fzam3LK0ubK66SupNdMUk5DfhET0fy64cgnXgR6fIoALW/UZdA9xrFYwzgCv8m2TS+Rf3zrLU5OyD/KByHH4gcMHR0Eo+loGAiL4/CBf+Qc5sIF294z6//mOXX8JlL95po/mRRrMtNJkrduhXIhvVVTtjE2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JrODuZhO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2zXuGnQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfWSuhfG28a80cKKSbKfoPuES6Z9T3MTYA7cWgfEC0E=;
	b=JrODuZhO+d240tVuemohAAef6UhM+NFtsSW3T2IRT6o8BiM3fyDVPv44hGKn/BNUlXsxzV
	iBQhAkwCz90P9wz+F9a56qiI+vF6Nwb3eljqVyC2EMTFXywfQXmTL34+SXg7hmU7zvgmE8
	p+BYWqcJQBvtCtiDA62l6+6mAS6RsGumAvpf1gIhxRRsud0vzJAY3ZSR42tSXPJ3DF29g7
	p6n5kmT2aF8yWy/EQIIoujdGAT4ngPn6M09kEIR8OmA3p2peS+z547my1MApRrqZ1IT3NI
	hAujznTUlvFHZld1ZazZsYpJ9MC12Sf4Tx8cLxyTdP40nT0p80wfNICR5yYBDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfWSuhfG28a80cKKSbKfoPuES6Z9T3MTYA7cWgfEC0E=;
	b=j2zXuGnQBXyHMSzUzJvy4fifs9rhbqEXEx5N4S8PoqtSapdizwCUvER0v3v9k7ECHq9+Cr
	WNtcUQXejgUQatAA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Avoid duplicate leap state update
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-3-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-3-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986803948.1442.18089247441410318713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b9c0b26b74fac86ecefd95f7d6d8c978faa1af13
Gitweb:        https://git.kernel.org/tip/b9c0b26b74fac86ecefd95f7d6d8c978faa1af13
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:11 +02:00

timekeeping: Avoid duplicate leap state update

do_adjtimex() invokes tk_update_leap_state() unconditionally even when a
previous invocation of timekeeping_update() already did that update.

Put it into the else path which is invoked when timekeeping_update() is not
called.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ff98a0b..14aaa44 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2715,8 +2715,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 		clock_set = true;
+	} else {
+		tk_update_leap_state(tk);
 	}
-	tk_update_leap_state(tk);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);

