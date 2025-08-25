Return-Path: <linux-tip-commits+bounces-6351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3568EB33C9F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123C3482297
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDF32E284E;
	Mon, 25 Aug 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CzE8u6ut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPIixO2N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BD2E2678;
	Mon, 25 Aug 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117489; cv=none; b=r8ZjHgVqPDyUFiZ8ov0mNg8kZQ8+kTBKhkKrIJEv3m0kDbBzsmcRZu/2sXlQaynvwdfooWriLdDiR0S//8ZCAsAeVn2EwfS8wGk/ncBa4CLK+iFoeg26WuMJmVM424n3xS0v/Bb6p9oLI13Ju+W0z1wUDiJ14kWGB0BRllrxNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117489; c=relaxed/simple;
	bh=BcGGIz+K5v1W8gwGgli+2iLDh1o4BFF607qLWJKgh1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nDDnai4I+k0faTSSTdoOwQgkJIyFjAzShSI6c6EX/rkuEB/V+7+Ihy9nGH5NEROx9Ex113NYBQy/8ssKSnTsnr4Q47RDDyoMF7r+rwv49wCduV6ANLqRi4100AwXWdIFvEg3I/vNYKplaNto4r3NlkxgKwyeFJ7+q21ZO3JlkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CzE8u6ut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PPIixO2N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0noVBG01q5FqIWAzPXNP7AsItOsgGU0vSSQVKyR3dI=;
	b=CzE8u6ut/uzGks2WmvAxhM/Wp6lgYup8rUBD+1WSRN8Trpb3LOdNA3o4aPfeB/rOuhOXqw
	yvi/53gZwLWa64K1/Nu1I34OFOjbK1oatyTT/QEKO7b5T1zHncOrTg0ZB0dzwCpWLaph8+
	jR9EeGRY53lqPzaPSVvAlaEhCXx8tftK6Z5Ibt+2v06cNI1+1i8s49rGkyzABcO33hi12F
	cAJ/ubeb3kMznQzv5vWs9zeQr42WRlsZTEqRZ+dp17ZCdE0AsKciY2TywaBxaktf4aFDK0
	aVldFEm9lnidP6gg+3MugHARRyIaCvO3eTTFYpnQlr2ZvqXFEKQR67e4/oSHHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0noVBG01q5FqIWAzPXNP7AsItOsgGU0vSSQVKyR3dI=;
	b=PPIixO2Nw276Aoy7M1dGbCnCIWn66NjaifeetlRKu9rLq0Isea2ts5Hz17w/tfO0L1xLaR
	/zWssm/B5WileZBA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Add uprobe syscall sigill signal test
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-17-jolsa@kernel.org>
References: <20250720112133.244369-17-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748440.1420.4152374140064983244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c11661bd9adf6831a75bb79299de793039dd8b9b
Gitweb:        https://git.kernel.org/tip/c11661bd9adf6831a75bb79299de793039d=
d8b9b
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:24 +02:00

selftests/bpf: Add uprobe syscall sigill signal test

Make sure that calling uprobe syscall from outside uprobe trampoline
results in sigill signal.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-17-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 36 ++++++++-
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 3d27c8b..02e98cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -735,6 +735,40 @@ cleanup:
 	ASSERT_FALSE(USDT_SEMA_IS_ACTIVE(race), "race_semaphore");
 }
=20
+#ifndef __NR_uprobe
+#define __NR_uprobe 336
+#endif
+
+static void test_uprobe_sigill(void)
+{
+	int status, err, pid;
+
+	pid =3D fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		return;
+	/* child */
+	if (pid =3D=3D 0) {
+		asm volatile (
+			"pushq %rax\n"
+			"pushq %rcx\n"
+			"pushq %r11\n"
+			"movq $" __stringify(__NR_uprobe) ", %rax\n"
+			"syscall\n"
+			"popq %r11\n"
+			"popq %rcx\n"
+			"retq\n"
+		);
+		exit(0);
+	}
+
+	err =3D waitpid(pid, &status, 0);
+	ASSERT_EQ(err, pid, "waitpid");
+
+	/* verify the child got killed with SIGILL */
+	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
+	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -755,6 +789,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
+	if (test__start_subtest("uprobe_sigill"))
+		test_uprobe_sigill();
 }
 #else
 static void __test_uprobe_syscall(void)

