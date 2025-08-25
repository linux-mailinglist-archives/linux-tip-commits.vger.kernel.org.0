Return-Path: <linux-tip-commits+bounces-6353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D36B33CA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF0116AAB7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230B2E2F1D;
	Mon, 25 Aug 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRS5UM5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVp0vOee"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70E2E285B;
	Mon, 25 Aug 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117491; cv=none; b=JoDzA3D7XIXL3QEZKGiK9gkTxymvU2rXxw7gtBu5mpKTdc4a/lHPDmxIEtsoBC4lRBRGGA3ln7zPeBmyBlcOwcbIR8o7qvhWvv3shKGNGp6XfkDJvqQVETifoobVP+JKpfLGZHTq+qy9OSVxuWpotk+WcL2XrGo7v5UvmLj2XhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117491; c=relaxed/simple;
	bh=eV9X2Z6hDF+MNn/vUkuJSUFDNL15YPYvph47TwyCJN0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jpxoJlISdQH0hapQK3yiz06970b2tYhzyPIpdLzz2Gd4L85I6v7ij9NMjI+3+lOMgBh1Nkqou/1p6SAkh7H0M+8wW36quctDMcP8AoH2vM7moOqil/VomrndPD907mfeVrkbq31zDT1g/Deg147oFxR8gek40aLT48I4PvEQ00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRS5UM5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVp0vOee; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug6Y4YaoIajz72Igz1uqN5nMi0PVgwWa+pDML9jxq1A=;
	b=HRS5UM5oQReFPEq95oxjX72DpMJR8nRnjdFepXj8ORfPYB9i+3WY2hlqq/uq95baUZND3N
	exWAxIb5zlq2FYwqn1yUFd4xfannhuZhN0UR624uTzQqnc8qlOo3IIvXhiUcvvMMByg6ux
	TeU8D6PDk/sjC83VlUYR/k3nnn5Ne1Ym9XuCR4VddzRiCd4U3v2M72Fb/+Iaxlf9OFeC4+
	wO/sgaxF/mNFSidwI2YXyNV8zlDbvMG4rKsBLch2yAj4OwYyHAwPH4Bb0t0XicPW50eYV2
	xpVvR7UXchhLbb1JivANcwvo4SaMC3Jrtnf4LViy9Iknnkx3uCENwpxroL2mTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug6Y4YaoIajz72Igz1uqN5nMi0PVgwWa+pDML9jxq1A=;
	b=UVp0vOee9rdFmCbU9fYEsZ3PG/momJdXXt/MjyLIoqkPP28YOuJEqAVguZ1yYD2lqcToYO
	XRYy9BhwboUPzbCw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Add uprobe/usdt syscall tests
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-15-jolsa@kernel.org>
References: <20250720112133.244369-15-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748663.1420.11936211018763844724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d5c86c3370100620fa9c2e8dc9350c354b30ddb4
Gitweb:        https://git.kernel.org/tip/d5c86c3370100620fa9c2e8dc9350c354b3=
0ddb4
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:24 +02:00

selftests/bpf: Add uprobe/usdt syscall tests

Adding tests for optimized uprobe/usdt probes.

Checking that we get expected trampoline and attached bpf programs
get executed properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-15-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 284 ++++++-
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  52 +-
 2 files changed, 335 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 6d58a44..b91135a 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -8,6 +8,7 @@
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
 #include <linux/stringify.h>
+#include <linux/kernel.h>
 #include <sys/wait.h>
 #include <sys/syscall.h>
 #include <sys/prctl.h>
