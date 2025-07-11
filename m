Return-Path: <linux-tip-commits+bounces-6097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17AB023BD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D428EA6839A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31C2F4320;
	Fri, 11 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZC1LZEy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wC2dAifZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC02F2352;
	Fri, 11 Jul 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258818; cv=none; b=gXFeLI6t5WPAjehXlTLD7e7koPsH0AiDydSNYIqfQD3mImpvoR8h2kcd/Tqu+3ZY1WoXYqPD+u7gzU9P4fUHrszId8+r0p3pIDm6m3cpuofRY6ol1Ds23XeYjza8oEs6q2WCQJmFQgwUNcAP616r2LZ9MLMnuOzDQLOKS26Ry+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258818; c=relaxed/simple;
	bh=5I/kMNywkNnQWt/bvrHmxB5n1jC/mEoiOIo/Fv5jrUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aYaVLv3GlgNJjLGuC4AX+jQdzk1lzOmrlPcA4/vdrIzmUcwIWzfqlZIKkpDQGGvPfLuZYZQj8hFlxlqQNUHS4i7QeJkyOuDwCfbi/+UvqOfWh5tSTQa3CAsIgcaKH2CT3CQqFxSVnOqgSt191mE8LDc8DASCZ82NyIwPyQCdQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZC1LZEy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wC2dAifZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 18:33:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752258814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRDxd/Y0TcWpRtX6xEZlReXGHfvk8BI3RIcGSWJBFQA=;
	b=AZC1LZEymDN+dvVr0RdBVsGVl6OlhKq1BFcjVKtOpE/AOvcVLBdqrq7IfLdGCrzNBITt4b
	Rr3DwV1f8ym08dWNQChR4PEnf27bnu4ljmHdTgAFepWwegFexC5YoJIBCaGwQFLMMiseRz
	0dNTDCm4UmgnyXXUvhcQww522llOFgbRUr5tPZ00Otad7k8W05mzBD+79IJuIFWywmJG+Z
	dq3XH0+HG5TgKFGgHFBd6vQHBFLwQpRBl+WOp0LINOpmbK7P7c1Kew5neToU+u/NGOpSCf
	n2bcrbwI/kceF91g3HXRgLSeEnxbrqnMGGmK/CEY40L/dt6+cIW6QHXoNS4vjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752258814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRDxd/Y0TcWpRtX6xEZlReXGHfvk8BI3RIcGSWJBFQA=;
	b=wC2dAifZwrR8g2MZVKcLKyURf49MdUgszIrjdqpDgEusg/nW5ay1Pz90JjiWidRXDtWOn+
	E0W6umxu3wYT1fDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] perf bench futex: Remove support for IMMUTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710110011.384614-7-bigeasy@linutronix.de>
References: <20250710110011.384614-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225881281.406.10995341488572183084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     7497e947bc1d3f761b46c2105c8ae37af98add54
Gitweb:        https://git.kernel.org/tip/7497e947bc1d3f761b46c2105c8ae37af98add54
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 10 Jul 2025 13:00:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jul 2025 16:02:01 +02:00

perf bench futex: Remove support for IMMUTABLE

It has been decided to remove the support IMMUTABLE futex.
perf bench was one of the eary users for testing purposes. Now that the
API is removed before it could be used in an official release, remove
the bits from perf, too.

Remove Remove support for IMMUTABLE futex.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250710110011.384614-7-bigeasy@linutronix.de
---
 tools/include/uapi/linux/prctl.h                   |  2 +-
 tools/perf/bench/futex-hash.c                      |  1 +-
 tools/perf/bench/futex-lock-pi.c                   |  1 +-
 tools/perf/bench/futex-requeue.c                   |  1 +-
 tools/perf/bench/futex-wake-parallel.c             |  1 +-
 tools/perf/bench/futex-wake.c                      |  1 +-
 tools/perf/bench/futex.c                           | 21 +++----------
 tools/perf/bench/futex.h                           |  1 +-
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |  2 +-
 9 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 43dec6e..3b93fb9 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index d2d6d7f..7e29f04 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -56,7 +56,6 @@ static struct bench_futex_parameters params = {
 
 static const struct option options[] = {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes per threads"),
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 5144a15..40640b6 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -47,7 +47,6 @@ static struct bench_futex_parameters params = {
 
 static const struct option options[] = {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)"),
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index a2f91ee..0748b0f 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -52,7 +52,6 @@ static struct bench_futex_parameters params = {
 
 static const struct option options[] = {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of threads to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index ee66482..6aede7c 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -63,7 +63,6 @@ static struct bench_futex_parameters params = {
 
 static const struct option options[] = {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking threads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 8d6107f..a31fc15 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -52,7 +52,6 @@ static struct bench_futex_parameters params = {
 
 static const struct option options[] = {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buckets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash buckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads to wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 4c4fee1..1481196 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -9,21 +9,17 @@
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH                   78
 # define PR_FUTEX_HASH_SET_SLOTS        1
-# define FH_FLAG_IMMUTABLE              (1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS        2
-# define PR_FUTEX_HASH_GET_IMMUTABLE    3
 #endif // PR_FUTEX_HASH
 
 void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 {
-	unsigned long flags;
 	int ret;
 
 	if (params->nbuckets < 0)
 		return;
 
-	flags = params->buckets_immutable ? FH_FLAG_IMMUTABLE : 0;
-	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, flags);
+	ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, 0);
 	if (ret) {
 		printf("Requesting %d hash buckets failed: %d/%m\n",
 		       params->nbuckets, ret);
@@ -47,18 +43,11 @@ void futex_print_nbuckets(struct bench_futex_parameters *params)
 			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
 			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
 		}
-		if (params->nbuckets == 0) {
+		if (params->nbuckets == 0)
 			ret = asprintf(&futex_hash_mode, "Futex hashing: global hash");
-		} else {
-			ret = prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
-			if (ret < 0) {
-				printf("Can't check if the hash is immutable: %m\n");
-				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
-			}
-			ret = asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets %s",
-				       params->nbuckets,
-				       ret == 1 ? "(immutable)" : "");
-		}
+		else
+			ret = asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets",
+				       params->nbuckets);
 	} else {
 		if (ret <= 0) {
 			ret = asprintf(&futex_hash_mode, "Futex hashing: global hash");
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 9c9a73f..dd295d2 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -26,7 +26,6 @@ struct bench_futex_parameters {
 	unsigned int nwakes;
 	unsigned int nrequeue;
 	int nbuckets;
-	bool buckets_immutable;
 };
 
 /**
diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 43dec6e..3b93fb9 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
 #endif /* _LINUX_PRCTL_H */

