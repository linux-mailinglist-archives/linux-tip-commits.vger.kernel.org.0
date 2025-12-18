Return-Path: <linux-tip-commits+bounces-7763-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18926CCB42E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A21F430473FC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929B3328ED;
	Thu, 18 Dec 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IUy1a/Xq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxHkoJ4V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E62F9D82;
	Thu, 18 Dec 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051511; cv=none; b=DWk/G84UGX0b05tsRes18rvgRGBJjr8Ye3XAqQZA+ClK6pcH6gi65oY2nzssuOzZOlIiK7VlB+dG14gmsB3ojM0UB7Df3sFkzMVRhc/Oye25/1H1C1SH0W2tbhAiW33TDiZY85UBz7BwJP5ejgahR8fBQxlhnM9gENKhsD5Ygzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051511; c=relaxed/simple;
	bh=4/HxQ9Slmays/OsnxlS1l8V0CIsMVBPDy4E6P7il0PU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eBXsFk+hsF+++fP3lvSONTjRyC8H0VCL8yRtThXnyWOxCPeN3iIpxCDOht6aeA9kL4gzk8n5mbyWZZ03RDGZ+D5Lw63467AssNDWmSCp+BAnQPQiv0P8xRpN0zSwXSgwIU9OXFoANRMZsGwRX3yg2BpxpvAn5jXkO5PMse7a+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IUy1a/Xq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxHkoJ4V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 09:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766051508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bj50p30jaMbW7svJKD22xsnzqBUBiP5riglFoNlLYI=;
	b=IUy1a/Xq6znWAPbKYkjZTs89M1wJmF9GKTH8hy5y3qHzMiBv/usCp7CT80jP7l1zUtrHMr
	43m1a5+XkaP9hbF74waZ1+6ZU7w/fqPFpiDfTbDtxBILCSi44A90mVGi1S0wu5DdyjxcEi
	PDOeEblNEH5GBOwotMBKZH1SI7ST50JP/Xw1FgbxjBPOhpgLcqamN0y8fFtSN99lWjdgL4
	3iaY3YXHp8iLAaD49AREpnnIsW8GwN1V4zLxDu2WWgckA6SpgM8oMwIUtymXAsfa6SDwMT
	knszYmBoX8qGo5yaPQQqQWUlPF7+ZoMlHFeIsNv06clhd6VklmAPeOCIfv5Log==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766051508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bj50p30jaMbW7svJKD22xsnzqBUBiP5riglFoNlLYI=;
	b=TxHkoJ4V2O+wyh7sba1Azwxkdp+lJsNSV+P0n0xxcT13KZdYh+xynNJihuHb/kenBeXmFO
	1e4RvinC2rN4ohBw==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] test-ww_mutex: Extend ww_mutex tests to test both
 classes of ww_mutexes
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205013515.759030-2-jstultz@google.com>
References: <20251205013515.759030-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176605150725.510.13743095736614279798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     34d80c93a5bbf38938e8c215ec6c938807edeaf0
Gitweb:        https://git.kernel.org/tip/34d80c93a5bbf38938e8c215ec6c938807e=
deaf0
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 05 Dec 2025 01:35:09=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Dec 2025 10:45:23 +01:00

test-ww_mutex: Extend ww_mutex tests to test both classes of ww_mutexes

Currently the test-ww_mutex tool only utilizes the wait-die
class of ww_mutexes, and thus isn't very helpful in exercising
the wait-wound class of ww_mutexes.

So extend the test to exercise both classes of ww_mutexes for
all of the subtests.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251205013515.759030-2-jstultz@google.com
---
 kernel/locking/test-ww_mutex.c | 114 ++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 41 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index bcb1b9f..d27aaaa 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -13,7 +13,8 @@
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
=20
-static DEFINE_WD_CLASS(ww_class);
+static DEFINE_WD_CLASS(wd_class);
+static DEFINE_WW_CLASS(ww_class);
 struct workqueue_struct *wq;
=20
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
@@ -54,16 +55,16 @@ static void test_mutex_work(struct work_struct *work)
 	ww_mutex_unlock(&mtx->mutex);
 }
=20
-static int __test_mutex(unsigned int flags)
+static int __test_mutex(struct ww_class *class, unsigned int flags)
 {
 #define TIMEOUT (HZ / 16)
 	struct test_mutex mtx;
 	struct ww_acquire_ctx ctx;
 	int ret;
=20
-	ww_mutex_init(&mtx.mutex, &ww_class);
+	ww_mutex_init(&mtx.mutex, class);
 	if (flags & TEST_MTX_CTX)
-		ww_acquire_init(&ctx, &ww_class);
+		ww_acquire_init(&ctx, class);
=20
 	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
 	init_completion(&mtx.ready);
@@ -106,13 +107,13 @@ static int __test_mutex(unsigned int flags)
 #undef TIMEOUT
 }
