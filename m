Return-Path: <linux-tip-commits+bounces-2353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33459941D8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCCB28A4BB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EF20B1F9;
	Tue,  8 Oct 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDZjsZ9B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ha265Mbl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6220B1F3;
	Tue,  8 Oct 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374126; cv=none; b=pqt+Sl9jYAVoASLueTT4h4SGji2LjmIsjFw2mC5QnGkij5JDSH8FuDaalIGIfUMuBz9W/DxQ7dethd8NrW8n4gxkGK+i8uSUpoWDqLNYHIxlWHnRqaE60Tsoac6kijYT3KniaFiwirlQEudhx2nCK7b4OHJV6rmn3pgmw8HUwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374126; c=relaxed/simple;
	bh=m1+69MupdjabhBg4BtCmOI/gKKs2pwIQ5VgKnbwLLLU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gaUhGg/wX2mrg+udubYJLbKKDSMVO0QPGW0R3EtaD8Pu08p+Sze9ptoVSqn/4YTs2DXCA3hRGlSNch0PAgzrnPrZOl+lQU4yn7KU/XIcWGxxYDW66SzY1PEaMAcPk0rZDMv0JQy8inI/3NPjwy9eJiNpRDmLfz3aytd+Kirs8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oDZjsZ9B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ha265Mbl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:55:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pitD5SH+0remnEY2zBFwjncCoPZ1kYDv7OO2e2bjp9k=;
	b=oDZjsZ9BEZmgt0An7WaqrRHrR+duOZ+6azTbAZI4nb0+uMZXIUzXTJL5B9UCi4FulUlEvR
	2+G/fjQZQMP9AasRMYR/kZiQNl4c2YzZhu/yAeFr4LebDqvn0GxZ78SUoMUEvm2WCQIBCu
	+OA3Q1iXpQIU1BMRRd1rbJZtnAi8OX4Z7anbXHE3eloFI7qbAaha8o2pBXpY8iicfxvI1X
	EZHkVqAfDxTp15UVj1CWI2uflmnnxRYLMtClS/v9WJ0ddg0A6Ki20vyP20UkEZi08P38D4
	u6v23SPJAmRCJEjBMeP6bAbUvV9t6CiPaFtV7SsEDyY2xvAriShP3XGUuCuUDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pitD5SH+0remnEY2zBFwjncCoPZ1kYDv7OO2e2bjp9k=;
	b=Ha265MblZ3NaGUgu3r3ZWs+VBSfU7+IAWhaF0pWURKcSD6JqyDCNUBP3YXgpQzoQQCKPWJ
	mbvKP0JYKdXNiACw==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlocks: Make __raw_* lock ops static
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7201d7fb408375c6c4df541270d787b1b4a32354=2E17278?=
 =?utf-8?q?79348=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C7201d7fb408375c6c4df541270d787b1b4a32354=2E172787?=
 =?utf-8?q?9348=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837412225.1442.5506799925939042832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     afc256e131bb0e1ecb5e2b1df310b20fa7bd714d
Gitweb:        https://git.kernel.org/tip/afc256e131bb0e1ecb5e2b1df310b20fa7bd714d
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 02 Oct 2024 17:03:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:35 +02:00

locking/spinlocks: Make __raw_* lock ops static

If CONFIG_GENERIC_LOCKBREAK=y and CONFIG_DEBUG_LOCK_ALLOC=n
(e.g. sh/sdk7786_defconfig):

    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]

All __raw_* lock ops are internal functions without external callers.
Hence fix this by making them static.

Note that if CONFIG_GENERIC_LOCKBREAK=y, no lock ops are inlined, as all
of CONFIG_INLINE_*_LOCK* depend on !GENERIC_LOCKBREAK.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/7201d7fb408375c6c4df541270d787b1b4a32354.1727879348.git.geert+renesas@glider.be
---
 kernel/locking/spinlock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 438c608..7685def 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
  * towards that other CPU that it should break the lock ASAP.
  */
 #define BUILD_LOCK_OPS(op, locktype)					\
-void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
+static void __lockfunc __raw_##op##_lock(locktype##_t *lock)		\
 {									\
 	for (;;) {							\
 		preempt_disable();					\
@@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
 	}								\
 }									\
 									\
-unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
+static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock) \
 {									\
 	unsigned long flags;						\
 									\
@@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
 	return flags;							\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
 {									\
 	_raw_##op##_lock_irqsave(lock);					\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
 {									\
 	unsigned long flags;						\
 									\

