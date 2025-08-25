Return-Path: <linux-tip-commits+bounces-6354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479AB33CA6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912B1175E7C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A972E3709;
	Mon, 25 Aug 2025 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y3ko/4Oz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U00yL3Uv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6692E2DF1;
	Mon, 25 Aug 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117492; cv=none; b=NnUQM7ndjVAL6NoGYcKxtLn/hKZvjNvOeTghVB9ggoZTgxJrlaSDx4o43OXrgqzYznWcJ3wiYmsMu/FhHFwuxRAZSW09G83tzetfxHnNWPmX1qy1aFjYwREC8iYV/xI+3dKPt7nJiVWhhDSy1Nsk7qq/weDuNF1K+yee33bh/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117492; c=relaxed/simple;
	bh=D4YRSdch5kTSV08oUmcqreQA7dpNvKNawVHhPdQvGx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JHPEg1zw0tZyLWdqD1CFJ/d6VGMeh6ib/GvMlNxQ9FPjDKbz/YlM1BlqqOjYqI0NcfwxGFeyrsO9q77WuoDs4wj1mUaYL6utPyoIZAQlDYII0Fmi4V7k25NHKJCAeaQBlINGofGnRHYNxm5YzwqvNOqB3sObtP7PX+5PhM8pFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y3ko/4Oz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U00yL3Uv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc7QPtPDRVw8jz4XxevpCkqwEIuYdG+0fH9GSRztaUI=;
	b=Y3ko/4OzGE03SFXLGVp+rgHzh0phtVIexsaE/r7sPTQEFjXSw/ntgP+2wDocCpDpkrjeob
	IxsYI2UrHeO/jPAPp+Ou2oV5rAuAQfwPy/N2Pgh85cEE7HDlq3OV10KSwA4VRifAkRS63p
	yPzsnEqhtWxfg+V/koXGHj26KgTFzpjqq+QfmnvlCnPkhe/n0XFIy0+RatuGVUYw8uTKDh
	WkcMVTusbnc0MhI5BIuxj0SC9fhHERkESuQhEKIEqLCibL7FkOKFv33PkWa7gkoYOYJ7KY
	+O3xBQMd3AFDij9HwpbO7eiLB5hq/AYuICTZ2F7vsOE4nyTb9RDC2SRbsxkjXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc7QPtPDRVw8jz4XxevpCkqwEIuYdG+0fH9GSRztaUI=;
	b=U00yL3Uvrp5pgVGOZxcC2qK3A36PEf5Jx6lWJrk7KDTKkNVT2ParsSAS3n9TG/C1iEToPw
	YhMz9CiGws/Rf5Bw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Rename uprobe_syscall_executed prog
 to test_uretprobe_multi
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-14-jolsa@kernel.org>
References: <20250720112133.244369-14-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748780.1420.16967706840831656025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7932c4cf577187dec42ddfba0aba26434cecab0c
Gitweb:        https://git.kernel.org/tip/7932c4cf577187dec42ddfba0aba26434ce=
cab0c
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:23 +02:00

selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi

Renaming uprobe_syscall_executed prog to test_uretprobe_multi
to fit properly in the following changes that add more programs.

Plus adding pid filter and increasing executed variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-14-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 12 ++++---
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  8 +++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index a8f00ae..6d58a44 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -252,6 +252,7 @@ static void test_uretprobe_syscall_call(void)
 	);
 	struct uprobe_syscall_executed *skel;
 	int pid, status, err, go[2], c =3D 0;
+	struct bpf_link *link;
=20
 	if (!ASSERT_OK(pipe(go), "pipe"))
 		return;
@@ -277,11 +278,14 @@ static void test_uretprobe_syscall_call(void)
 		_exit(0);
 	}
=20
-	skel->links.test =3D bpf_program__attach_uprobe_multi(skel->progs.test, pid,
-							    "/proc/self/exe",
-							    "uretprobe_syscall_call", &opts);
-	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+	skel->bss->pid =3D pid;
+
+	link =3D bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+						pid, "/proc/self/exe",
+						"uretprobe_syscall_call", &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
+	skel->links.test_uretprobe_multi =3D link;
=20
 	/* kick the child */
 	write(go[1], &c, 1);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/to=
ols/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 0d7f1a7..8f48976 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -8,10 +8,14 @@ struct pt_regs regs;
 char _license[] SEC("license") =3D "GPL";
=20
 int executed =3D 0;
+int pid;
=20
 SEC("uretprobe.multi")
-int test(struct pt_regs *regs)
+int test_uretprobe_multi(struct pt_regs *ctx)
 {
-	executed =3D 1;
+	if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
+		return 0;
+
+	executed++;
 	return 0;
 }

