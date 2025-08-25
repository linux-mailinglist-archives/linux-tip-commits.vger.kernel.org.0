Return-Path: <linux-tip-commits+bounces-6349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E03B33C9D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B491898305
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6672E265B;
	Mon, 25 Aug 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NkRzI+GT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8IAHemPH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7112D1931;
	Mon, 25 Aug 2025 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117486; cv=none; b=niMZEiiHBfdDXryjBSOWQvB7aS0YpSXyfYKeAessn+tXt+Fyt1rufUU465ZXmzaWYpZQFmyb9fOoiB58MN5OIMUKjyTGDMNtd5Aa9HNnWpv3kbelNgyeE0+5s4WhAeziYgFT0kgh7aOu2x60ZIrdhsxv1OwmKkPAv3FNe0Mt0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117486; c=relaxed/simple;
	bh=YTINQERdit9RFQJ5vvzLVwusN7RGropN8BMe5I0Oyjw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RchO9zoChe2dR9kACQivbpwns4fkawdtazMi1/7+Aa0EVzA2lRm9G16IP0x9paZmm1HLiGmAlw9HJHRn3NO/bzI/isHlKu4N+4NMYthmBECojRI2Ofiz+PeWPubIY/E0pUuEXTpnz2iXwECqOm+7ipArI9ESJ18ocgeS1SS0ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NkRzI+GT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8IAHemPH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhw+sN+dutksxu8XBEWW4QKc+mVQYdHBh0FH3BMPFg=;
	b=NkRzI+GTnJUuRR2GyBBzt6gH5AoFBG1kFLwVAKo+2gw6XxsYEK5nqQWxpjLN6y//IZz4RV
	gpuS06JGdkFjhfHlSf17ZmZFeWZOkc4lkwQAcPxzS7szL1epdgIrDjBdYOntPYNyjRB4zf
	E0v2W0affW6sMxc+6aNSTrqyTyLpBZoXbXktDjySkuYNMeingPNnCrVS899jJQ0AN4Khy7
	UvcSs6nwSOMiFFIMSwJVDTFQvxSKy9/lQwF3TRPu+kRjVr2u0tbGPyzZmXZEpPxO9Wo25Y
	WD464nxXv1hEiHUBuESspmQ+eOoq5gx/2lse0NVkHMlxibDbMMkHGQbatiRpjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhw+sN+dutksxu8XBEWW4QKc+mVQYdHBh0FH3BMPFg=;
	b=8IAHemPHCbGal5BE/Y+n/+kq4F4xhBK+KbXJNOoqFsgnMRaijzXLIEQqpgBasf7Ir1z0Um
	0agzPxCpYdA6lBDA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Add uprobe_regs_equal test
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-19-jolsa@kernel.org>
References: <20250720112133.244369-19-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748217.1420.2474971071317273816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     275eae6789864904a7319fbb4e993734a0fb4310
Gitweb:        https://git.kernel.org/tip/275eae6789864904a7319fbb4e993734a0f=
b4310
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:25 +02:00

selftests/bpf: Add uprobe_regs_equal test

Changing uretprobe_regs_trigger to allow the test for both
uprobe and uretprobe and renaming it to uprobe_regs_equal.

We check that both uprobe and uretprobe probes (bpf programs)
see expected registers with few exceptions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-19-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 56 ++++++--
 tools/testing/selftests/bpf/progs/uprobe_syscall.c      |  4 +-
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 02e98cb..36ce9e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -22,15 +22,17 @@
=20
 #pragma GCC diagnostic ignored "-Wattributes"
=20
-__naked unsigned long uretprobe_regs_trigger(void)
+__attribute__((aligned(16)))
+__nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
 {
 	asm volatile (
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00\n" /* nop5 */
 		"movq $0xdeadbeef, %rax\n"
 		"ret\n"
 	);
 }
=20
-__naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
+__naked void uprobe_regs(struct pt_regs *before, struct pt_regs *after)
 {
 	asm volatile (
 		"movq %r15,   0(%rdi)\n"
@@ -51,15 +53,17 @@ __naked void uretprobe_regs(struct pt_regs *before, struc=
t pt_regs *after)
 		"movq   $0, 120(%rdi)\n" /* orig_rax */
 		"movq   $0, 128(%rdi)\n" /* rip      */
 		"movq   $0, 136(%rdi)\n" /* cs       */
+		"pushq %rax\n"
 		"pushf\n"
 		"pop %rax\n"
 		"movq %rax, 144(%rdi)\n" /* eflags   */
+		"pop %rax\n"
 		"movq %rsp, 152(%rdi)\n" /* rsp      */
 		"movq   $0, 160(%rdi)\n" /* ss       */
=20
 		/* save 2nd argument */
 		"pushq %rsi\n"
-		"call uretprobe_regs_trigger\n"
+		"call uprobe_regs_trigger\n"
=20
 		/* save  return value and load 2nd argument pointer to rax */
 		"pushq %rax\n"
@@ -99,25 +103,37 @@ __naked void uretprobe_regs(struct pt_regs *before, stru=
ct pt_regs *after)
 );
 }
