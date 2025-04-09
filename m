Return-Path: <linux-tip-commits+bounces-4781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC8A823C8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A6A1B873A6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19425E466;
	Wed,  9 Apr 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZQ3IKxu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkx1pnP4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F725E45E;
	Wed,  9 Apr 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199002; cv=none; b=nPxKtVDQn1u1145SWRpGYuVa0sndZbMLkton/ekpXOk92sRzcarG8VCl3EBADnoxn8F+oox2vzgFooIlJUQK4M1RdIcM0JJdB9G1TY3zk8Orpji5WXc/VPAIDnr2wDaLaRypJtwwQKHHkG9Seh4UuPcmPN5gosFRglUgLgIXr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199002; c=relaxed/simple;
	bh=aJOag9ASxHvirCT2u4zbc7pg2RBIJ3Jw97Q5+pSxEUw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S4iDfwl/oOxqh3cT0sOnZ3yd7IjnOeBNlKhuvpGwifb6ZVpt5wJslShelk6YABc1HiQcb7zDRxtmbdj9Lxa5ngaSg/bGvbEeFNUjdh86xAgFg7IjCj7V1vjYg5CmTwKUHJ2TtVUB485xfwoQQFZfLh7hx5FAfGL0FYDef3fY9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZQ3IKxu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkx1pnP4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:43:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744198998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izhp7rhvh9YWUTw9iH+xQIRX4fBPegO/TuRjYGgRPVE=;
	b=TZQ3IKxur7JfwTYDvVU2BpyOYz4wZ+rm+H+bMlPohTQjD943vc64HK1R7l6P0NQOSH5zTP
	udM/7GmyFwk4asZdh81BcRwrhkKKtmsU8gQz1qUap4044OSFNqkCJtiRI8n3n/G9KMKl3y
	B44Hvb4HgU3H7xkxUpgYGX/WrGGecvVSvbiYsO30oembuLXSKy8h+x6IZUZKzJp3v09kPa
	8XLr2b6JScS4ETp1l/bo0f3Jf76HxHW3ZTUUlnfpw8Ol9dt70K2H0pVOaV5wnfVoBpqEaf
	zyNzDh001LHrQHbRJ5NXpKCEwtY+KYSFZ/eWE4rlZ02c/epRTD+lXFkv0SE10Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744198998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izhp7rhvh9YWUTw9iH+xQIRX4fBPegO/TuRjYGgRPVE=;
	b=dkx1pnP4sMUqi8Yf69ot82QX8Ck79DmHDtH1vBI98A6fLAB5kQ5wVRof0QQGGUqckmNij5
	C3LV6s6gO2jvUODw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Add 5-byte NOP uprobe trigger bench
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250408211310.51491-2-jolsa@kernel.org>
References: <20250408211310.51491-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419899807.31282.15110251531060345835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4524b6faab3c53b11573196cbb2aee961e7499c3
Gitweb:        https://git.kernel.org/tip/4524b6faab3c53b11573196cbb2aee961e7499c3
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 23:13:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:35:17 +02:00

selftests/bpf: Add 5-byte NOP uprobe trigger bench

Add 5-byte NOP uprobe trigger bench (x86_64 specific) to measure
uprobes/uretprobes on top of NOP5 instruction.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250408211310.51491-2-jolsa@kernel.org
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

