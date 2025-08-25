Return-Path: <linux-tip-commits+bounces-6355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E7B33CA7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F148767D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562BB2E5422;
	Mon, 25 Aug 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ivwAsX0x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVXCzfr0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585D2E336E;
	Mon, 25 Aug 2025 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117494; cv=none; b=Oe4ie9Gu/ccHhUcls08eu2UZsuwV+Z3spaG9saNJNFdN571+jyasAhZlBd68BoRv7wNCQ1Du5pBdZJY+hWEHwiShSmtiFg9ZvpwJumE7oeToThPNdgLpIztSL6g5kvgCP4MPWXq257XHxqEScpIWoiHwKV2DBVTQvM7AIsGZ/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117494; c=relaxed/simple;
	bh=hwRghBJ96DFTlLtzH+1tj+Pbz4+gVpu6xQaPschgfpY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gy4jVmVWu7pPvWHyC1m969FVXkjAyoT+8CO7jUNLmD+l4jAcEFVMgpxLATDsX/2Cz1O5By8rPMyc/5dZouhVB+J4tAJJ8RjvVO8nTYJf+lpaBHypgDRhdRSIOrc8WuwcmeZXZjJP/RwY7j5xhDD7KJUtatsnWkpYXW2xmuBYHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ivwAsX0x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVXCzfr0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC/JwbMofzfVd3yUBf7dKN+44AdiNARqHJaK+j4YRZw=;
	b=ivwAsX0xR2kdiiHLHdw+iiUH8nwTR7+Sb3qDMUuEdxYk5EpfRlZr0PwE1+CAAwh0InDdzg
	odhdK1J9elTMUOFxa4BRV6uPUR/z+QQq7qXVl2u8hhGY/YC/UZEx+WW0JGPaX5vBL8JF0E
	5vhksTzH+TDrzPilMbB04gmbQ/gj2rUf3LT1jBHbt/yV7lR8PfhX2WAQQgv5JRQPGkrRaf
	eamEnnYCVn+nJs5vSu02hSvgCkmYoyyplCZqYkmG0rDe5YFg/eB4yCILlLQCCCaYZE3m5f
	E3ba/7cAaQ3GWmagFgoRDFgHLW+biojGO7Um1Y7aDx9AfYp3ZWK+M1YOIiPlkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC/JwbMofzfVd3yUBf7dKN+44AdiNARqHJaK+j4YRZw=;
	b=KVXCzfr0CuyF3qATe6WI5Zxp3/I9JM5Swjs9mMFC0p96cit/gMhirlMLHB5YIMcHceQtzE
	CiwVhAm7LbpVNNBg==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] selftests/bpf: Reorg the uprobe_syscall test function
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-13-jolsa@kernel.org>
References: <20250720112133.244369-13-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748895.1420.17695747248969505836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4e7005223e6dab882646d96d0e2aa84a5dd07b56
Gitweb:        https://git.kernel.org/tip/4e7005223e6dab882646d96d0e2aa84a5dd=
07b56
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:23 +02:00

selftests/bpf: Reorg the uprobe_syscall test function

Adding __test_uprobe_syscall with non x86_64 stub to execute all the tests,
so we don't need to keep adding non x86_64 stub functions for new tests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-13-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 34 ++------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index b17dc39..a8f00ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -350,29 +350,8 @@ static void test_uretprobe_shadow_stack(void)
=20
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
-#else
-static void test_uretprobe_regs_equal(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_regs_change(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_syscall_call(void)
-{
-	test__skip();
-}
=20
-static void test_uretprobe_shadow_stack(void)
-{
-	test__skip();
-}
-#endif
-
-void test_uprobe_syscall(void)
+static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uretprobe_regs_equal();
@@ -383,3 +362,14 @@ void test_uprobe_syscall(void)
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
 }
+#else
+static void __test_uprobe_syscall(void)
+{
+	test__skip();
+}
+#endif
+
+void test_uprobe_syscall(void)
+{
+	__test_uprobe_syscall();
+}

