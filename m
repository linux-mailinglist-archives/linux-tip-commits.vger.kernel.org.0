Return-Path: <linux-tip-commits+bounces-8098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIf/Gk77cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F6653B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1518B628087
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A13A1E6E;
	Thu, 22 Jan 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gWk/f8JO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dO2Z+Lvk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E63A0B0D;
	Thu, 22 Jan 2026 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076962; cv=none; b=rLXB0/gavgLGVlcWkA7L9wTUhnnYGLczMBbFiKL9kN1sdIsWZAI9h1sE8O9pjV2ZsZIFt/Odx9/gDxtz9ocYWFhbMFhF1GmrPqW+aX1sD5FYsdX/QaFH6IGMd9G95owNHTlX6IRIBZIybU/bMJFE80Nh9gYhUy204MXSUaQgLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076962; c=relaxed/simple;
	bh=DjziZnnfuIgrtvYsPLQ+m9xh6rOKT6c9hRcnAovqhc4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D5ocbhBmmqh0Q5m7nMxmOydj8qPdK78cl1FcKZuwHSmtp5Fyv/+Hdb9ToZnqS1hoW53/FUGhdaFsWpZFA8XsSbMns3I7Ym/CpoNVJhqLHeKjDb32m5GgNSoM1zOBUES7N/Cf4kNe7kwYl+Z6gaIu3CbqBo+83KCzk0coW8mEvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gWk/f8JO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dO2Z+Lvk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/P6uBlmmht9Hosz1R36pdXDI6X2uXlhmhQtLtWY2Z4=;
	b=gWk/f8JO5Gy4/MB+7a0jM6SAxvyHcI1G3Bic1kRidAKXAAEefk5hDu2SbZXrydIvvaQJqK
	6JjBww5cjuyKJdtKN7Qzxxud6cggbfEv1T8syRXAMOQpftONpe6xagGSqgcwYalEwkdBk9
	g6Ca41vIFHN8+bgnhdzBZ7OW+Z2gIWIhabNHrnVJg6/RxwleaEvnjStHdf5d1UZlMIrJ/5
	6zsIqDhPweZ12/38WvMCTO/ZxmiehYEmzXr1P2QjONGjBVHC1FAZSLqGV3JLiH1aEQkvj3
	xBjJOUUlXcxe0RMzRU/2+PzjUpxV7CYrzplz9+FoXLNOd9xUVrSJgZnHyZm8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/P6uBlmmht9Hosz1R36pdXDI6X2uXlhmhQtLtWY2Z4=;
	b=dO2Z+LvkDp+DJPM8VdBzXBa4pY2tht30dpuxDXJw6fNgUIHTCNpg7TPWi0lF0Cw/ABFNn8
	joDHMaYNTvgqCGAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Implement time slice extension test
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155709.320325431@linutronix.de>
References: <20251215155709.320325431@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907694087.510.1167753922420408705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8098-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,infradead.org:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,msgid.link:url,librseq.so:url,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 3B2F6653B1
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     830969e7821af377bdc1bb016929ff28c78490e8
Gitweb:        https://git.kernel.org/tip/830969e7821af377bdc1bb016929ff28c78=
490e8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:19 +01:00

selftests/rseq: Implement time slice extension test

Provide an initial test case to evaluate the functionality. This needs to be
extended to cover the ABI violations and expose the race condition between
observing granted and arriving in rseq_slice_yield().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155709.320325431@linutronix.de
---
 tools/testing/selftests/rseq/.gitignore   |   1 +-
 tools/testing/selftests/rseq/Makefile     |   5 +-
 tools/testing/selftests/rseq/rseq-abi.h   |  27 +++-
 tools/testing/selftests/rseq/slice_test.c | 219 +++++++++++++++++++++-
 4 files changed, 251 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/slice_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftest=
s/rseq/.gitignore
index 0fda241..ec01d16 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -10,3 +10,4 @@ param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
 syscall_errors_test
+slice_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/=
rseq/Makefile
index 0d0a5fa..4ef9082 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -17,7 +17,7 @@ OVERRIDE_TARGETS =3D 1
 TEST_GEN_PROGS =3D basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_=
test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
 		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test
+		syscall_errors_test slice_test
=20
 TEST_GEN_PROGS_EXTENDED =3D librseq.so
