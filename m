Return-Path: <linux-tip-commits+bounces-8193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDP5Nb7agWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:42 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEAD83D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1FD312F48B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36980335572;
	Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ragmAmpD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nilqb4QK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DC33438D;
	Tue,  3 Feb 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117529; cv=none; b=t5z41260j13wqZrbWlWXRLEFLagbZoVdo94uDMU/6AnHXjcVQnNqRCTlOVh9JzeXix2wd1F3GbQfw1PtQZN9aLeLXP57gPC1MMn9NMXAtD7Dk98w2yaDhS1Sl6FjPsi+3+fVy+pf1AOXF2t7ONdgjM1ftzymCo4/VmysP9SuYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117529; c=relaxed/simple;
	bh=sSB95Cnnu9E9/KCgOpzkdVHPG+cdrRmw1NKzAAsSqCM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jEBcQhsV1ZmjbGvUXCfNI10g/YcQTaK3WbbYzdZAdAKj/NOtm7S7BimuqXEvGvZMRy9PWyoq3XBVgVVi1QlzXjUOGQRU9x4LcvXeE9E8Jf7I/q8aJhSfmAUqNUNFGmoA72Daab0DDq+3HnbyQaXygq47Sr7QCc1ARtOrPkMQV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ragmAmpD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nilqb4QK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzBa4KHL/oAMdZu6ougt4ZaLvW9nTcdBwWl/Q00ouaY=;
	b=ragmAmpDXwQFP0IxepPmr6PHg5v3kwiT4+GysZ53iXcx9lhyAGRInF/sardmFFBUvE4p/W
	ucoB2fpuJrfnQW4ej3ZVczvDLGA/sa14SYaT0IVDY2zVCWtxEieV0VEePPX7QxsuTsKBn/
	EGXfQend2ruq/zpqdqGG1dQKj27OsJLXlE0CrebzngnVqEcFnqjIAgbveqDlEqVM8+eocz
	xdTK6sN6moYXLclh22YugvnWPanp5h9Reax01hKqh3NwhLlWqo2acSU/C13w7Kx2Pw1kw/
	D5I0TYsvAbAxXkTRW0lpp887kp+A7gZjhBiOVbxDWIE2EuaCEQjd3YdOvOZRLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzBa4KHL/oAMdZu6ougt4ZaLvW9nTcdBwWl/Q00ouaY=;
	b=nilqb4QKj5Zym0ht1ustM2IXNuzB/xtxeauhy7qHPrTry1BFq2lkMuA+A6HG++dWIyAj8j
	gGX8lrXORt2tXRBQ==
From: "tip-bot2 for Andrea Righi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] selftests/sched_ext: Add test for sched_ext dl_server
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Christian Loehle <christian.loehle@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260126100050.3854740-7-arighi@nvidia.com>
References: <20260126100050.3854740-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011751840.2495410.6970962358448666311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8193-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:email,vger.kernel.org:replyto,nvidia.com:email,linutronix.de:dkim,msgid.link:url,arm.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DDEAD83D8
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     be621a76341caa911ff98175114ff072618d7d4a
Gitweb:        https://git.kernel.org/tip/be621a76341caa911ff98175114ff072618=
d7d4a
Author:        Andrea Righi <arighi@nvidia.com>
AuthorDate:    Mon, 26 Jan 2026 10:59:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:18 +01:00

selftests/sched_ext: Add test for sched_ext dl_server

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-7-arighi@nvidia.com
---
 tools/testing/selftests/sched_ext/Makefile       |   1 +-
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 +-
 tools/testing/selftests/sched_ext/rt_stall.c     | 240 ++++++++++++++-
 3 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selft=
ests/sched_ext/Makefile
index 5fe45f9..c9255d1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -183,6 +183,7 @@ auto-test-targets :=3D			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
=20
 testcase-targets :=3D $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-=
targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing=
/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 0000000..8008677
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops =3D {
+	.exit			=3D (void *)rt_stall_exit,
+	.name			=3D "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/sel=
ftests/sched_ext/rt_stall.c
new file mode 100644
index 0000000..015200f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i =3D 0; i < 10000000UL; i++)
+			;
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) !=3D 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority =3D priority;
+	if (sched_setscheduler(0, policy, &param) !=3D 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file =3D fopen(path, "r");
+	if (file =3D=3D NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields =3D fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields !=3D 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time =3D utime + stime;
+	long ticks_per_second =3D sysconf(_SC_CLK_TCK);
+	float runtime_seconds =3D total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel =3D rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx =3D skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(bool is_ext)
+{
+	/*
+	 * We're expecting the EXT task to get around 5% of CPU time when
+	 * competing with the RT task (small 1% fluctuations are expected).
+	 *
+	 * However, the EXT task should get at least 4% of the CPU to prove
+	 * that the EXT deadline server is working correctly. A percentage
+	 * less than 4% indicates a bug where RT tasks can potentially
+	 * stall SCHED_EXT tasks, causing the test to fail.
+	 */
+	const float expected_min_ratio =3D 0.04; /* 4% */
+	const char *class_str =3D is_ext ? "EXT" : "FAIR";
+
+	float ext_runtime, rt_runtime, actual_ratio;
+	int ext_pid, rt_pid;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	ext_pid =3D fork();
+	if (ext_pid =3D=3D 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (ext_pid < 0) {
+		perror("fork task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid =3D fork();
+	if (rt_pid =3D=3D 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	ext_runtime =3D get_process_runtime(ext_pid);
+	if (ext_runtime =3D=3D -1)
+		ksft_exit_fail_msg("Error getting runtime for %s task (PID %d)\n",
+				   class_str, ext_pid);
+	ksft_print_msg("Runtime of %s task (PID %d) is %f seconds\n",
+		       class_str, ext_pid, ext_runtime);
+
+	/* Get runtime for the RT task */
+	rt_runtime =3D get_process_runtime(rt_pid);
+	if (rt_runtime =3D=3D -1)
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+	ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_ru=
ntime);
+
+	/* Kill the processes */
+	kill(ext_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(ext_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	actual_ratio =3D ext_runtime / (ext_runtime + rt_runtime);
+	ksft_print_msg("%s task got %.2f%% of total runtime\n",
+		       class_str, actual_ratio * 100);
+
+	if (actual_ratio >=3D expected_min_ratio) {
+		ksft_test_result_pass("PASS: %s task got more than %.2f%% of runtime\n",
+				      class_str, expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: %s task got less than %.2f%% of runtime\n",
+			      class_str, expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel =3D ctx;
+	struct bpf_link *link =3D NULL;
+	bool res;
+	int i;
+
+	/*
+	 * Test if the dl_server is working both with and without the
+	 * sched_ext scheduler attached.
+	 *
+	 * This ensures all the scenarios are covered:
+	 *   - fair_server stop -> ext_server start
+	 *   - ext_server stop -> fair_server stop
+	 */
+	for (i =3D 0; i < 4; i++) {
+		bool is_ext =3D i % 2;
+
+		if (is_ext) {
+			memset(&skel->data->uei, 0, sizeof(skel->data->uei));
+			link =3D bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+			SCX_FAIL_IF(!link, "Failed to attach scheduler");
+		}
+		res =3D sched_stress_test(is_ext);
+		if (is_ext) {
+			SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+			bpf_link__destroy(link);
+		}
+
+		if (!res)
+			ksft_exit_fail();
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel =3D ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall =3D {
+	.name =3D "rt_stall",
+	.description =3D "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup =3D setup,
+	.run =3D run,
+	.cleanup =3D cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)

