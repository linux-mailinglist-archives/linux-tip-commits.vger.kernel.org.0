Return-Path: <linux-tip-commits+bounces-6645-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F96B59565
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1953AFA9D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3C2D46DC;
	Tue, 16 Sep 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vFysaBfd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VbBa1WtD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEA29ACCD;
	Tue, 16 Sep 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022680; cv=none; b=rEdrEYapEu7BYk8qi2mr7f/v5wPEvl3FGhn1zWNnhJ2jjWuFyNorD+sjSSofuuoyvj4vHvRQNif21y1UKtl8464FajqpurhbfdoUftQBQtGjQj9rgoZP+lfRlsqv12ebdEJeyttyf9dwqz4NnHYjP8UZhu9YYsNZpe/Uzzf2Mog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022680; c=relaxed/simple;
	bh=toersis7B4jSocXZ6rkvWiudGHiy9HIUQiD/SKzkY9E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QxIXq5bl1GGSe4VW9R3pQwW1XhnekGS8HvYUniinwfdUCJqeemiYyfUl0prcJilRlzrm7Qj1ahctqDI38wj3aZJYIIYnlutPSGtYpEmqUTeoP34IEfKWYKda12z+pl8L7xSoOJUEloAwYhtoBT7D1cH1NrcbpHJ0m01EUFLgd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vFysaBfd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VbBa1WtD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 11:37:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758022676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtHjT3/Ml7qAuLgSOCzOfKDv+7u/+4lXegfYxxWJRVY=;
	b=vFysaBfdnL0YAleW8XKCudyKwob2gwC6z7KLH5xMpoeQh7IBYS0rDTRgraerCs6FzOU336
	qsX+//9taiRSdHrKdVzmkZMRuhCqCIm3wBpVAw17M2tqnd5oFqGlUA4G6mdsSPIgjnLTby
	uEUzBXmIohuvVnD27wT0J34PyNS13tzmsgFswgwIe4JrcnlfamE10L3GJ5owzaEjejhxC/
	QIdEnZVKFVN4UXWB4tRM8G6Y47tkSyxWbtyYFcDQ5ejT4AifJcDkRApuzsXFBG/hj649Ds
	XWR7LALsM2+0p/FsYAfGp9WcAuuwiKN6uO6Nr9JTXl0NwK7pc7xT27WlQSTzzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758022676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtHjT3/Ml7qAuLgSOCzOfKDv+7u/+4lXegfYxxWJRVY=;
	b=VbBa1WtDIlqH/FESufUGBXCMdiyybZd5yk9OQ898/YG7wvWSgqMFUjltS/nTIoPLGLPluN
	whVVNC9z+u3Kt5AA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Fix uprobe_sigill test for uprobe
 syscall error value
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905205731.1961288-3-jolsa@kernel.org>
References: <20250905205731.1961288-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802267492.709179.1077259124514788404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6d48436560e91be858158e227f21aab71698814e
Gitweb:        https://git.kernel.org/tip/6d48436560e91be858158e227f21aab7169=
8814e
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 05 Sep 2025 22:57:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 13:46:29 +02:00

selftests/bpf: Fix uprobe_sigill test for uprobe syscall error value

The uprobe syscall now returns -ENXIO errno when called outside
kernel trampoline, fixing the current sigill test to reflect that
and renaming it to uprobe_error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 34 +-------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 5da0b49..6d75ede 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -757,34 +757,12 @@ cleanup:
 #define __NR_uprobe 336
 #endif
=20
-static void test_uprobe_sigill(void)
+static void test_uprobe_error(void)
 {
-	int status, err, pid;
+	long err =3D syscall(__NR_uprobe);
=20
-	pid =3D fork();
-	if (!ASSERT_GE(pid, 0, "fork"))
-		return;
-	/* child */
-	if (pid =3D=3D 0) {
-		asm volatile (
-			"pushq %rax\n"
-			"pushq %rcx\n"
-			"pushq %r11\n"
-			"movq $" __stringify(__NR_uprobe) ", %rax\n"
-			"syscall\n"
-			"popq %r11\n"
-			"popq %rcx\n"
-			"retq\n"
-		);
-		exit(0);
-	}
-
-	err =3D waitpid(pid, &status, 0);
-	ASSERT_EQ(err, pid, "waitpid");
-
-	/* verify the child got killed with SIGILL */
-	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
-	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+	ASSERT_EQ(err, -1, "error");
+	ASSERT_EQ(errno, ENXIO, "errno");
 }
=20
 static void __test_uprobe_syscall(void)
@@ -805,8 +783,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
-	if (test__start_subtest("uprobe_sigill"))
-		test_uprobe_sigill();
+	if (test__start_subtest("uprobe_error"))
+		test_uprobe_error();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
 	if (test__start_subtest("regs_change"))