=20
@@ -59,3 +59,6 @@ $(OUTPUT)/param_test_mm_cid_compare_twice: param_test.c $(T=
EST_GEN_PROGS_EXTENDE
 $(OUTPUT)/syscall_errors_test: syscall_errors_test.c $(TEST_GEN_PROGS_EXTEND=
ED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/slice_test: slice_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftest=
s/rseq/rseq-abi.h
index fb4ec8a..ecef315 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -53,6 +53,27 @@ struct rseq_abi_cs {
 	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
=20
+/**
+ * rseq_abi_slice_ctrl - Time slice extension control structure
+ * @all:	Compound value
+ * @request:	Request for a time slice extension
+ * @granted:	Granted time slice extension
+ *
+ * @request is set by user space and can be cleared by user space or kernel
+ * space.  @granted is set and cleared by the kernel and must only be read
+ * by user space.
+ */
+struct rseq_abi_slice_ctrl {
+	union {
+		__u32		all;
+		struct {
+			__u8	request;
+			__u8	granted;
+			__u16	__reserved;
+		};
+	};
+};
+
 /*
  * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line.
@@ -165,6 +186,12 @@ struct rseq_abi {
 	__u32 mm_cid;
=20
 	/*
+	 * Time slice extension control structure. CPU local updates from
+	 * kernel and user space.
+	 */
+	struct rseq_abi_slice_ctrl slice_ctrl;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
diff --git a/tools/testing/selftests/rseq/slice_test.c b/tools/testing/selfte=
sts/rseq/slice_test.c
new file mode 100644
index 0000000..357122d
--- /dev/null
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+#include "../kselftest_harness.h"
+
+#ifndef __NR_rseq_slice_yield
+# define __NR_rseq_slice_yield	471
+#endif
+
+#define BITS_PER_INT	32
+#define BITS_PER_BYTE	8
+
+#ifndef PR_RSEQ_SLICE_EXTENSION
+# define PR_RSEQ_SLICE_EXTENSION		79
+#  define PR_RSEQ_SLICE_EXTENSION_GET		1
+#  define PR_RSEQ_SLICE_EXTENSION_SET		2
+#  define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+#endif
+
+#ifndef RSEQ_SLICE_EXT_REQUEST_BIT
+# define RSEQ_SLICE_EXT_REQUEST_BIT	0
+# define RSEQ_SLICE_EXT_GRANTED_BIT	1
+#endif
+
+#ifndef asm_inline
+# define asm_inline	asm __inline
+#endif
+
+#define NSEC_PER_SEC	1000000000L
+#define NSEC_PER_USEC	      1000L
+
+struct noise_params {
+	int64_t	noise_nsecs;
+	int64_t	sleep_nsecs;
+	int64_t	run;
+};
+
+FIXTURE(slice_ext)
+{
+	pthread_t		noise_thread;
+	struct noise_params	noise_params;
+};
+
+FIXTURE_VARIANT(slice_ext)
+{
+	int64_t	total_nsecs;
+	int64_t	slice_nsecs;
+	int64_t	noise_nsecs;
+	int64_t	sleep_nsecs;
+	bool	no_yield;
+};
+
+FIXTURE_VARIANT_ADD(slice_ext, n2_2_50)
+{
+	.total_nsecs	=3D  5LL * NSEC_PER_SEC,
+	.slice_nsecs	=3D  2LL * NSEC_PER_USEC,
+	.noise_nsecs    =3D  2LL * NSEC_PER_USEC,
+	.sleep_nsecs	=3D 50LL * NSEC_PER_USEC,
+};
+
+FIXTURE_VARIANT_ADD(slice_ext, n50_2_50)
+{
+	.total_nsecs	=3D  5LL * NSEC_PER_SEC,
+	.slice_nsecs	=3D 50LL * NSEC_PER_USEC,
+	.noise_nsecs    =3D  2LL * NSEC_PER_USEC,
+	.sleep_nsecs	=3D 50LL * NSEC_PER_USEC,
+};
+
+FIXTURE_VARIANT_ADD(slice_ext, n2_2_50_no_yield)
+{
+	.total_nsecs	=3D  5LL * NSEC_PER_SEC,
+	.slice_nsecs	=3D  2LL * NSEC_PER_USEC,
+	.noise_nsecs    =3D  2LL * NSEC_PER_USEC,
+	.sleep_nsecs	=3D 50LL * NSEC_PER_USEC,
+	.no_yield	=3D true,
+};
+
+
+static inline bool elapsed(struct timespec *start, struct timespec *now,
+			   int64_t span)
+{
+	int64_t delta =3D now->tv_sec - start->tv_sec;
+
+	delta *=3D NSEC_PER_SEC;
+	delta +=3D now->tv_nsec - start->tv_nsec;
+	return delta >=3D span;
+}
+
+static void *noise_thread(void *arg)
+{
+	struct noise_params *p =3D arg;
+
+	while (RSEQ_READ_ONCE(p->run)) {
+		struct timespec ts_start, ts_now;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_start);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_start, &ts_now, p->noise_nsecs));
+
+		ts_start.tv_sec =3D 0;
+		ts_start.tv_nsec =3D p->sleep_nsecs;
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &ts_start, NULL);
+	}
+	return NULL;
+}
+
+FIXTURE_SETUP(slice_ext)
+{
+	cpu_set_t affinity;
+
+	ASSERT_EQ(sched_getaffinity(0, sizeof(affinity), &affinity), 0);
+
+	/* Pin it on a single CPU. Avoid CPU 0 */
+	for (int i =3D 1; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &affinity))
+			continue;
+
+		CPU_ZERO(&affinity);
+		CPU_SET(i, &affinity);
+		ASSERT_EQ(sched_setaffinity(0, sizeof(affinity), &affinity), 0);
+		break;
+	}
+
+	ASSERT_EQ(rseq_register_current_thread(), 0);
+
+	ASSERT_EQ(prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+			PR_RSEQ_SLICE_EXT_ENABLE, 0, 0), 0);
+
+	self->noise_params.noise_nsecs =3D variant->noise_nsecs;
+	self->noise_params.sleep_nsecs =3D variant->sleep_nsecs;
+	self->noise_params.run =3D 1;
+
+	ASSERT_EQ(pthread_create(&self->noise_thread, NULL, noise_thread, &self->no=
ise_params), 0);
+}
+
+FIXTURE_TEARDOWN(slice_ext)
+{
+	self->noise_params.run =3D 0;
+	pthread_join(self->noise_thread, NULL);
+}
+
+TEST_F(slice_ext, slice_test)
+{
+	unsigned long success =3D 0, yielded =3D 0, scheduled =3D 0, raced =3D 0;
+	unsigned long total =3D 0, aborted =3D 0;
+	struct rseq_abi *rs =3D rseq_get_abi();
+	struct timespec ts_start, ts_now;
+
+	ASSERT_NE(rs, NULL);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	do {
+		struct timespec ts_cs;
+		bool req =3D false;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_cs);
+
+		total++;
+		RSEQ_WRITE_ONCE(rs->slice_ctrl.request, 1);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_cs, &ts_now, variant->slice_nsecs));
+
+		/*
+		 * request can be cleared unconditionally, but for making
+		 * the stats work this is actually checking it first
+		 */
+		if (RSEQ_READ_ONCE(rs->slice_ctrl.request)) {
+			RSEQ_WRITE_ONCE(rs->slice_ctrl.request, 0);
+			/* Race between check and clear! */
+			req =3D true;
+			success++;
+		}
+
+		if (RSEQ_READ_ONCE(rs->slice_ctrl.granted)) {
+			/* The above raced against a late grant */
+			if (req)
+				success--;
+			if (variant->no_yield) {
+				syscall(__NR_getpid);
+				aborted++;
+			} else {
+				yielded++;
+				if (!syscall(__NR_rseq_slice_yield))
+					raced++;
+			}
+		} else {
+			if (!req)
+				scheduled++;
+		}
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_now);
+	} while (!elapsed(&ts_start, &ts_now, variant->total_nsecs));
+
+	printf("# Total     %12ld\n", total);
+	printf("# Success   %12ld\n", success);
+	printf("# Yielded   %12ld\n", yielded);
+	printf("# Aborted   %12ld\n", aborted);
+	printf("# Scheduled %12ld\n", scheduled);
+	printf("# Raced     %12ld\n", raced);
+}
+
+TEST_HARNESS_MAIN

