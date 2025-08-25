Return-Path: <linux-tip-commits+bounces-6350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C904AB33CA0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D08816700E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CB2E2839;
	Mon, 25 Aug 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yshy93Pf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wm6+75Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AD2E229D;
	Mon, 25 Aug 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117488; cv=none; b=IbfpUDPYn+6wLXN01VGIBDq/g7iA/zndF3ztYOIiBZSGH7d3r88AJDoR/GoFc8DCe93SipMPrtH58qfOW4fBi9W8K/CDEzOeVDEcz+hexPUVuPIY/xnBLUBXeBhKD/6wRJ99Yl69botjFQWIONuGG/jybKtHOtI12vT5nteQN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117488; c=relaxed/simple;
	bh=/SXzRK20wDQxgEPIPd2V5neZScS6D/TUAogeN8cFtvo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tESJJrnZ8W0ZlO5enwWNEybi7W6l/r+5vz2zsZrL50zbcO8pQ3jAuu1QPvFv21BIWc8MBHLtEaxHz8ZYrKkj1Vdk01FNm51bkxAEefsNKIOWE/PjLVyckKm7Qmf2FOd6kghQ00avWKuPOhywYHCfVrsQXwz54EYH/UTIt7Kwsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yshy93Pf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wm6+75Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icRF3KwvxFBMtVQLI9ztAyZwhVtRX/Z4mTZS2+Nz2xQ=;
	b=yshy93PflRCMXbt0avasWawhzwncauBwSoeAWwMk24ZDt49PzSR2rlecijJJDWiJci9oeO
	9hVYPEmbbDe9ngUx6IFj9tam6xtgQY2S3yaS+RkmIQOvwO0KmAIJKpBnLE3rRWGE+Qzrma
	7W4IWImSBA7jhHbhRtwgVzha2oL6+rAnPTcqLk+PNAeTcn8kbFr5RumbFT3VVgGg7k1TcF
	dRiJL3kU2dLgif+RwugtOylXSw7G2e9T2diqlDVwY1+S1xmjYtlvYWG6HsnkZT9P6C/sXa
	fjfbvPnVldM3Hz8mGNAKX1myDTk+9gIsJFR1BSLPQYbxJmfRCYvshtbuFP+scg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icRF3KwvxFBMtVQLI9ztAyZwhVtRX/Z4mTZS2+Nz2xQ=;
	b=0wm6+75Y15t1v9X+Ih1RRJN2EtNRxOpatGALGv2WzqBIRnQFTMtDm7TgqccM5DmEHv9HfD
	XEYbTbCMJv//XjBQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Add optimized usdt variant for basic
 usdt test
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-18-jolsa@kernel.org>
References: <20250720112133.244369-18-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748335.1420.12656030479615284117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     875e1705ad9962f2642d098d6bfaabfa6f9c7ace
Gitweb:        https://git.kernel.org/tip/875e1705ad9962f2642d098d6bfaabfa6f9=
c7ace
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:24 +02:00

selftests/bpf: Add optimized usdt variant for basic usdt test

Adding optimized usdt variant for basic usdt test to check that
usdt arguments are properly passed in optimized code path.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-18-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 38 +++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/se=
lftests/bpf/prog_tests/usdt.c
index 9057e98..833eb87 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -40,12 +40,19 @@ static void __always_inline trigger_func(int x) {
 	}
 }
=20
-static void subtest_basic_usdt(void)
+static void subtest_basic_usdt(bool optimized)
 {
 	LIBBPF_OPTS(bpf_usdt_opts, opts);
 	struct test_usdt *skel;
 	struct test_usdt__bss *bss;
-	int err, i;
+	int err, i, called;
+
+#define TRIGGER(x) ({			\
+	trigger_func(x);		\
+	if (optimized)			\
+		trigger_func(x);	\
+	optimized ? 2 : 1;		\
+	})
=20
 	skel =3D test_usdt__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -66,11 +73,11 @@ static void subtest_basic_usdt(void)
 	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
 		goto cleanup;
=20
-	trigger_func(1);
+	called =3D TRIGGER(1);
=20
-	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
-	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
-	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
+	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
+	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
+	ASSERT_EQ(bss->usdt12_called, called, "usdt12_called");
=20
 	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
 	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
@@ -119,11 +126,11 @@ static void subtest_basic_usdt(void)
 	 * bpf_program__attach_usdt() handles this properly and attaches to
 	 * all possible places of USDT invocation.
 	 */
-	trigger_func(2);
+	called +=3D TRIGGER(2);
=20
-	ASSERT_EQ(bss->usdt0_called, 2, "usdt0_called");
-	ASSERT_EQ(bss->usdt3_called, 2, "usdt3_called");
-	ASSERT_EQ(bss->usdt12_called, 2, "usdt12_called");
+	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
+	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
+	ASSERT_EQ(bss->usdt12_called, called, "usdt12_called");
=20
 	/* only check values that depend on trigger_func()'s input value */
 	ASSERT_EQ(bss->usdt3_args[0], 2, "usdt3_arg1");
@@ -142,9 +149,9 @@ static void subtest_basic_usdt(void)
 	if (!ASSERT_OK_PTR(skel->links.usdt3, "usdt3_reattach"))
 		goto cleanup;
=20
-	trigger_func(3);
+	called +=3D TRIGGER(3);
=20
-	ASSERT_EQ(bss->usdt3_called, 3, "usdt3_called");
+	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
 	/* this time usdt3 has custom cookie */
 	ASSERT_EQ(bss->usdt3_cookie, 0xBADC00C51E, "usdt3_cookie");
 	ASSERT_EQ(bss->usdt3_arg_cnt, 3, "usdt3_arg_cnt");
@@ -158,6 +165,7 @@ static void subtest_basic_usdt(void)
=20
 cleanup:
 	test_usdt__destroy(skel);
+#undef TRIGGER
 }
=20
 unsigned short test_usdt_100_semaphore SEC(".probes");
@@ -425,7 +433,11 @@ cleanup:
 void test_usdt(void)
 {
 	if (test__start_subtest("basic"))
-		subtest_basic_usdt();
+		subtest_basic_usdt(false);
+#ifdef __x86_64__
+	if (test__start_subtest("basic_optimized"))
+		subtest_basic_usdt(true);
+#endif
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
 	if (test__start_subtest("urand_auto_attach"))