=20
-static void test_uretprobe_regs_equal(void)
+static void test_uprobe_regs_equal(bool retprobe)
 {
+	LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe =3D retprobe,
+	);
 	struct uprobe_syscall *skel =3D NULL;
 	struct pt_regs before =3D {}, after =3D {};
 	unsigned long *pb =3D (unsigned long *) &before;
 	unsigned long *pa =3D (unsigned long *) &after;
 	unsigned long *pp;
+	unsigned long offset;
 	unsigned int i, cnt;
-	int err;
+
+	offset =3D get_uprobe_offset(&uprobe_regs_trigger);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return;
=20
 	skel =3D uprobe_syscall__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "uprobe_syscall__open_and_load"))
 		goto cleanup;
=20
-	err =3D uprobe_syscall__attach(skel);
-	if (!ASSERT_OK(err, "uprobe_syscall__attach"))
+	skel->links.probe =3D bpf_program__attach_uprobe_opts(skel->progs.probe,
+				0, "/proc/self/exe", offset, &opts);
+	if (!ASSERT_OK_PTR(skel->links.probe, "bpf_program__attach_uprobe_opts"))
 		goto cleanup;
=20
-	uretprobe_regs(&before, &after);
+	/* make sure uprobe gets optimized */
+	if (!retprobe)
+		uprobe_regs_trigger();
+
+	uprobe_regs(&before, &after);
=20
 	pp =3D (unsigned long *) &skel->bss->regs;
 	cnt =3D sizeof(before)/sizeof(*pb);
@@ -126,7 +142,7 @@ static void test_uretprobe_regs_equal(void)
 		unsigned int offset =3D i * sizeof(unsigned long);
=20
 		/*
-		 * Check register before and after uretprobe_regs_trigger call
+		 * Check register before and after uprobe_regs_trigger call
 		 * that triggers the uretprobe.
 		 */
 		switch (offset) {
@@ -140,7 +156,7 @@ static void test_uretprobe_regs_equal(void)
=20
 		/*
 		 * Check register seen from bpf program and register after
-		 * uretprobe_regs_trigger call
+		 * uprobe_regs_trigger call (with rax exception, check below).
 		 */
 		switch (offset) {
 		/*
@@ -153,6 +169,15 @@ static void test_uretprobe_regs_equal(void)
 		case offsetof(struct pt_regs, rsp):
 		case offsetof(struct pt_regs, ss):
 			break;
+		/*
+		 * uprobe does not see return value in rax, it needs to see the
+		 * original (before) rax value
+		 */
+		case offsetof(struct pt_regs, rax):
+			if (!retprobe) {
+				ASSERT_EQ(pp[i], pb[i], "uprobe rax prog-before value check");
+				break;
+			}
 		default:
 			if (!ASSERT_EQ(pp[i], pa[i], "register prog-after value check"))
 				fprintf(stdout, "failed register offset %u\n", offset);
@@ -190,13 +215,13 @@ static void test_uretprobe_regs_change(void)
 	unsigned long cnt =3D sizeof(before)/sizeof(*pb);
 	unsigned int i, err, offset;
=20
-	offset =3D get_uprobe_offset(uretprobe_regs_trigger);
+	offset =3D get_uprobe_offset(uprobe_regs_trigger);
=20
 	err =3D write_bpf_testmod_uprobe(offset);
 	if (!ASSERT_OK(err, "register_uprobe"))
 		return;
=20
-	uretprobe_regs(&before, &after);
+	uprobe_regs(&before, &after);
=20
 	err =3D write_bpf_testmod_uprobe(0);
 	if (!ASSERT_OK(err, "unregister_uprobe"))
@@ -616,7 +641,8 @@ static void test_uretprobe_shadow_stack(void)
 	/* Run all the tests with shadow stack in place. */
 	shstk_is_enabled =3D true;
=20
-	test_uretprobe_regs_equal();
+	test_uprobe_regs_equal(false);
+	test_uprobe_regs_equal(true);
 	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
=20
@@ -772,7 +798,7 @@ static void test_uprobe_sigill(void)
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
-		test_uretprobe_regs_equal();
+		test_uprobe_regs_equal(true);
 	if (test__start_subtest("uretprobe_regs_change"))
 		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
@@ -791,6 +817,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_race();
 	if (test__start_subtest("uprobe_sigill"))
 		test_uprobe_sigill();
+	if (test__start_subtest("uprobe_regs_equal"))
+		test_uprobe_regs_equal(false);
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testi=
ng/selftests/bpf/progs/uprobe_syscall.c
index 8a4fa6c..e08c316 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
@@ -7,8 +7,8 @@ struct pt_regs regs;
=20
 char _license[] SEC("license") =3D "GPL";
=20
-SEC("uretprobe//proc/self/exe:uretprobe_regs_trigger")
-int uretprobe(struct pt_regs *ctx)
+SEC("uprobe")
+int probe(struct pt_regs *ctx)
 {
 	__builtin_memcpy(&regs, ctx, sizeof(regs));
 	return 0;

