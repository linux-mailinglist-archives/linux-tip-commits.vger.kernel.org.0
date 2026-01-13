Return-Path: <linux-tip-commits+bounces-7897-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B0D17E06
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDB5303C210
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7D389E00;
	Tue, 13 Jan 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w9ZsAsxN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLHZRVWy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A20389DFF;
	Tue, 13 Jan 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298817; cv=none; b=i2cj3XlG/Wkm03ZGfhNVDwBjCGKe2DnW52HmMTrnwq3DgS3zUoSgGuX+21orKw62idGJ/H7Y/26jCYuM7TVVarZd2G85jGy+3IpSB3gdmkJwzAQLutdGmaIpQnPZ2GQw2YYlhwgV1REeoQgrvyI2CswiVJX4J2mfuTbFH41P5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298817; c=relaxed/simple;
	bh=WPcqYtJxnf/hnmpfhvVo1zqLsXmTkkVuI3E761zOm6M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WNG6u1MBhVeALThkUagaJ0RPXE4EuQ0hwvhVFBAav1f/prt7/jYXTqWH4AB7Rfrj3KFYGBKjBCNi7IWKgzk+xwYT6JP128vVy9QpmFb44V0slGWhyiff6LRTmJz2SAMpf1XVn1eBUG5vFIMlcdrhq4UiCmlmDZbxzGUE6OUdURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w9ZsAsxN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLHZRVWy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:06:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768298811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/NnfsyhFRbq6J4x/pSaSWiqLcGjDxxEB8zR+KFgiQY=;
	b=w9ZsAsxNbjcz+P9fDmlduDiOTCPj2SLPi33ub+Yu1NAoUS19zxwJkaB2D1qwQ/rCbGl9bo
	LY2awVjuRXAXocahNJmmI6DZGbv1OyO/mOlxWUlkgCGnKuapLst9w8JhHFw4Whbufa51bo
	XtG7oiW1gRLpfgk4qwpgXROgMAHapk9TCsWYmcP7ePyBIA0h5NjwfwrBZqwD+h0dmrYSKd
	rmZn3Cp0GGjhn2i+psjjRMGdLJ1CWiH9IJ+tSpyyvPZ0Ll7gsenwzHeHq9pOrwAAbY2cgS
	l4vFJlogAqPFAkBXy0DhiC1FbSChTqdIHwgSAGSZQKSZxDhjizPgv4U7uNyQqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768298811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/NnfsyhFRbq6J4x/pSaSWiqLcGjDxxEB8zR+KFgiQY=;
	b=qLHZRVWyOe/yG8xuQlR/jIDCsa0hVwDPJYGB8XBbxi72bSUvI7H8fBrb8/k6dqLaufSO96
	JkBM03FPzWDOrSAw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Remove public definition of HIGH_RES_NSEC
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260107-hrtimer-header-cleanup-v1-2-1a698ef0ddae@linutronix.de>
References: <20260107-hrtimer-header-cleanup-v1-2-1a698ef0ddae@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829880997.510.13064294720517244532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     84663a5ad6333e8dcb57be9bb113f592e05b33c6
Gitweb:        https://git.kernel.org/tip/84663a5ad6333e8dcb57be9bb113f592e05=
b33c6
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 07 Jan 2026 11:36:57 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 11:05:48 +01:00

hrtimer: Remove public definition of HIGH_RES_NSEC

This constant is only used in a single place and is has a very generic
name polluting the global namespace.

Move the constant closer to its only user.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260107-hrtimer-header-cleanup-v1-2-1a698ef0d=
dae@linutronix.de
---
 include/linux/hrtimer_defs.h | 12 ------------
 kernel/time/hrtimer.c        |  8 ++++++++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index e0280d8..02b010d 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -6,18 +6,6 @@
 #include <linux/timerqueue.h>
 #include <linux/seqlock.h>
=20
-#ifdef CONFIG_HIGH_RES_TIMERS
-
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-# define HIGH_RES_NSEC		1
-
-#endif
-
 #ifdef CONFIG_64BIT
 # define __hrtimer_clock_base_align	____cacheline_aligned
 #else
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f8ea8c8..2d319f8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -50,6 +50,14 @@
 #include "tick-internal.h"
=20
 /*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+#define HIGH_RES_NSEC		1
+
+/*
  * Masks for selecting the soft and hard context timers from
  * cpu_base->active
  */