=20
-static int test_mutex(void)
+static int test_mutex(struct ww_class *class)
 {
 	int ret;
 	int i;
=20
 	for (i =3D 0; i < __TEST_MTX_LAST; i++) {
-		ret =3D __test_mutex(i);
+		ret =3D __test_mutex(class, i);
 		if (ret)
 			return ret;
 	}
@@ -120,15 +121,15 @@ static int test_mutex(void)
 	return 0;
 }
=20
-static int test_aa(bool trylock)
+static int test_aa(struct ww_class *class, bool trylock)
 {
 	struct ww_mutex mutex;
 	struct ww_acquire_ctx ctx;
 	int ret;
 	const char *from =3D trylock ? "trylock" : "lock";
=20
-	ww_mutex_init(&mutex, &ww_class);
-	ww_acquire_init(&ctx, &ww_class);
+	ww_mutex_init(&mutex, class);
+	ww_acquire_init(&ctx, class);
=20
 	if (!trylock) {
 		ret =3D ww_mutex_lock(&mutex, &ctx);
@@ -177,6 +178,7 @@ out:
=20
 struct test_abba {
 	struct work_struct work;
+	struct ww_class *class;
 	struct ww_mutex a_mutex;
 	struct ww_mutex b_mutex;
 	struct completion a_ready;
@@ -191,7 +193,7 @@ static void test_abba_work(struct work_struct *work)
 	struct ww_acquire_ctx ctx;
 	int err;
=20
-	ww_acquire_init_noinject(&ctx, &ww_class);
+	ww_acquire_init_noinject(&ctx, abba->class);
 	if (!abba->trylock)
 		ww_mutex_lock(&abba->b_mutex, &ctx);
 	else
@@ -217,23 +219,24 @@ static void test_abba_work(struct work_struct *work)
 	abba->result =3D err;
 }
=20
-static int test_abba(bool trylock, bool resolve)
+static int test_abba(struct ww_class *class, bool trylock, bool resolve)
 {
 	struct test_abba abba;
 	struct ww_acquire_ctx ctx;
 	int err, ret;
=20
-	ww_mutex_init(&abba.a_mutex, &ww_class);
-	ww_mutex_init(&abba.b_mutex, &ww_class);
+	ww_mutex_init(&abba.a_mutex, class);
+	ww_mutex_init(&abba.b_mutex, class);
 	INIT_WORK_ONSTACK(&abba.work, test_abba_work);
 	init_completion(&abba.a_ready);
 	init_completion(&abba.b_ready);
+	abba.class =3D class;
 	abba.trylock =3D trylock;
 	abba.resolve =3D resolve;
=20
 	schedule_work(&abba.work);
=20
-	ww_acquire_init_noinject(&ctx, &ww_class);
+	ww_acquire_init_noinject(&ctx, class);
 	if (!trylock)
 		ww_mutex_lock(&abba.a_mutex, &ctx);
 	else
@@ -278,6 +281,7 @@ static int test_abba(bool trylock, bool resolve)
=20
 struct test_cycle {
 	struct work_struct work;
+	struct ww_class *class;
 	struct ww_mutex a_mutex;
 	struct ww_mutex *b_mutex;
 	struct completion *a_signal;
@@ -291,7 +295,7 @@ static void test_cycle_work(struct work_struct *work)
 	struct ww_acquire_ctx ctx;
 	int err, erra =3D 0;
=20
-	ww_acquire_init_noinject(&ctx, &ww_class);
+	ww_acquire_init_noinject(&ctx, cycle->class);
 	ww_mutex_lock(&cycle->a_mutex, &ctx);
=20
 	complete(cycle->a_signal);
@@ -314,7 +318,7 @@ static void test_cycle_work(struct work_struct *work)
 	cycle->result =3D err ?: erra;
 }
=20
-static int __test_cycle(unsigned int nthreads)
+static int __test_cycle(struct ww_class *class, unsigned int nthreads)
 {
 	struct test_cycle *cycles;
 	unsigned int n, last =3D nthreads - 1;
@@ -327,7 +331,8 @@ static int __test_cycle(unsigned int nthreads)
 	for (n =3D 0; n < nthreads; n++) {
 		struct test_cycle *cycle =3D &cycles[n];
=20
-		ww_mutex_init(&cycle->a_mutex, &ww_class);
+		cycle->class =3D class;
+		ww_mutex_init(&cycle->a_mutex, class);
 		if (n =3D=3D last)
 			cycle->b_mutex =3D &cycles[0].a_mutex;
 		else
@@ -367,13 +372,13 @@ static int __test_cycle(unsigned int nthreads)
 	return ret;
 }
=20
-static int test_cycle(unsigned int ncpus)
+static int test_cycle(struct ww_class *class, unsigned int ncpus)
 {
 	unsigned int n;
 	int ret;
=20
 	for (n =3D 2; n <=3D ncpus + 1; n++) {
-		ret =3D __test_cycle(n);
+		ret =3D __test_cycle(class, n);
 		if (ret)
 			return ret;
 	}
@@ -384,6 +389,7 @@ static int test_cycle(unsigned int ncpus)
 struct stress {
 	struct work_struct work;
 	struct ww_mutex *locks;
+	struct ww_class *class;
 	unsigned long timeout;
 	int nlocks;
 };
@@ -443,7 +449,7 @@ static void stress_inorder_work(struct work_struct *work)
 		int contended =3D -1;
 		int n, err;
=20
-		ww_acquire_init(&ctx, &ww_class);
+		ww_acquire_init(&ctx, stress->class);
 retry:
 		err =3D 0;
 		for (n =3D 0; n < nlocks; n++) {
@@ -511,7 +517,7 @@ static void stress_reorder_work(struct work_struct *work)
 	order =3D NULL;
=20
 	do {
-		ww_acquire_init(&ctx, &ww_class);
+		ww_acquire_init(&ctx, stress->class);
=20
 		list_for_each_entry(ll, &locks, link) {
 			err =3D ww_mutex_lock(ll->lock, &ctx);
@@ -570,7 +576,7 @@ static void stress_one_work(struct work_struct *work)
 #define STRESS_ONE BIT(2)
 #define STRESS_ALL (STRESS_INORDER | STRESS_REORDER | STRESS_ONE)
=20
-static int stress(int nlocks, int nthreads, unsigned int flags)
+static int stress(struct ww_class *class, int nlocks, int nthreads, unsigned=
 int flags)
 {
 	struct ww_mutex *locks;
 	struct stress *stress_array;
@@ -588,7 +594,7 @@ static int stress(int nlocks, int nthreads, unsigned int =
flags)
 	}
=20
 	for (n =3D 0; n < nlocks; n++)
-		ww_mutex_init(&locks[n], &ww_class);
+		ww_mutex_init(&locks[n], class);
=20
 	count =3D 0;
 	for (n =3D 0; nthreads; n++) {
@@ -617,6 +623,7 @@ static int stress(int nlocks, int nthreads, unsigned int =
flags)
 		stress =3D &stress_array[count++];
=20
 		INIT_WORK(&stress->work, fn);
+		stress->class =3D class;
 		stress->locks =3D locks;
 		stress->nlocks =3D nlocks;
 		stress->timeout =3D jiffies + 2*HZ;
@@ -635,57 +642,82 @@ static int stress(int nlocks, int nthreads, unsigned in=
t flags)
 	return 0;
 }
=20
-static int __init test_ww_mutex_init(void)
+static int __init run_tests(struct ww_class *class)
 {
 	int ncpus =3D num_online_cpus();
 	int ret, i;
=20
-	printk(KERN_INFO "Beginning ww mutex selftests\n");
-
-	prandom_seed_state(&rng, get_random_u64());
-
-	wq =3D alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
-	if (!wq)
-		return -ENOMEM;
-
-	ret =3D test_mutex();
+	ret =3D test_mutex(class);
 	if (ret)
 		return ret;
=20
-	ret =3D test_aa(false);
+	ret =3D test_aa(class, false);
 	if (ret)
 		return ret;
=20
-	ret =3D test_aa(true);
+	ret =3D test_aa(class, true);
 	if (ret)
 		return ret;
=20
 	for (i =3D 0; i < 4; i++) {
-		ret =3D test_abba(i & 1, i & 2);
+		ret =3D test_abba(class, i & 1, i & 2);
 		if (ret)
 			return ret;
 	}
=20
-	ret =3D test_cycle(ncpus);
+	ret =3D test_cycle(class, ncpus);
 	if (ret)
 		return ret;
=20
-	ret =3D stress(16, 2*ncpus, STRESS_INORDER);
+	ret =3D stress(class, 16, 2 * ncpus, STRESS_INORDER);
 	if (ret)
 		return ret;
=20
-	ret =3D stress(16, 2*ncpus, STRESS_REORDER);
+	ret =3D stress(class, 16, 2 * ncpus, STRESS_REORDER);
 	if (ret)
 		return ret;
=20
-	ret =3D stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
+	ret =3D stress(class, 2046, hweight32(STRESS_ALL) * ncpus, STRESS_ALL);
 	if (ret)
 		return ret;
=20
-	printk(KERN_INFO "All ww mutex selftests passed\n");
 	return 0;
 }
=20
+static int __init run_test_classes(void)
+{
+	int ret;
+
+	pr_info("Beginning ww (wound) mutex selftests\n");
+
+	ret =3D run_tests(&ww_class);
+	if (ret)
+		return ret;
+
+	pr_info("Beginning ww (die) mutex selftests\n");
+	ret =3D run_tests(&wd_class);
+	if (ret)
+		return ret;
+
+	pr_info("All ww mutex selftests passed\n");
+	return 0;
+}
+
+static int __init test_ww_mutex_init(void)
+{
+	int ret;
+
+	prandom_seed_state(&rng, get_random_u64());
+
+	wq =3D alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
+	if (!wq)
+		return -ENOMEM;
+
+	ret =3D run_test_classes();
+
+	return ret;
+}
+
 static void __exit test_ww_mutex_exit(void)
 {
 	destroy_workqueue(wq);

