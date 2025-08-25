Return-Path: <linux-tip-commits+bounces-6352-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B078B33CA3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9FA17F021
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57C2E2DD8;
	Mon, 25 Aug 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AD0Oj3cw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O66oKDgF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B612E282F;
	Mon, 25 Aug 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117490; cv=none; b=s+ZHGPyXzvnNp7POyJazURBK49agYrHBaVzGv0b0oJ8rN0Nue7t/5HHDwfiNd1wZmBzbC5YrQ+8ZsFEP3KZiOblfNJZSge3jyHACtRat9Dzb/LR1TeFPI9opdGHwDysbkhmti42SYXFYWCfsV+ODSoxrHCShO0hF6eY0s824ZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117490; c=relaxed/simple;
	bh=q6GAIYiiZXZtBWX/plEO6NwiBGZbJgSVcLQh3DCcvvE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dwtUP8SjP+teoIMsAlhNf8ca+SFGqD5LxHkkte/lqB2WkA3LRfB73OWq4DIyLC6MXC0cUICX6IMuvLE8vYappFJxUtNhnt65ELtQD6JRy8d5l5WFiWTXKh0p3/ca8JnbWH75We4nUFQTATRT/sbxLMLOh7v0fryJ9ZMBaB+vBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AD0Oj3cw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O66oKDgF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQG2s2fcw+WyXUGh+WVD1I4V135oXPJX+9WC657EZVk=;
	b=AD0Oj3cwMosnQXB/SZx1U0L5h5IiRNNQCh4RQXNBsGWEOxgtvOBnYcR0m3Z8wyXi874GpQ
	Crw8r+lKdwntlZIS0OzyNZNyP+s4auuptVLazYchjSEzeR21LNOuvipPtkzbFKkmCjreus
	ywpNc31+H8O+guKH2npcXuyeT2fPcMdjqRSFE7EzdET7xTmhBSKrSo/ieuD1B0J8PlTjpp
	qOGVEWAlZ4Whj+ju3ApxLQ262P6wfjb8Ln0zrNQ+47Rc5cIEpW9HzoFACV4JleOiw2FJQn
	K02L+Ld8/XaD9IlqtZb5CxA0t5Rr2r4fmqbHVzQij0v9Kn5Bwqc8cvk4vxvduA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQG2s2fcw+WyXUGh+WVD1I4V135oXPJX+9WC657EZVk=;
	b=O66oKDgFjdbnTf3mhHDLhJ9ziVuh4KydeZj4n2NTYxixOCORaUn+8DqqopTktlW5Qi5eGp
	lPY7h4wYYpmd5nBQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Add hit/attach/detach race optimized
 uprobe test
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-16-jolsa@kernel.org>
References: <20250720112133.244369-16-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611748550.1420.9785267213817759320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c8be59667cf17f281adc9a9387d7a0de60268fcd
Gitweb:        https://git.kernel.org/tip/c8be59667cf17f281adc9a9387d7a0de602=
68fcd
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:24 +02:00

selftests/bpf: Add hit/attach/detach race optimized uprobe test

Adding test that makes sure parallel execution of the uprobe and
attach/detach of optimized uprobe on it works properly.

By default the test runs for 500ms, which is adjustable by using
BPF_SELFTESTS_UPROBE_SYSCALL_RACE_MSEC env variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-16-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 108 +++++++-
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index b91135a..3d27c8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -15,6 +15,7 @@
 #include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
+#include "bpf/libbpf_internal.h"
=20
 #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
 #include "usdt.h"
@@ -629,6 +630,111 @@ static void test_uretprobe_shadow_stack(void)
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
=20
+static volatile bool race_stop;
+
+static USDT_DEFINE_SEMA(race);
+
+static void *worker_trigger(void *arg)
+{
+	unsigned long rounds =3D 0;
+
+	while (!race_stop) {
+		uprobe_test();
+		rounds++;
+	}
+
+	printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
+	return NULL;
+}
+
+static void *worker_attach(void *arg)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct uprobe_syscall_executed *skel;
+	unsigned long rounds =3D 0, offset;
+	const char *sema[2] =3D {
+		__stringify(USDT_SEMA(race)),
+		NULL,
+	};
+	unsigned long *ref;
+	int err;
+
+	offset =3D get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return NULL;
+
+	err =3D elf_resolve_syms_offsets("/proc/self/exe", 1, (const char **) &sema=
, &ref, STT_OBJECT);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_sema"))
+		return NULL;
+
+	opts.ref_ctr_offset =3D *ref;
+
+	skel =3D uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return NULL;
+
+	skel->bss->pid =3D getpid();
+
+	while (!race_stop) {
+		skel->links.test_uprobe =3D bpf_program__attach_uprobe_opts(skel->progs.te=
st_uprobe,
+					0, "/proc/self/exe", offset, &opts);
+		if (!ASSERT_OK_PTR(skel->links.test_uprobe, "bpf_program__attach_uprobe_op=
ts"))
+			break;
+
+		bpf_link__destroy(skel->links.test_uprobe);
+		skel->links.test_uprobe =3D NULL;
+		rounds++;
+	}
+
+	printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, skel->bss-=
>executed);
+	uprobe_syscall_executed__destroy(skel);
+	free(ref);
+	return NULL;
+}
+
+static useconds_t race_msec(void)
+{
+	char *env;
+
+	env =3D getenv("BPF_SELFTESTS_UPROBE_SYSCALL_RACE_MSEC");
+	if (env)
+		return atoi(env);
+
+	/* default duration is 500ms */
+	return 500;
+}
+
+static void test_uprobe_race(void)
+{
+	int err, i, nr_threads;
+	pthread_t *threads;
+
+	nr_threads =3D libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_threads, 0, "libbpf_num_possible_cpus"))
+		return;
+	nr_threads =3D max(2, nr_threads);
+
+	threads =3D alloca(sizeof(*threads) * nr_threads);
+	if (!ASSERT_OK_PTR(threads, "malloc"))
+		return;
+
+	for (i =3D 0; i < nr_threads; i++) {
+		err =3D pthread_create(&threads[i], NULL, i % 2 ? worker_trigger : worker_=
attach,
+				     NULL);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto cleanup;
+	}
+
+	usleep(race_msec() * 1000);
+
+cleanup:
+	race_stop =3D true;
+	for (nr_threads =3D i, i =3D 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	ASSERT_FALSE(USDT_SEMA_IS_ACTIVE(race), "race_semaphore");
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -647,6 +753,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_session();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
+	if (test__start_subtest("uprobe_race"))
+		test_uprobe_race();
 }
 #else
 static void __test_uprobe_syscall(void)

