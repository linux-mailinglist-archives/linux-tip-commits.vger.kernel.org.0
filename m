Return-Path: <linux-tip-commits+bounces-1634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22C92B882
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF081C217CF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C2158211;
	Tue,  9 Jul 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NU8RSJQ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7yi7i9jc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13C1581FD;
	Tue,  9 Jul 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525290; cv=none; b=F/kU4aPwGR6s58/o+rxjqs/otLspgKAvtJV2d7ug4VDmtMrgVePgH99pvHDmxl5vxFggYppep1J7mOhWPj7cns4UVwY2XFS1F7hULKKylm+ESgyybCcBBsYXAhuiokjmufiD72wkGsDF4hvYhvT1A8o1Op/Xbrwul8ng8laX0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525290; c=relaxed/simple;
	bh=G1mv/ctiM9TqjW001Un7/Na1gR/uhmQ5zZIWe/lwM/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fW8jAXAjxKcO/BC+bV2We4NSNMVbna+1MkBm/p54SZRS/QXVWQB/30r/QAg9EP0f9szp3/f1bOA66NAqoYgZe4dPhxYg75vmeB2xFzsPGMtxhpnLjMugHvwYRkKHtJ0b1TtcoNPrymFcuekh/IE/c2Hmuyab4xfpP8nZq/+T0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NU8RSJQ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7yi7i9jc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ybbs+7Bz7d/3idW6fYutWCwmlUJrBaVKYasp571cdI=;
	b=NU8RSJQ5WVO7VR5ORYNKevBNKtKKQwl8f3ig5Z8BnVpLQeAp0kiSFY6Wz0Dsgwr9REBTcp
	ckiuMAEXQL2VUR7wW1ACdT6DqzPLjodnCosAoGoPAdBMwSPMeAtlR8umYGWwsAXk1v1EuL
	dBYMKZsMZg3g5RLvmRqxd5XFGLv7obrOLHhbqYuvDH8t/DVfVmISRBpAXGNDwZBBN6NtKI
	m/r2XpODFMNlSP9McpVxceHHAseW4kt19+CqcmWWC49nNJxjuLIc56xL5qVsehuPG2sEpp
	HYa1tDVWPd8n+cppHw+MQ3FFplUOh8cZ1qG/n3wxx0IV0wuMMNepdiZFqSaj7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ybbs+7Bz7d/3idW6fYutWCwmlUJrBaVKYasp571cdI=;
	b=7yi7i9jcPQan90HYDrR/l7u4AtlD/ea+cEo9HwqRkH4E3lmNY6qt3lyDZ8+mE12hoy9YJ/
	KnOjDnIlrFR/XeDA==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Add __always_inline annotation to
 __down_write_common() and inlined callers
Cc: Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240709060831.495366-1-jstultz@google.com>
References: <20240709060831.495366-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052528498.2215.9206229756576396995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e81859fe64ad42dccefe134d1696e0635f78d763
Gitweb:        https://git.kernel.org/tip/e81859fe64ad42dccefe134d1696e0635f78d763
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Mon, 08 Jul 2024 23:08:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:26 +02:00

locking/rwsem: Add __always_inline annotation to __down_write_common() and inlined callers

Apparently despite it being marked inline, the compiler
may not inline __down_write_common() which makes it difficult
to identify the cause of lock contention, as the wchan of the
blocked function will always be listed as __down_write_common().

So add __always_inline annotation to the common function (as
well as the inlined helper callers) to force it to be inlined
so a more useful blocking function will be listed (via wchan).

This mirrors commit 92cc5d00a431 ("locking/rwsem: Add
__always_inline annotation to __down_read_common() and inlined
callers") which did the same for __down_read_common.

I sort of worry that I'm playing wack-a-mole here, and talking
with compiler people, they tell me inline means nothing, which
makes me want to cry a little. So I'm wondering if we need to
replace all the inlines with __always_inline, or remove them
because either we mean something by it, or not.

Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20240709060831.495366-1-jstultz@google.com
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17ae..33cac79 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1297,7 +1297,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline int __down_write_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 
@@ -1310,12 +1310,12 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_write(struct rw_semaphore *sem)
+static __always_inline void __down_write(struct rw_semaphore *sem)
 {
 	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static __always_inline int __down_write_killable(struct rw_semaphore *sem)
 {
 	return __down_write_common(sem, TASK_KILLABLE);
 }

