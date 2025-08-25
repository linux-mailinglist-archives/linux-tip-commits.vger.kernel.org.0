Return-Path: <linux-tip-commits+bounces-6348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0195B33C9B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6643179826
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754C2DC334;
	Mon, 25 Aug 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dmw/gfKc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2mo83zNE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60382DC327;
	Mon, 25 Aug 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117485; cv=none; b=OHU7oy/VDVXkJ6jz8nUG+mk6rSK6IstJMxNvxTwiqQZhng6uaLD9SVBt/DOFdDkYIhNyVN9q1hRnuekzKIs8JUFeQQKRmaje5kB0PwEhSxadbPes7Fdna34/dOgdkqwTXr80rL/Pbvq2rF/xTdaTmpGcjdFyyg7vcFZRhjueh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117485; c=relaxed/simple;
	bh=SGQN6/R0qOAvyZDZTbWi8yF1Ze6nbu/P71MuD6VbWQQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+W6chAy6ffahVckN/9nZJ9AHuy9QZIXja0gXIf6CddlJjQT2d7OKEmGoileExlFkQ+5JxaYfrh/qFYh6lA3xxE79Hn9p6BIXF/2uYrPyNKFffZ0Ed2+Hc6v8VAeC1g5OyzpXs6NupbVLf5YomNxdYyY9uy/TyI9JXR67Y19+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dmw/gfKc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2mo83zNE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZVnYQW+3GIg0IVJZ/3UX5MR9ot4zMUnJ54X057mi8=;
	b=Dmw/gfKckx0VrFBx7qdMmLangn2eiKsg3NNOlCeqbZIPoOQr6sh07AN0MOqxgrwZyAAMyH
	m2Rvmtm3qS0Ci6aUFpSbiyvQ48WvK1lfCPD946va4Fnf1/JwFwt5fad37dy7coLpqdiEZb
	jC5wEs7yuXpkcQocD/Xy9E2XaVeVqD3SiGUgKa8RPlEy5tlx47RCEF9pKPvkftjMO4iD9Z
	F/KOGGXgHfLjdApEUXKN1t2KkuwsEM7EMmviGa0+HztP9hTpqmAs6KTLxe9wdXHKMmDUhJ
	gWFk/usRrIk0qFzd0l4FC0vN0U0eInK9wpTzLopUJCLlkrwFiaiUBGX5MK+BDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZVnYQW+3GIg0IVJZ/3UX5MR9ot4zMUnJ54X057mi8=;
	b=2mo83zNEb+5a+DviZEYe8je6EEp46cuu5j87F7wmOQ0JPDTyOlHHsFuqZvgSWy+ZeZj6oO
	GpKz4wZo5h1uMXCQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Change test_uretprobe_regs_change for
 uprobe and uretprobe
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-20-jolsa@kernel.org>
References: <20250720112133.244369-20-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611747565.1420.17876097058142669804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3abf4298c6139cf10a41472d87b2f608666302b0
Gitweb:        https://git.kernel.org/tip/3abf4298c6139cf10a41472d87b2f608666=
302b0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:25 +02:00

selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe

Changing the test_uretprobe_regs_change test to test both uprobe
and uretprobe by adding entry consumer handler to the testmod
and making it to change one of the registers.

Making sure that changed values both uprobe and uretprobe handlers
propagate to the user space.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-20-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 12 +++++---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    | 11 +++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 36ce9e2..c1f945c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -207,7 +207,7 @@ static int write_bpf_testmod_uprobe(unsigned long offset)
 	return ret !=3D n ? (int) ret : 0;
 }
=20
-static void test_uretprobe_regs_change(void)
+static void test_regs_change(void)
 {
 	struct pt_regs before =3D {}, after =3D {};
 	unsigned long *pb =3D (unsigned long *) &before;
@@ -221,6 +221,9 @@ static void test_uretprobe_regs_change(void)
 	if (!ASSERT_OK(err, "register_uprobe"))
 		return;
=20
+	/* make sure uprobe gets optimized */
+	uprobe_regs_trigger();
+
 	uprobe_regs(&before, &after);
=20
 	err =3D write_bpf_testmod_uprobe(0);
@@ -643,7 +646,6 @@ static void test_uretprobe_shadow_stack(void)
=20
 	test_uprobe_regs_equal(false);
 	test_uprobe_regs_equal(true);
-	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
=20
 	test_uprobe_legacy();
@@ -651,6 +653,8 @@ static void test_uretprobe_shadow_stack(void)
 	test_uprobe_session();
 	test_uprobe_usdt();
=20
+	test_regs_change();
+
 	shstk_is_enabled =3D false;
=20
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
@@ -799,8 +803,6 @@ static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uprobe_regs_equal(true);
-	if (test__start_subtest("uretprobe_regs_change"))
-		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
@@ -819,6 +821,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_sigill();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
+	if (test__start_subtest("regs_change"))
+		test_regs_change();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/tes=
ting/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918c..5119110 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -501,14 +501,20 @@ static struct bin_attribute bin_attr_bpf_testmod_file _=
_ro_after_init =3D {
 #ifdef __x86_64__
=20
 static int
+uprobe_handler(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *da=
ta)
+{
+	regs->cx =3D 0x87654321feebdaed;
+	return 0;
+}
+
+static int
 uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 		   struct pt_regs *regs, __u64 *data)
=20
 {
 	regs->ax  =3D 0x12345678deadbeef;
-	regs->cx  =3D 0x87654321feebdaed;
 	regs->r11 =3D (u64) -1;
-	return true;
+	return 0;
 }
=20
 struct testmod_uprobe {
@@ -520,6 +526,7 @@ struct testmod_uprobe {
 static DEFINE_MUTEX(testmod_uprobe_mutex);
=20
 static struct testmod_uprobe uprobe =3D {
+	.consumer.handler =3D uprobe_handler,
 	.consumer.ret_handler =3D uprobe_ret_handler,
 };
=20

