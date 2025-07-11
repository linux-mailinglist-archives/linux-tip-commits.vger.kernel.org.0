Return-Path: <linux-tip-commits+bounces-6098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12231B023BF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 20:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC526A800AD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711B2F4327;
	Fri, 11 Jul 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0tJ2l/px";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="976VMWX9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1D2F3624;
	Fri, 11 Jul 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258819; cv=none; b=re3XUNNKwW7MGyGmCspVg9Q1zsaFmS48L6LrIVwZc7OO3m6v8Rlt6iu3+Ai56MDJGIaHVef8VxJkneDLSyI1lr1f3Ngr4CW93mmm2ZLSGPzf1Q3Yt3cQ90AX7jOHxgVJCGoGBKnILoLRl/mylFKlbu+DfR1CPz2WpCwK+3Vbczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258819; c=relaxed/simple;
	bh=Jjm2fj5w8/NaCCa4dd3P9BXKVFDkCetcZ7JvQs0qSAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=flCxN7OPCWrxOreATDRH7EBaNa8NZ7aqOcFk5jfHTX5VPoFgypClEx+Ix7AVAVYXS5pXD8Qv7WilYjc8PaxdDlZj8noUc1vC3OLYLmzvW5MNoWno9U2ioZ2Be93r6MqDxMtzC8QKiXU8CxNXf7HdQL0JKuiZWM4qMqgPwz8ArjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0tJ2l/px; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=976VMWX9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 18:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752258815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A7EDcDeyGT/u7DVXz9KlwbqG8lCgWEhnh/Jpb8xKR0=;
	b=0tJ2l/pxVGWL7J5vomYigaHx07aD03hnD1Dy/Kq+mGOtMT0SwkHuVDDP9kfutOGyqU2Wxy
	+gZUJYyViYnOrz3Cy8fLfvrHUkRa0+dF9B4jGfOBmwd0aWzYZzjyEp5g0gy8IBiOKs1wP7
	N/Rlp2JEsK79itT2iFFyWwLAcv/ZnJMkI/xkog9TztQ25spo0rJhZrFV0+JFOTpdlC4PJi
	LxVp78U/yIEO/lvBAeeLFBBBrISmzPoFytLYxAgBcHM3Blmpeb/ycriIMDipltKKa5EjTh
	nv6nQqiEONmC8ILFEboCQXp/Tc6lD255a/+pbxD5D558OglnTzxCcjDc1RDnbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752258815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A7EDcDeyGT/u7DVXz9KlwbqG8lCgWEhnh/Jpb8xKR0=;
	b=976VMWX9VlLI8Zd7gmXDgdY0FgQ1yvdRzxBD9egdr0LQcR3p/Q65mB/AbgB1XbxV8fsxCW
	KrdXGGoGHUKedHBw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Remove support for IMMUTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710110011.384614-5-bigeasy@linutronix.de>
References: <20250710110011.384614-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225881472.406.14315265094393144759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     760e6f7befbab9a84c54457a8ee45313b7b91ee5
Gitweb:        https://git.kernel.org/tip/760e6f7befbab9a84c54457a8ee45313b7b91ee5
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 10 Jul 2025 13:00:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jul 2025 16:02:01 +02:00

futex: Remove support for IMMUTABLE

The FH_FLAG_IMMUTABLE flag was meant to avoid the reference counting on
the private hash and so to avoid the performance regression on big
machines.
With the switch to per-CPU counter this is no longer needed. That flag
was never useable on any released kernel.

Remove any support for IMMUTABLE while preserve the flags argument and
enforce it to be zero.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250710110011.384614-5-bigeasy@linutronix.de
---
 include/uapi/linux/prctl.h |  2 --
 kernel/futex/core.c        | 36 +++---------------------------------
 2 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6e..3b93fb9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1981574..d9bb556 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -69,7 +69,6 @@ struct futex_private_hash {
 	struct rcu_head	rcu;
 	void		*mm;
 	bool		custom;
-	bool		immutable;
 	struct futex_hash_bucket queues[];
 };
 
@@ -145,15 +144,11 @@ static inline bool futex_key_is_private(union futex_key *key)
 
 static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
-	if (fph->immutable)
-		return true;
 	return futex_ref_get(fph);
 }
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	if (fph->immutable)
-		return;
 	if (futex_ref_put(fph))
 		wake_up_var(fph->mm);
 }
@@ -1530,7 +1525,6 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 }
 
 #define FH_CUSTOM	0x01
-#define FH_IMMUTABLE	0x02
 
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 
@@ -1800,7 +1794,7 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 	 */
 	scoped_guard(rcu) {
 		fph = rcu_dereference(mm->futex_phash);
-		if (fph && (!fph->hash_mask || fph->immutable)) {
+		if (fph && !fph->hash_mask) {
 			if (custom)
 				return -EBUSY;
 			return 0;
@@ -1814,7 +1808,6 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 
 	fph->hash_mask = hash_slots ? hash_slots - 1 : 0;
 	fph->custom = custom;
-	fph->immutable = !!(flags & FH_IMMUTABLE);
 	fph->mm = mm;
 
 	for (i = 0; i < hash_slots; i++)
@@ -1838,7 +1831,7 @@ again:
 		mm->futex_phash_new = NULL;
 
 		if (fph) {
-			if (cur && (!cur->hash_mask || cur->immutable)) {
+			if (cur && !cur->hash_mask) {
 				/*
 				 * If two threads simultaneously request the global
 				 * hash then the first one performs the switch,
@@ -1931,19 +1924,6 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
 
-static int futex_hash_get_immutable(void)
-{
-	struct futex_private_hash *fph;
-
-	guard(rcu)();
-	fph = rcu_dereference(current->mm->futex_phash);
-	if (fph && fph->immutable)
-		return 1;
-	if (fph && !fph->hash_mask)
-		return 1;
-	return 0;
-}
-
 #else
 
 static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
@@ -1956,10 +1936,6 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
 
-static int futex_hash_get_immutable(void)
-{
-	return 0;
-}
 #endif
 
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
@@ -1969,10 +1945,8 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		if (arg4 & ~FH_FLAG_IMMUTABLE)
+		if (arg4)
 			return -EINVAL;
-		if (arg4 & FH_FLAG_IMMUTABLE)
-			flags |= FH_IMMUTABLE;
 		ret = futex_hash_allocate(arg3, flags);
 		break;
 
@@ -1980,10 +1954,6 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 		ret = futex_hash_get_slots();
 		break;
 
-	case PR_FUTEX_HASH_GET_IMMUTABLE:
-		ret = futex_hash_get_immutable();
-		break;
-
 	default:
 		ret = -EINVAL;
 		break;