@@ -15,6 +16,11 @@
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
=20
+#define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
+#include "usdt.h"
+
+#pragma GCC diagnostic ignored "-Wattributes"
+
 __naked unsigned long uretprobe_regs_trigger(void)
 {
 	asm volatile (
@@ -305,6 +311,265 @@ cleanup:
 	close(go[0]);
 }
=20
+#define TRAMP "[uprobes-trampoline]"
+
+__attribute__((aligned(16)))
+__nocf_check __weak __naked void uprobe_test(void)
+{
+	asm volatile ("					\n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00	\n"
+		"ret					\n"
+	);
+}
+
+__attribute__((aligned(16)))
+__nocf_check __weak void usdt_test(void)
+{
+	USDT(optimized_uprobe, usdt);
+}
+
+static int find_uprobes_trampoline(void *tramp_addr)
+{
+	void *start, *end;
+	char line[128];
+	int ret =3D -1;
+	FILE *maps;
+
+	maps =3D fopen("/proc/self/maps", "r");
+	if (!maps) {
+		fprintf(stderr, "cannot open maps\n");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), maps)) {
+		int m =3D -1;
+
+		/* We care only about private r-x mappings. */
+		if (sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n", &start, &end, &m) !=3D 2)
+			continue;
+		if (m < 0)
+			continue;
+		if (!strncmp(&line[m], TRAMP, sizeof(TRAMP)-1) && (start =3D=3D tramp_addr=
)) {
+			ret =3D 0;
+			break;
+		}
+	}
+
+	fclose(maps);
+	return ret;
+}
+
+static unsigned char nop5[5] =3D { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+
+static void *find_nop5(void *fn)
+{
+	int i;
+
+	for (i =3D 0; i < 10; i++) {
+		if (!memcmp(nop5, fn + i, 5))
+			return fn + i;
+	}
+	return NULL;
+}
+
+typedef void (__attribute__((nocf_check)) *trigger_t)(void);
+
+static bool shstk_is_enabled;
+
+static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t tr=
igger,
+			  void *addr, int executed)
+{
+	struct __arch_relative_insn {
+		__u8 op;
+		__s32 raddr;
+	} __packed *call;
+	void *tramp =3D NULL;
+	__u8 *bp;
+
+	/* Uprobe gets optimized after first trigger, so let's press twice. */
+	trigger();
+	trigger();
+
+	/* Make sure bpf program got executed.. */
+	ASSERT_EQ(skel->bss->executed, executed, "executed");
+
+	if (shstk_is_enabled) {
+		/* .. and check optimization is disabled under shadow stack. */
+		bp =3D (__u8 *) addr;
+		ASSERT_EQ(*bp, 0xcc, "int3");
+	} else {
+		/* .. and check the trampoline is as expected. */
+		call =3D (struct __arch_relative_insn *) addr;
+		tramp =3D (void *) (call + 1) + call->raddr;
+		ASSERT_EQ(call->op, 0xe8, "call");
+		ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
+	}
+
+	return tramp;
+}
+
+static void check_detach(void *addr, void *tramp)
+{
+	/* [uprobes_trampoline] stays after detach */
+	ASSERT_OK(!shstk_is_enabled && find_uprobes_trampoline(tramp), "uprobes_tra=
mpoline");
+	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+}
+
+static void check(struct uprobe_syscall_executed *skel, struct bpf_link *lin=
k,
+		  trigger_t trigger, void *addr, int executed)
+{
+	void *tramp;
+
+	tramp =3D check_attach(skel, trigger, addr, executed);
+	bpf_link__destroy(link);
+	check_detach(addr, tramp);
+}
+
+static void test_uprobe_legacy(void)
+{
+	struct uprobe_syscall_executed *skel =3D NULL;
+	LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe =3D true,
+	);
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset =3D get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	/* uprobe */
+	skel =3D uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid =3D getpid();
+
+	link =3D bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+	/* uretprobe */
+	skel->bss->executed =3D 0;
+
+	link =3D bpf_program__attach_uprobe_opts(skel->progs.test_uretprobe,
+				0, "/proc/self/exe", offset, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_multi(void)
+{
+	struct uprobe_syscall_executed *skel =3D NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset =3D get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	opts.offsets =3D &offset;
+	opts.cnt =3D 1;
+
+	skel =3D uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid =3D getpid();
+
+	/* uprobe.multi */
+	link =3D bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_multi,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+	/* uretprobe.multi */
+	skel->bss->executed =3D 0;
+	opts.retprobe =3D true;
+	link =3D bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_session(void)
+{
+	struct uprobe_syscall_executed *skel =3D NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.session =3D true,
+	);
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset =3D get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	opts.offsets =3D &offset;
+	opts.cnt =3D 1;
+
+	skel =3D uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid =3D getpid();
+
+	link =3D bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_session,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 4);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_usdt(void)
+{
+	struct uprobe_syscall_executed *skel;
+	struct bpf_link *link;
+	void *addr;
+
+	errno =3D 0;
+	addr =3D find_nop5(usdt_test);
+	if (!ASSERT_OK_PTR(addr, "find_nop5"))
+		return;
+
+	skel =3D uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid =3D getpid();
+
+	link =3D bpf_program__attach_usdt(skel->progs.test_usdt,
+				-1 /* all PIDs */, "/proc/self/exe",
+				"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	check(skel, link, usdt_test, addr, 2);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
 /*
  * Borrowed from tools/testing/selftests/x86/test_shadow_stack.c.
  *
@@ -347,11 +612,20 @@ static void test_uretprobe_shadow_stack(void)
 		return;
 	}
=20
-	/* Run all of the uretprobe tests. */
+	/* Run all the tests with shadow stack in place. */
+	shstk_is_enabled =3D true;
+
 	test_uretprobe_regs_equal();
 	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
=20
+	test_uprobe_legacy();
+	test_uprobe_multi();
+	test_uprobe_session();
+	test_uprobe_usdt();
+
+	shstk_is_enabled =3D false;
+
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
=20
@@ -365,6 +639,14 @@ static void __test_uprobe_syscall(void)
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
+	if (test__start_subtest("uprobe_legacy"))
+		test_uprobe_legacy();
+	if (test__start_subtest("uprobe_multi"))
+		test_uprobe_multi();
+	if (test__start_subtest("uprobe_session"))
+		test_uprobe_session();
+	if (test__start_subtest("uprobe_usdt"))
+		test_uprobe_usdt();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/to=
ols/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 8f48976..915d385 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
 #include <string.h>
=20
 struct pt_regs regs;
@@ -10,6 +12,36 @@ char _license[] SEC("license") =3D "GPL";
 int executed =3D 0;
 int pid;
=20
+SEC("uprobe")
+int BPF_UPROBE(test_uprobe)
+{
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	executed++;
+	return 0;
+}
+
+SEC("uretprobe")
+int BPF_URETPROBE(test_uretprobe)
+{
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	executed++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int test_uprobe_multi(struct pt_regs *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	executed++;
+	return 0;
+}
+
 SEC("uretprobe.multi")
 int test_uretprobe_multi(struct pt_regs *ctx)
 {
@@ -19,3 +51,23 @@ int test_uretprobe_multi(struct pt_regs *ctx)
 	executed++;
 	return 0;
 }
+
+SEC("uprobe.session")
+int test_uprobe_session(struct pt_regs *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	executed++;
+	return 0;
+}
+
+SEC("usdt")
+int test_usdt(struct pt_regs *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	executed++;
+	return 0;
+}

