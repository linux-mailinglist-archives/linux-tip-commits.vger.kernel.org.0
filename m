Return-Path: <linux-tip-commits+bounces-6345-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D9B33C92
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B6179625
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0C2E1745;
	Mon, 25 Aug 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dgcBh33h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHI+SEEJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0542E06EA;
	Mon, 25 Aug 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117476; cv=none; b=WtIupum1ttPPSYs/qT112Hj/iIzzwL5Io9cs0pI7/+vyCv666bZRNMGsQeDNriaOIgcvk5RwiWwHwOi56WdYJp8dOlLGie9fN1pnX0OYyx9+2f7Xlf+Psvgxvkp7ePWsJSkDapbv/9SX0Jy/L82KDE4AZaRihmB3WvQ34qpPOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117476; c=relaxed/simple;
	bh=vG88LxLa+PKiKNt7QFI/4SrkpvRXUcyHYDoH7BSpE1g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XX5miV5xdjXgINzgqTtYZp9Vo15eqS5r0Ja3ss8zTctm1fK7nbc352TrBVDpYEvHCqH/++wVA430Mwmc/n373YVkStWjq0U3q1NH18QhPHmyMYSklYEpnwjbw+QGEq8rfqGMvmGe2e6kTWHX6E9BgmeW0uwscm2YqmM206CMYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dgcBh33h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iHI+SEEJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RU0dLGCzN1J/7II8NUPDS+fNkr1L+vrIZVV/GhsaUI=;
	b=dgcBh33hYm5sdQ5LxFphwCCVKgDc0YGQdDyIGRLiDnwsCIIpSUUxGDewO4brTMu9/H9BbI
	6HMm0vvPmUMQZh2e84E09PQQSQdddkPnUx8NFhSDR7GktwlMde7fsmvDlthuqOes8jin3e
	m446/ns8vqhsZmSFYwviEicgDPZT+BYbkZNG2JUbySg3gYBftpn+/1vvEDzRMKvBWflT02
	Rk3ZukWWAGyFt/1bOdUMhLk9RsKG3QayhyH8h7UQiK9JnTgs/w863RunLEO/CMsD99sT2W
	MSHJ11LbQ8XleIlqDN+dliurfbnwGOoJaeyouEkcVMjnIlgbZ0oAiBET8xPVJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RU0dLGCzN1J/7II8NUPDS+fNkr1L+vrIZVV/GhsaUI=;
	b=iHI+SEEJck/lc4TAf4RXU4caejeA0C5bmB/QcYdkp9os9uwkL8V+cqpn7LyjYKysaH3UgD
	JMcR71MAap/NXCBQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/seccomp: validate uprobe syscall passes
 through seccomp
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-22-jolsa@kernel.org>
References: <20250720112133.244369-22-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611747211.1420.4858798001257372180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9ffc7a635c35ad61349a36e9f52d46df9ba67dc3
Gitweb:        https://git.kernel.org/tip/9ffc7a635c35ad61349a36e9f52d46df9ba=
67dc3
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:26 +02:00

selftests/seccomp: validate uprobe syscall passes through seccomp

Adding uprobe checks into the current uretprobe tests.

All the related tests are now executed with attached uprobe
or uretprobe or without any probe.

Renaming the test fixture to uprobe, because it seems better.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-22-jolsa@kernel.org
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 107 +++++++++++++----
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/se=
lftests/seccomp/seccomp_bpf.c
index 61acbd4..2cf6fc8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -73,6 +73,14 @@
 #define noinline __attribute__((noinline))
 #endif
=20
+#ifndef __nocf_check
+#define __nocf_check __attribute__((nocf_check))
+#endif
+
+#ifndef __naked
+#define __naked __attribute__((__naked__))
+#endif
+
 #ifndef PR_SET_NO_NEW_PRIVS
 #define PR_SET_NO_NEW_PRIVS 38
 #define PR_GET_NO_NEW_PRIVS 39
@@ -4896,7 +4904,36 @@ TEST(tsync_vs_dead_thread_leader)
 	EXPECT_EQ(0, status);
 }
=20
-noinline int probed(void)
+#ifdef __x86_64__
+
+/*
+ * We need naked probed_uprobe function. Using __nocf_check
+ * check to skip possible endbr64 instruction and ignoring
+ * -Wattributes, otherwise the compilation might fail.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattributes"
+
+__naked __nocf_check noinline int probed_uprobe(void)
+{
+	/*
+	 * Optimized uprobe is possible only on top of nop5 instruction.
+	 */
+	asm volatile ("                                 \n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00     \n"
+		"ret                                    \n"
+	);
+}
+#pragma GCC diagnostic pop
+
+#else
+noinline int probed_uprobe(void)
+{
+	return 1;
+}
+#endif
+
+noinline int probed_uretprobe(void)
 {
 	return 1;
 }
