Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70B343E1B2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJ1NMw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhJ1NMu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 09:12:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF9C061243;
        Thu, 28 Oct 2021 06:10:22 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:10:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635426620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbi2dzPu69+QXpi73WPp2tPeLJWNMGXAvEEKvkp0GbY=;
        b=m6rUo5Nc7vcTqXKr8TOxOsNP9Lj3lIsVijeg0B728MIW06HmTf12noLVrz/PyW38hj1mJU
        sjmHuU0lbgw3N3Hv04rtvKfkd6U4Nhjmq/vfOa9TiitbRuXO4spRbPw58kYjMw2pL+6ply
        ZObysaqvIJkU6gpf0mGtfXc7Ze0mSYSZyTjbYWvYcvj2zvqpqRLbZ1NE97cfBXLQkG11as
        EehYHuN+ukJ1/YyG/AHXJwjo5jGdIc76ZuYsvA0KoKn7UtGGBeysLx9hBuEUWAD5tCdfU3
        nIYBF4Tda/AnL9rt7rv0KlujaREwf3CU5WspDbvbSGBwh8B4fR20FKWpl5YaDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635426620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbi2dzPu69+QXpi73WPp2tPeLJWNMGXAvEEKvkp0GbY=;
        b=/5IGN8xFLVUG2RBc9IZTDShA7doPF9F4bhBRjalNeVGT9bu7I2liqTS3OBW/4sksYL4IY0
        wz2iZPLyX4M0FhAQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/amx: Add context switch test
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026122525.6EFD5758@davehans-spike.ostc.intel.com>
References: <20211026122525.6EFD5758@davehans-spike.ostc.intel.com>
MIME-Version: 1.0
Message-ID: <163542661955.626.8051866044257959295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     101c669d165d341b8c35424eb3878138044394ef
Gitweb:        https://git.kernel.org/tip/101c669d165d341b8c35424eb3878138044394ef
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 26 Oct 2021 05:25:25 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Oct 2021 14:35:27 +02:00

selftests/x86/amx: Add context switch test

XSAVE state is thread-local.  The kernel switches between thread
state at context switch time.  Generally, running a selftest for
a while will naturally expose it to some context switching and
and will test the XSAVE code.

Instead of just hoping that the tests get context-switched at
random times, force context-switches on purpose.  Spawn off a few
userspace threads and force context-switches between them.
Ensure that the kernel correctly context switches each thread's
unique AMX state.

 [ dhansen: bunches of cleanups ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211026122525.6EFD5758@davehans-spike.ostc.intel.com
---
 tools/testing/selftests/x86/amx.c | 160 ++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index ce012ad..3615ef4 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 #include <err.h>
 #include <errno.h>
+#include <pthread.h>
 #include <setjmp.h>
 #include <stdio.h>
 #include <string.h>
@@ -10,8 +11,6 @@
 #include <unistd.h>
 #include <x86intrin.h>
 
-#include <linux/futex.h>
-
 #include <sys/auxv.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
@@ -259,7 +258,6 @@ void sig_print(char *msg)
 
 static volatile bool noperm_signaled;
 static int noperm_errs;
-
 /*
  * Signal handler for when AMX is used but
  * permission has not been obtained.
@@ -674,6 +672,158 @@ static void test_fork(void)
 	_exit(0);
 }
 
+/* Context switching test */
+
+static struct _ctxtswtest_cfg {
+	unsigned int iterations;
+	unsigned int num_threads;
+} ctxtswtest_config;
+
+struct futex_info {
+	pthread_t thread;
+	int nr;
+	pthread_mutex_t mutex;
+	struct futex_info *next;
+};
+
+static void *check_tiledata(void *info)
+{
+	struct futex_info *finfo = (struct futex_info *)info;
+	struct xsave_buffer *xbuf;
+	int i;
+
+	xbuf = alloc_xbuf();
+	if (!xbuf)
+		fatal_error("unable to allocate XSAVE buffer");
+
+	/*
+	 * Load random data into 'xbuf' and then restore
+	 * it to the tile registers themselves.
+	 */
+	load_rand_tiledata(xbuf);
+	for (i = 0; i < ctxtswtest_config.iterations; i++) {
+		pthread_mutex_lock(&finfo->mutex);
+
+		/*
+		 * Ensure the register values have not
+		 * diverged from those recorded in 'xbuf'.
+		 */
+		validate_tiledata_regs_same(xbuf);
+
+		/* Load new, random values into xbuf and registers */
+		load_rand_tiledata(xbuf);
+
+		/*
+		 * The last thread's last unlock will be for
+		 * thread 0's mutex.  However, thread 0 will
+		 * have already exited the loop and the mutex
+		 * will already be unlocked.
+		 *
+		 * Because this is not an ERRORCHECK mutex,
+		 * that inconsistency will be silently ignored.
+		 */
+		pthread_mutex_unlock(&finfo->next->mutex);
+	}
+
+	free(xbuf);
+	/*
+	 * Return this thread's finfo, which is
+	 * a unique value for this thread.
+	 */
+	return finfo;
+}
+
+static int create_threads(int num, struct futex_info *finfo)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		int next_nr;
+
+		finfo[i].nr = i;
+		/*
+		 * Thread 'i' will wait on this mutex to
+		 * be unlocked.  Lock it immediately after
+		 * initialization:
+		 */
+		pthread_mutex_init(&finfo[i].mutex, NULL);
+		pthread_mutex_lock(&finfo[i].mutex);
+
+		next_nr = (i + 1) % num;
+		finfo[i].next = &finfo[next_nr];
+
+		if (pthread_create(&finfo[i].thread, NULL, check_tiledata, &finfo[i]))
+			fatal_error("pthread_create()");
+	}
+	return 0;
+}
+
+static void affinitize_cpu0(void)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
+		fatal_error("sched_setaffinity to CPU 0");
+}
+
+static void test_context_switch(void)
+{
+	struct futex_info *finfo;
+	int i;
+
+	/* Affinitize to one CPU to force context switches */
+	affinitize_cpu0();
+
+	req_xtiledata_perm();
+
+	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\n",
+	       ctxtswtest_config.iterations,
+	       ctxtswtest_config.num_threads);
+
+
+	finfo = malloc(sizeof(*finfo) * ctxtswtest_config.num_threads);
+	if (!finfo)
+		fatal_error("malloc()");
+
+	create_threads(ctxtswtest_config.num_threads, finfo);
+
+	/*
+	 * This thread wakes up thread 0
+	 * Thread 0 will wake up 1
+	 * Thread 1 will wake up 2
+	 * ...
+	 * the last thread will wake up 0
+	 *
+	 * ... this will repeat for the configured
+	 * number of iterations.
+	 */
+	pthread_mutex_unlock(&finfo[0].mutex);
+
+	/* Wait for all the threads to finish: */
+	for (i = 0; i < ctxtswtest_config.num_threads; i++) {
+		void *thread_retval;
+		int rc;
+
+		rc = pthread_join(finfo[i].thread, &thread_retval);
+
+		if (rc)
+			fatal_error("pthread_join() failed for thread %d err: %d\n",
+					i, rc);
+
+		if (thread_retval != &finfo[i])
+			fatal_error("unexpected thread retval for thread %d: %p\n",
+					i, thread_retval);
+
+	}
+
+	printf("[OK]\tNo incorrect case was found.\n");
+
+	free(finfo);
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -690,6 +840,10 @@ int main(void)
 
 	test_fork();
 
+	ctxtswtest_config.iterations = 10;
+	ctxtswtest_config.num_threads = 5;
+	test_context_switch();
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
