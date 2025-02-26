Return-Path: <linux-tip-commits+bounces-3686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F15A4643A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FE11885DC5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B221D5A9;
	Wed, 26 Feb 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxA89ZgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eCQZzKBM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29322332B;
	Wed, 26 Feb 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582704; cv=none; b=IpZLdqNOFYsl9FXT5DpkzHOQaEpDno82cHuM6wXZMbGvxsTgwkdYJruaQNarEHvNa2ZJ1q/Khw9VFZW9A7xeUgzKF7UYeh6D6RsCPqSQUInzBnCy1Tw5Q7V37gZ3YnXC6tNLeR6kTNdcyMAdA6wgMEaMMzcxzbPWxD0q0efImYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582704; c=relaxed/simple;
	bh=/u4DKCat2dLVmFp67gK3V+KUJxfHFKrs7LU9WBm325s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=usduFHvqPyBKV8NyU1XvjS9S8AkgZOu6qTEuJWWfs4FcThXTL1qtGDbq2ZsejnWeHEF4Nk1xLxW+QwhAuJxCzMEcKPZgf4c4WAGhnV0hS5/gLUrMvIhzTXnL9PyqDIJdc88U7tQo8hJ+mQq35aqmxxHGsc9qoBPRsGltXtzSXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxA89ZgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eCQZzKBM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 15:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740582701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfdIXM0mhUb+fQCq7c5gpf/bCIi5DfvQKwCiZpX7Zgo=;
	b=dxA89ZgS8jB7n8Z/SYh+AzSRzzEZ+pZpuRMyfR4KNMFRpa/ulcmvDpcoZN5tRCDOAQ8ToS
	Tb+txAD+LXyHCja3a2BXs64Y8MZs2hCKWQTemz7buyp0QUYIkwK3oecTUBsy6UWY4c+fQW
	DG1bBMBPNePJT6+ilj55fzn+jtksVE7uVzdkapJHLIh8B3pZcfFzTkgSvQ54+lEcP+7xA4
	SC+m6XKf8MqluRuqle+X+R8n5W2IdWEejfu6gja/yEdHmRnv1Q6/57MFAMORU1/aAzjWQR
	i8iou16Bh7dxqYuBEcPZ6Kw+ofeekh4sM+QU9ijdprxIclyO9aNXzhlSRVDobw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740582701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfdIXM0mhUb+fQCq7c5gpf/bCIi5DfvQKwCiZpX7Zgo=;
	b=eCQZzKBMJzJNKpP6GxqzCrq2woskstb6wD0TAI2dR4i07BD5p6emQjk3TuqsdXaouux7c6
	MwWq91+aTMjj3gDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Use a hashmask instead of hashsize
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226091057.bX8vObR4@linutronix.de>
References: <20250226091057.bX8vObR4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174058269688.10177.7713971723069325603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     e3924279e5164d821fa2cbcf0c15e7345cb3508e
Gitweb:        https://git.kernel.org/tip/e3924279e5164d821fa2cbcf0c15e7345cb3508e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 10:10:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 16:07:59 +01:00

futex: Use a hashmask instead of hashsize

The global hash uses futex_hashsize to save the amount of the hash
buckets that have been allocated during system boot. On each
futex_hash() invocation this number is substracted by one to get the
mask. This can be optimized by saving directly the mask avoiding the
substraction on each futex_hash() invocation.

Rename futex_hashsize to futex_hashmask and save the mask of the
allocated hash map.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/all/20250226091057.bX8vObR4@linutronix.de

---
 kernel/futex/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3db8567..cca1585 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -50,10 +50,10 @@
  */
 static struct {
 	struct futex_hash_bucket *queues;
-	unsigned long            hashsize;
+	unsigned long            hashmask;
 } __futex_data __read_mostly __aligned(2*sizeof(long));
 #define futex_queues   (__futex_data.queues)
-#define futex_hashsize (__futex_data.hashsize)
+#define futex_hashmask (__futex_data.hashmask)
 
 
 /*
@@ -119,7 +119,7 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
 
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	return &futex_queues[hash & futex_hashmask];
 }
 
 
@@ -1127,27 +1127,28 @@ void futex_exit_release(struct task_struct *tsk)
 
 static int __init futex_init(void)
 {
+	unsigned long hashsize, i;
 	unsigned int futex_shift;
-	unsigned long i;
 
 #ifdef CONFIG_BASE_SMALL
-	futex_hashsize = 16;
+	hashsize = 16;
 #else
-	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
+	hashsize = roundup_pow_of_two(256 * num_possible_cpus());
 #endif
 
 	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       futex_hashsize, 0, 0,
+					       hashsize, 0, 0,
 					       &futex_shift, NULL,
-					       futex_hashsize, futex_hashsize);
-	futex_hashsize = 1UL << futex_shift;
+					       hashsize, hashsize);
+	hashsize = 1UL << futex_shift;
 
-	for (i = 0; i < futex_hashsize; i++) {
+	for (i = 0; i < hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
 		spin_lock_init(&futex_queues[i].lock);
 	}
 
+	futex_hashmask = hashsize - 1;
 	return 0;
 }
 core_initcall(futex_init);

