Return-Path: <linux-tip-commits+bounces-1642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD95C92B897
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD431C21D46
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D759E15D5C4;
	Tue,  9 Jul 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uj/S9yfl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KRgU+Wq3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21D1591EE;
	Tue,  9 Jul 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525322; cv=none; b=BX8dJ9s7CcuPRSLoTzo0dq1crOvEkUY8zO58oXYTvXWtGBmI0pivN3HVl9amXtZ2tAnQWzFDgMThnaJ6ZP1OIuTjm1Z50UFSw/Ehym7RPIuNHxoXgV8NKUXeJ3cE3/hIjspOq0qz4CbKgMsijTn9Uw/61fq+41ZfZyY8tRk1oY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525322; c=relaxed/simple;
	bh=s2fhowwMqPJtd8959CM9VSIve/yEDEgfgGO7elOAYPM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ypc6L3ViyLE5YD5eeDKXVezBjtScuamvrIFGmVGPVcESdHBgD0cATMHOp6zWeDPyc5DdWumPDZV9N4K9THBeZzHmRJE08VDqTX6r5wdYQxMj6QhUAuJb+pzOJKKx0kizZQggTXkkxf28QSPvCNLbTO1RvQowvtKMQnn+oYa4+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uj/S9yfl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KRgU+Wq3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rn3HpoyNFxDFWcaa9J8PQ6XGMfOEyIfdKE370CbOQ8=;
	b=uj/S9yflIgkNMtYqNTR2dvdXsw7LpKkROSgZsHLnSfOd30GeMw54DDkhwQNQ2Y4DznfhDg
	PG/LDRpl5jK5i7bZN8pmjUIhS62ni8J1pYT9PMJv5A30DzIGDsproZdQdPBvsy5NFAQwCk
	9LIIOvadsPJnsw14eIB6sQHkefi4CnhaOpQTfv7NWH54oJItc5I+TRrwy2RoE6Uad3xZGZ
	DQTWMIwU0wew0I0XZQuYLpr4142YX1xm6l1LzAstQD/x2e7W3PGxzvquZGk7anXcde/3r0
	xj8uU3BVfNu5lZE840IUk07S6O9nHDb/TvxNsQizEuyx7urvSD41KN5nBqybUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rn3HpoyNFxDFWcaa9J8PQ6XGMfOEyIfdKE370CbOQ8=;
	b=KRgU+Wq39QxDEkOgqmOqhT8bDDAKa6Z2nzNhBpCVTfbf6UjAa+q8DOFTviaKuKWiM160dg
	TPvl0E/qaj76r2AQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Shrink the size of the recursion counter.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-5-bigeasy@linutronix.de>
References: <20240704170424.1466941-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531830.2215.8399866231682397481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5af42f928f3ac555c228740fb4a92d05b19fdd49
Gitweb:        https://git.kernel.org/tip/5af42f928f3ac555c228740fb4a92d05b19fdd49
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:35 +02:00

perf: Shrink the size of the recursion counter.

There are four recursion counter, one for each context. The type of the
counter is `int' but the counter is used as `bool' since it is only
incremented if zero.
The main goal here is to shrink the whole struct into 32bit int which
can later be added task_struct into an existing hole.

Reduce the type of the recursion counter to an unsigned char, keep the
increment/ decrement operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20240704170424.1466941-5-bigeasy@linutronix.de
---
 kernel/events/callchain.c | 2 +-
 kernel/events/core.c      | 2 +-
 kernel/events/internal.h  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be8..ad57944 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -29,7 +29,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
 				 sysctl_perf_event_max_contexts_per_stack));
 }
 
-static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
+static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
 static struct callchain_cpus_entries *callchain_cpus_entries;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 73e1b02..53e2750 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9765,7 +9765,7 @@ struct swevent_htable {
 	int				hlist_refcount;
 
 	/* Recursion avoidance in each contexts */
-	int				recursion[PERF_NR_CONTEXTS];
+	u8				recursion[PERF_NR_CONTEXTS];
 };
 
 static DEFINE_PER_CPU(struct swevent_htable, swevent_htable);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 386d21c..7f06b79 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -208,7 +208,7 @@ arch_perf_out_copy_user(void *dst, const void *src, unsigned long n)
 
 DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
-static inline int get_recursion_context(int *recursion)
+static inline int get_recursion_context(u8 *recursion)
 {
 	unsigned char rctx = interrupt_context_level();
 
@@ -221,7 +221,7 @@ static inline int get_recursion_context(int *recursion)
 	return rctx;
 }
 
-static inline void put_recursion_context(int *recursion, int rctx)
+static inline void put_recursion_context(u8 *recursion, int rctx)
 {
 	barrier();
 	recursion[rctx]--;

