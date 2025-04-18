Return-Path: <linux-tip-commits+bounces-5057-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E2A93355
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 09:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1DB7B35B1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 07:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18F25744F;
	Fri, 18 Apr 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RWZ4Tjww";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmnEgmHu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D62116E0;
	Fri, 18 Apr 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960505; cv=none; b=fb4ESZLAg+k7hQ8TTMUrgD9YT/2kkB9+X+ZgJY3bgxOTz8pWqZnGnNs8hVeLzm4gv/95JXZx5mWvFmYUoH5Ym93ydIaZCZH8Kv6b/Qf07/gvA7p5VqPAkzfvaGpFjQQBk5LdTAW/Y5mZNcbpvHQ3bBVtRIuOVx+y7bhSGSxH+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960505; c=relaxed/simple;
	bh=goFcXiNu6hwu2tVjllltb0m7Z1D+rJMKVeb2Mv0o620=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=peM5nJiWdPXa+KiS/qGZobyS9BeJo/kzOrrH/bHjGAgWYAz+rKhfINdLcACIIm7WU6eik4TGoDVdCJJ2ARp9mjSgBwmoPgUAHuBb1jXFokXin4BkVGfvDjPFbICRh3NtrYSauv0eKt2g/Ep90ZEZzPfwNeKNnVbD2QE5rFOPVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RWZ4Tjww; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmnEgmHu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 07:15:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744960502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTYLGJMnZirVFG1sTedDkjiRPCL5mxWjS2oGscgpDtU=;
	b=RWZ4Tjww1lXB3aYPIlpDzQ0Jm9iChrvLNhsgwxWalZCIZp8Iw3FWoKPJevALCSOsM2Psqn
	/Ml4cTOxiN8NMhovtaKNusN+vppSXTbjDtpMzKZlFhvom78iIZeqZ5f+f+AABsr4pRLf2Q
	BRFXzuFCfhuuRnzGrbqjKh0EKDhkpDpx83YzRizAdAXz0/+UQrRXdyNVNwK8XAM6PaK59w
	HT5Gu8ndMeRUul/mtyZKB8DIpojYpMrVULaJGyRe3b9WDOAIMXmsL3foBYW6TP3Rloj0d+
	aVZh2fPzx0GZNlXtPn8fr4fwPy7b2qMeKJ8OLrye3XNxbeQouW74DSxzyYTDZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744960502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTYLGJMnZirVFG1sTedDkjiRPCL5mxWjS2oGscgpDtU=;
	b=KmnEgmHud3fQOdgwUUibxxNPkH8CtU2IaTVfPhR3V47kW8xKJWcxwx7TTd/qxgL6Itae0h
	Ds7/lU2DMI2NfcCg==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] selftests/bpf: Add 5-byte NOP uprobe trigger benchmark
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250414083647.1234007-2-jolsa@kernel.org>
References: <20250414083647.1234007-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496050005.31282.10614285702352344746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fe8e5a3215ccd8e54ce0a9df1b89d4ab42ad8fec
Gitweb:        https://git.kernel.org/tip/fe8e5a3215ccd8e54ce0a9df1b89d4ab42ad8fec
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 14 Apr 2025 10:36:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 09:03:45 +02:00

selftests/bpf: Add 5-byte NOP uprobe trigger benchmark

Add a 5-byte NOP uprobe trigger benchmark (x86_64 specific) to measure
uprobes/uretprobes on top of NOP5 instructions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Link: https://lore.kernel.org/r/20250414083647.1234007-2-jolsa@kernel.org
---
 tools/testing/selftests/bpf/bench.c                     | 12 ++-
 tools/testing/selftests/bpf/benchs/bench_trigger.c      | 42 ++++++++-
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a..0fd8c9b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -526,6 +526,12 @@ extern const struct bench bench_trig_uprobe_multi_push;
 extern const struct bench bench_trig_uretprobe_multi_push;
 extern const struct bench bench_trig_uprobe_multi_ret;
 extern const struct bench bench_trig_uretprobe_multi_ret;
+#ifdef __x86_64__
+extern const struct bench bench_trig_uprobe_nop5;
+extern const struct bench bench_trig_uretprobe_nop5;
+extern const struct bench bench_trig_uprobe_multi_nop5;
+extern const struct bench bench_trig_uretprobe_multi_nop5;
+#endif
 
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
@@ -586,6 +592,12 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_multi_push,
 	&bench_trig_uprobe_multi_ret,
 	&bench_trig_uretprobe_multi_ret,
+#ifdef __x86_64__
+	&bench_trig_uprobe_nop5,
+	&bench_trig_uretprobe_nop5,
+	&bench_trig_uprobe_multi_nop5,
+	&bench_trig_uretprobe_multi_nop5,
+#endif
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 32e9f19..8232765 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -333,6 +333,20 @@ static void *uprobe_producer_ret(void *input)
 	return NULL;
 }
 
+#ifdef __x86_64__
+__nocf_check __weak void uprobe_target_nop5(void)
+{
+	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
+}
+
+static void *uprobe_producer_nop5(void *input)
+{
+	while (true)
+		uprobe_target_nop5();
+	return NULL;
+}
+#endif
+
 static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
 {
 	size_t uprobe_offset;
@@ -448,6 +462,28 @@ static void uretprobe_multi_ret_setup(void)
 	usetup(true, true /* use_multi */, &uprobe_target_ret);
 }
 
+#ifdef __x86_64__
+static void uprobe_nop5_setup(void)
+{
+	usetup(false, false /* !use_multi */, &uprobe_target_nop5);
+}
+
+static void uretprobe_nop5_setup(void)
+{
+	usetup(true, false /* !use_multi */, &uprobe_target_nop5);
+}
+
+static void uprobe_multi_nop5_setup(void)
+{
+	usetup(false, true /* use_multi */, &uprobe_target_nop5);
+}
+
+static void uretprobe_multi_nop5_setup(void)
+{
+	usetup(true, true /* use_multi */, &uprobe_target_nop5);
+}
+#endif
+
 const struct bench bench_trig_syscall_count = {
 	.name = "trig-syscall-count",
 	.validate = trigger_validate,
@@ -506,3 +542,9 @@ BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprobe-multi-ret");
 BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
 BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
 BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
+#ifdef __x86_64__
+BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5");
+BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
+BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
+BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
+#endif
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
index af169f8..03f5540 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret}
+for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,nop5}
 do
 	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-15s: %s\n" $i "$summary"

