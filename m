Return-Path: <linux-tip-commits+bounces-4608-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FAA77530
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8D1188A75E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822D1E833D;
	Tue,  1 Apr 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lUG1eKMP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nROvdCXY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B01E5B6F;
	Tue,  1 Apr 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492390; cv=none; b=WU+zIf/wTuPnm0R8h2o/QCxTb1V4jj3EExq3ygOXotJps+D2m+4I9rYA31xYEpPnZtCX7zTPuYJrjyrz0QE6x6aySjLANXwAd6JdVuzziqPwkse+p5J/+g6Abzhj6430zTt/FZ60L8+xxxtpAG7W84EdtLBCT2yA7mFf/TJ63Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492390; c=relaxed/simple;
	bh=OGXsKRaTe3Dn7cWbBMpGT1raF/9YufQCoY9bbsbo590=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ewP9tsYltCRT6L2u9MUaX007OLXAvTqVuMeVS/sy22bFlDEbnAUGA73W+IcgjoYf/agfEwI//56+gEAy83im/XGeoRU720a178Fagj64rV6rxEbuypbCLbCgdBldDlLOs/gEvCw//77U0KQYf+t4KInS7l+KySKWQOuWSMeHYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lUG1eKMP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nROvdCXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743492386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hogi/srkxWl7xobalBrZUQRylayws9SVsUajEim4eE=;
	b=lUG1eKMPZRbJ5aDRhmdM9nYxge1/rSkAmuEm7m1BLOK0gKZvH1f1wUcrCCiT8GS13aHA5e
	/GUDs1F3+4w9fPjJEzzykDHtMMsG6ntYOWoisnM3sUI0+DM2bBBM4MXU4M3OFqRc+cgDru
	Yp+91ZLCUzqUZ4R8d9bwIJ8nLv7O4mGs+sg1Kx43ZH/kIXpokrLmS2Olc9RuDw3V0bV4SV
	qECefV5wd8pF6lCZPHpJt07tny4T3U10BLOAWaQS3AbhAjbC+gDoglX9k+jS0GTUmQ4HNO
	dk9Ueza5W+x6CgnugTHGMo23X72drM/gA8OxH3CefqFSV7x2z2/zIe03Pmpnww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743492386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hogi/srkxWl7xobalBrZUQRylayws9SVsUajEim4eE=;
	b=nROvdCXY8LrPSfbYsd5ZZZk+Y7liDe9TB9vOM+YZWvuAcxqUb6rVpsWqrKdAjJvRrs6zpY
	OgM5TWQCegNOJnDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] context_tracking: Always inline
 ct_{nmi,irq}_{enter,exit}()
Cc: Randy Dunlap <rdunlap@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8509bce3f536bcd4ae7af3a2cf6930d48c5e631a.1743481539.git.jpoimboe@kernel.org>
References:
 <8509bce3f536bcd4ae7af3a2cf6930d48c5e631a.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349238596.14745.733493010301573871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     9ac50f7311dc8b39e355582f14c1e82da47a8196
Gitweb:        https://git.kernel.org/tip/9ac50f7311dc8b39e355582f14c1e82da47a8196
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:12:05 +02:00

context_tracking: Always inline ct_{nmi,irq}_{enter,exit}()

Thanks to CONFIG_DEBUG_SECTION_MISMATCH, empty functions can be
generated out of line.  These can be called from noinstr code, so make
sure they're always inlined.

Fixes the following warnings:

  vmlinux.o: warning: objtool: irqentry_nmi_enter+0xa2: call to ct_nmi_enter() leaves .noinstr.text section
  vmlinux.o: warning: objtool: irqentry_nmi_exit+0x16: call to ct_nmi_exit() leaves .noinstr.text section
  vmlinux.o: warning: objtool: irqentry_exit+0x78: call to ct_irq_exit() leaves .noinstr.text section

Fixes: 6f0e6c1598b1 ("context_tracking: Take IRQ eqs entrypoints over RCU")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/8509bce3f536bcd4ae7af3a2cf6930d48c5e631a.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/d1eca076-fdde-484a-b33e-70e0d167c36d@infradead.org
---
 include/linux/context_tracking_irq.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
index c50b567..197916e 100644
--- a/include/linux/context_tracking_irq.h
+++ b/include/linux/context_tracking_irq.h
@@ -10,12 +10,12 @@ void ct_irq_exit_irqson(void);
 void ct_nmi_enter(void);
 void ct_nmi_exit(void);
 #else
-static inline void ct_irq_enter(void) { }
-static inline void ct_irq_exit(void) { }
+static __always_inline void ct_irq_enter(void) { }
+static __always_inline void ct_irq_exit(void) { }
 static inline void ct_irq_enter_irqson(void) { }
 static inline void ct_irq_exit_irqson(void) { }
-static inline void ct_nmi_enter(void) { }
-static inline void ct_nmi_exit(void) { }
+static __always_inline void ct_nmi_enter(void) { }
+static __always_inline void ct_nmi_exit(void) { }
 #endif
 
 #endif

