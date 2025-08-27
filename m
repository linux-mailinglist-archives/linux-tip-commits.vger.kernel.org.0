Return-Path: <linux-tip-commits+bounces-6379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4BB37AA8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1D3363756
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A8313E0A;
	Wed, 27 Aug 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Hm4dtKH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9BuzbUAw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181131353D;
	Wed, 27 Aug 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277129; cv=none; b=RivxoSODuLVPI7UM6l8yxZBbPsHtXY+bkRiF1eV6+js0qm1pVHrBcJZysXZWDzDRbv6fKAy6BCwYLXiE1el9oxrM4hlnGHtkiV8HIHzoVpfjpoVfr+XzxKI7/p3ue4aAC3uKAcCzhWGdpakBY4WF+m0uV5zilWOlepDfnNayg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277129; c=relaxed/simple;
	bh=GWDIt5Yd1geTLSFXEC8aLwv7wIDg4c3CJlqjZMGs24M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JxPqo+t4eQieGh8nlai+D6JK2Ijt1P07pslY5rHHPY5afKxQs12Up5xAqVWlPqdxIspmiex3DStFpCNrDboJKTRFOY2yFMnVfo7d5hETGOYaXutyHmDp9E7cYq6zOSy4ZUAs2XpG5oY6bPtpDrgdf+kQeyReBXqcSaFbzCqx6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Hm4dtKH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9BuzbUAw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8Ukqyvd+OGeKePNxCH4M4TJFM6rCXhz+TBBoMGRuXU=;
	b=2Hm4dtKHKbI3thjLOUCpzYZdUB7CjXQUHYMRk9LcklaEx4Cr8Pau+GRRcmruT9n1C9oJ7s
	NBwSyHdhww9CUMRHbFNlCrksirA8QrLkXEVXM4TafzaqdgRpbbh6GQZC5aY4I3Rsf4eMI+
	/CcW/PAzNyyINc1yfLqxHD6mpsfLmOGrTe3EhCK4cfJ1DZ65MqVfciaYqYOqWFeh8Ti9bh
	HNpm5E9tyVmdCRtNN8Vzxrm5uGG8ySezwTHU0AUsiEnvo5TNhaVffTAQByE33GO8WCv/xs
	GDdTpYo/0/za1XopmT4+BZ6jJQZ9frQZyjy2fB28Qo6s7d0Ox4GUE6+R6Sq1GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8Ukqyvd+OGeKePNxCH4M4TJFM6rCXhz+TBBoMGRuXU=;
	b=9BuzbUAwWXRqXKgpkV+WJNXkep02jbe1qlVEZaoLfL62LPBl6+3THttzoM98FiupTpxzfw
	A6dGGlK8URYZbEBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Remove get_perf_callchain() init_nr argument
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <Namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820180428.259565081@kernel.org>
References: <20250820180428.259565081@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627712412.1920.4086929344484646307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e649bcda25b5ae1a30a182cc450f928a0b282c93
Gitweb:        https://git.kernel.org/tip/e649bcda25b5ae1a30a182cc450f928a0b2=
82c93
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 20 Aug 2025 14:03:39 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 09:51:12 +02:00

perf: Remove get_perf_callchain() init_nr argument

The 'init_nr' argument has double duty: it's used to initialize both the
number of contexts and the number of stack entries.  That's confusing
and the callers always pass zero anyway.  Hard code the zero.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <Namhyung@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20250820180428.259565081@kernel.org
---
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 12 ++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bfbf9ea..fd1d910 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1719,7 +1719,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callc=
hain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, stru=
ct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, st=
ruct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06..ec3a57a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,7 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struc=
t bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth =3D sysctl_perf_event_max_stack;
=20
-	trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
+	trace =3D get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false);
=20
 	if (unlikely(!trace))
@@ -451,7 +451,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct =
task_struct *task,
 	else if (kernel && task)
 		trace =3D get_callchain_entry_for_task(task, max_depth);
 	else
-		trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
+		trace =3D get_perf_callchain(regs, kernel, user, max_depth,
 					   crosstask, false);
=20
 	if (unlikely(!trace) || trace->nr < skip) {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6c83ad6..b0f5bd2 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct per=
f_callchain_entry *entr
 }
=20
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
@@ -228,11 +228,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, b=
ool kernel, bool user,
 	if (!entry)
 		return NULL;
=20
-	ctx.entry     =3D entry;
-	ctx.max_stack =3D max_stack;
-	ctx.nr	      =3D entry->nr =3D init_nr;
-	ctx.contexts       =3D 0;
-	ctx.contexts_maxed =3D false;
+	ctx.entry		=3D entry;
+	ctx.max_stack		=3D max_stack;
+	ctx.nr			=3D entry->nr =3D 0;
+	ctx.contexts		=3D 0;
+	ctx.contexts_maxed	=3D false;
=20
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ea35704..bade8e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8210,7 +8210,7 @@ perf_callchain(struct perf_event *event, struct pt_regs=
 *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
=20
-	callchain =3D get_perf_callchain(regs, 0, kernel, user,
+	callchain =3D get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }

