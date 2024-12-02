Return-Path: <linux-tip-commits+bounces-2951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE29E00A1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE99161909
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365820B1E1;
	Mon,  2 Dec 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4iExyxh0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w23TyQHJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004120ADF2;
	Mon,  2 Dec 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138625; cv=none; b=SGCP5M0S20TuRMhGxjtGhqCPoFr1LLVTHC7/o30HW1iSlMAEovHLFQJuzxjq9U2HfI3KUQ6UL5oAjtwWvdb4B3JqIcAytihHwn5zeoIyxyp24yfX9c1i19XmrxdwqxzFJ+gV1sYX8FgC4gET1tveVdXl5nMitSOvVG17GXKud0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138625; c=relaxed/simple;
	bh=63+NVuHGkVLcec2mX72HVy4f7mpGKqTxshLoFGwA+6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LKkwWUsyOHLxwjwOzjObVH7UHcxNWf0rLsHtWqcV8yRyb0za94RELrhu/n4ZkhUOQq2agurUAmSpA5LxfLl6aRessPDoqwbRGL9uVzDlmPhOhHy8ypJ+17wFEAA2lSpIVdl/yt3UivYFfgtzGvLdyjOtq1JaF5xopeZN5qvnpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4iExyxh0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w23TyQHJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8JcobNS49EEuO2Os0w/FT2BW2a3AYOl6CHXXUh8xg8=;
	b=4iExyxh0+cIoBw/aMflbt9iSunLCTBABDIur5x1HwUqP1wyuEB2FQTF59/NytMmmmmmhIV
	ChyIHb1oRLxQU1oP3J0FniinBRoUYUxtvikoGtFUzwzI8Tjf4+sQSO0dk3tcXY5NzjUCpI
	Ot6/XErvYlQDu4xAyqlBK5tRSa1ZbGELWPFTWwjEQQpCWxz9zoCpUcy9boepjfUyFkYDoW
	XFKq6zolMKQQb/G5J/Jv+msEITdiX2d54gAcNwj0aAgbXxi6wKxv8g/EQswk3if/gu2PW2
	OpMibRDR4oFZ0iL5vdhbzxm0Qy0hP6zFbUcPbT9oMukQDmIT4DtAXwRrhWIrqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8JcobNS49EEuO2Os0w/FT2BW2a3AYOl6CHXXUh8xg8=;
	b=w23TyQHJuEl3xhqgeMqxDW5uhOVpiIaK++t4ZC9uzhxgiFmBn0Ig1KYZcfXjCqEMbezAfG
	9r6m0ZjuNqXTQ/Cw==
From:
 tip-bot2 for Thomas =?utf-8?q?Hellstr=C3=B6m?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Fix ww_mutex dummy lockdep map
 selftest warnings
Cc: Boqun Feng <boqun.feng@gmail.com>, thomas.hellstrom@linux.intel.com,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241127085430.3045-1-thomas.hellstrom@linux.intel.com>
References: <20241127085430.3045-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313861474.412.152962477443860855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0302d2fd6efb0c386e521df0134eb2679a9a138f
Gitweb:        https://git.kernel.org/tip/0302d2fd6efb0c386e521df0134eb2679a9=
a138f
Author:        Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
AuthorDate:    Wed, 27 Nov 2024 09:54:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:16:57 +01:00

locking/ww_mutex: Fix ww_mutex dummy lockdep map selftest warnings

The below commit introduces a dummy lockdep map, but didn't get
the initialization quite right (it should mimic the initialization
of the real ww_mutex lockdep maps). It also introduced a separate
locking api selftest failure. Fix these.

Closes: https://lore.kernel.org/lkml/Zw19sMtnKdyOVQoh@boqun-archlinux/
Fixes: 823a566221a5 ("locking/ww_mutex: Adjust to lockdep nest_lock requireme=
nts")
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241127085430.3045-1-thomas.hellstrom@linux.=
intel.com
---
 include/linux/ww_mutex.h | 4 ++--
 lib/locking-selftest.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index a401a2f..45ff6f7 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -156,8 +156,8 @@ static inline void ww_acquire_init(struct ww_acquire_ctx =
*ctx,
 	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
-	lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
-			 &ww_class->mutex_key, 0);
+	lockdep_init_map_wait(&ctx->first_lock_dep_map, ww_class->mutex_name,
+			      &ww_class->mutex_key, 0, LD_WAIT_SLEEP);
 	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
 	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
 #endif
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6e0c019..ed99344 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1720,8 +1720,6 @@ static void ww_test_normal(void)
 {
 	int ret;
=20
-	WWAI(&t);
-
 	/*
 	 * None of the ww_mutex codepaths should be taken in the 'normal'
 	 * mutex calls. The easiest way to verify this is by using the
@@ -1770,6 +1768,8 @@ static void ww_test_normal(void)
 	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
=20
+	WWAI(&t);
+
 	/* nest_lock */
 	o.ctx =3D (void *)~0UL;
 	ww_mutex_base_lock_nest_lock(&o.base, &t);