@@ -4949,35 +4986,46 @@ static ssize_t get_uprobe_offset(const void *addr)
 	return found ? (uintptr_t)addr - start + base : -1;
 }
=20
-FIXTURE(URETPROBE) {
+FIXTURE(UPROBE) {
 	int fd;
 };
=20
-FIXTURE_VARIANT(URETPROBE) {
+FIXTURE_VARIANT(UPROBE) {
 	/*
-	 * All of the URETPROBE behaviors can be tested with either
-	 * uretprobe attached or not
+	 * All of the U(RET)PROBE behaviors can be tested with either
+	 * u(ret)probe attached or not
 	 */
 	bool attach;
+	/*
+	 * Test both uprobe and uretprobe.
+	 */
+	bool uretprobe;
 };
=20
-FIXTURE_VARIANT_ADD(URETPROBE, attached) {
+FIXTURE_VARIANT_ADD(UPROBE, not_attached) {
+	.attach =3D false,
+	.uretprobe =3D false,
+};
+
+FIXTURE_VARIANT_ADD(UPROBE, uprobe_attached) {
 	.attach =3D true,
+	.uretprobe =3D false,
 };
=20
-FIXTURE_VARIANT_ADD(URETPROBE, not_attached) {
-	.attach =3D false,
+FIXTURE_VARIANT_ADD(UPROBE, uretprobe_attached) {
+	.attach =3D true,
+	.uretprobe =3D true,
 };
=20
-FIXTURE_SETUP(URETPROBE)
+FIXTURE_SETUP(UPROBE)
 {
 	const size_t attr_sz =3D sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
 	ssize_t offset;
 	int type, bit;
=20
-#ifndef __NR_uretprobe
-	SKIP(return, "__NR_uretprobe syscall not defined");
+#if !defined(__NR_uprobe) || !defined(__NR_uretprobe)
+	SKIP(return, "__NR_uprobe ot __NR_uretprobe syscalls not defined");
 #endif
=20
 	if (!variant->attach)
@@ -4987,12 +5035,17 @@ FIXTURE_SETUP(URETPROBE)
=20
 	type =3D determine_uprobe_perf_type();
 	ASSERT_GE(type, 0);
-	bit =3D determine_uprobe_retprobe_bit();
-	ASSERT_GE(bit, 0);
-	offset =3D get_uprobe_offset(probed);
+
+	if (variant->uretprobe) {
+		bit =3D determine_uprobe_retprobe_bit();
+		ASSERT_GE(bit, 0);
+	}
+
+	offset =3D get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed=
_uprobe);
 	ASSERT_GE(offset, 0);
=20
-	attr.config |=3D 1 << bit;
+	if (variant->uretprobe)
+		attr.config |=3D 1 << bit;
 	attr.size =3D attr_sz;
 	attr.type =3D type;
 	attr.config1 =3D ptr_to_u64("/proc/self/exe");
@@ -5003,7 +5056,7 @@ FIXTURE_SETUP(URETPROBE)
 			   PERF_FLAG_FD_CLOEXEC);
 }
=20
-FIXTURE_TEARDOWN(URETPROBE)
+FIXTURE_TEARDOWN(UPROBE)
 {
 	/* we could call close(self->fd), but we'd need extra filter for
 	 * that and since we are calling _exit right away..
@@ -5017,11 +5070,17 @@ static int run_probed_with_filter(struct sock_fprog *=
prog)
 		return -1;
 	}
=20
-	probed();
+	/*
+	 * Uprobe is optimized after first hit, so let's hit twice.
+	 */
+	probed_uprobe();
+	probed_uprobe();
+
+	probed_uretprobe();
 	return 0;
 }
=20
-TEST_F(URETPROBE, uretprobe_default_allow)
+TEST_F(UPROBE, uprobe_default_allow)
 {
 	struct sock_filter filter[] =3D {
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
@@ -5034,7 +5093,7 @@ TEST_F(URETPROBE, uretprobe_default_allow)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
=20
-TEST_F(URETPROBE, uretprobe_default_block)
+TEST_F(UPROBE, uprobe_default_block)
 {
 	struct sock_filter filter[] =3D {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -5051,11 +5110,14 @@ TEST_F(URETPROBE, uretprobe_default_block)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
=20
-TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
+TEST_F(UPROBE, uprobe_block_syscall)
 {
 	struct sock_filter filter[] =3D {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_uprobe
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uprobe, 1, 2),
+#endif
 #ifdef __NR_uretprobe
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 0, 1),
 #endif
@@ -5070,11 +5132,14 @@ TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
=20
-TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
+TEST_F(UPROBE, uprobe_default_block_with_syscall)
 {
 	struct sock_filter filter[] =3D {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_uprobe
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uprobe, 3, 0),
+#endif
 #ifdef __NR_uretprobe
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 2, 0),
 #endif

