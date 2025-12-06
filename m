Return-Path: <linux-tip-commits+bounces-7609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4055CAA320
	for <lists+linux-tip-commits@lfdr.de>; Sat, 06 Dec 2025 09:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C1D3092411
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Dec 2025 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94F296BD6;
	Sat,  6 Dec 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1b5kaC/a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dyi5RJ6c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC02B9BA;
	Sat,  6 Dec 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765011517; cv=none; b=a62be6TUOpbW1p6mexs7ITntnrD9UGsuyomedtg0B7X7q7gSD7TUNz8ZFGe+2t7MLreGV1sH9LZiHWPYti/BJHbaEiTaZQVlSQj+OtzXJZZtqYx7Ub6030OA7abjjcHzutsx3U+lRrTJxiAAGkVV1J8G9zm7JpKw2O40Tj59iQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765011517; c=relaxed/simple;
	bh=rTOtdUWgHoI2qcslChEz915PRgmpK9PenOxecG/ZYuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jj4G5D57xuY1+JADz6hj1XBtUJA7kIvyHLOsx8+qaZH4GL+oiQYPRw/17/BNZ1YWjmOgmcpWQHVTcg2i2wSoxHy9hLav2NyQ5mWx6JqfkgsCqQfh3tu8wKiPkyBv7Ot5if+YRyJHyIdJjX4GfuAMqCzaXDu4jSUUw7ygaMeRfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1b5kaC/a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dyi5RJ6c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Dec 2025 08:58:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765011507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+COr5MY30l2O3nmA3YODbrhZc2rRQM84VvToXXrwsDY=;
	b=1b5kaC/aj8rFj8pCvdH5WBU4sJb9hMYKuOlBj5Qwv80udwcBXPVysY5FFAOZJYr/ioL2Zf
	WyUi52NvxCzmPoJzeaeEmcgjEtldWGIF7o1mSHMxWVMg2/Ri5NwRhhzazndn20K2eE85aV
	LgQeocdrpRoSkZv+zli0rjOmqfR/GzdQXFyPKmt2quaqyq6wEfr9mLLjEYiJjLvVldq9uZ
	JGlcld9BruvfM0ooc1L2BN3qCzlGGrk53jiKs6gD/HUn1fKj0oiT5Pm2k/gbmz1a/ycBq3
	3MiQkt6RHuiXZteudw+1CYtZRT7RRTz1qB19tDse5N1B+KjSLfYfFhLk+ASFEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765011507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+COr5MY30l2O3nmA3YODbrhZc2rRQM84VvToXXrwsDY=;
	b=Dyi5RJ6cibrSVyYS5RtEr4fGED1fTv6XDSKCPRK0KcvwRJnbEFZCGT/7glVBk1PWrlJlXe
	LjwYqFy6bdqr9vAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] seqlock: Cure some more scoped_seqlock()
 optimization fails
Cc: Arnd Bergmann <arnd@arndb.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251204104332.GG2528459@noisy.programming.kicks-ass.net>
References: <20251204104332.GG2528459@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176501150216.498.3550395153051808220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     90dfeef1cd38dff19f8b3a752d13bfd79f0f7694
Gitweb:        https://git.kernel.org/tip/90dfeef1cd38dff19f8b3a752d13bfd79f0=
f7694
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 04 Dec 2025 11:43:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Dec 2025 09:53:05 +01:00

seqlock: Cure some more scoped_seqlock() optimization fails

Arnd reported an x86 randconfig using gcc-15 tripped over
__scoped_seqlock_bug(). Turns out GCC chose not to inline the
scoped_seqlock helper functions and as such was not able to optimize
properly.

[ mingo: Clang fails the build too in some circumstances. ]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20251204104332.GG2528459@noisy.programming.kic=
ks-ass.net
---
 include/linux/seqlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a8a8661..2211236 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1224,7 +1224,7 @@ struct ss_tmp {
 	spinlock_t	*lock_irqsave;
 };
=20
-static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
+static __always_inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
 {
 	if (sst->lock)
 		spin_unlock(sst->lock);
@@ -1252,7 +1252,7 @@ static inline void __scoped_seqlock_bug(void) { }
 extern void __scoped_seqlock_bug(void);
 #endif
=20
-static inline void
+static __always_inline void
 __scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state tar=
get)
 {
 	switch (sst->state) {

