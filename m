Return-Path: <linux-tip-commits+bounces-2858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D089C870E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C75B2A201
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD31F80C5;
	Thu, 14 Nov 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOl+ttev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItvZN+3Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99A1EE021;
	Thu, 14 Nov 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578473; cv=none; b=jlnQy9S26UqaTisJdSg33n1R6Omt3A5wxYAno7K4ekB7Xja1Dn4vZIC5uq7/o4t7AnQqgZa1wciwv6qpa+FO5aguRB9TVxXZQPAmoognXpOy4tJw2C5pZUCtrCM+6BL+ZejmPDA1NcLwujxSnABmf0TNWiG2qtcNUXo+vLWWrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578473; c=relaxed/simple;
	bh=+9maWGnDtGxQqRKkD9WpNrTehZ2fRUBOZ21myTMiPvU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uTyAo0nsYzP3I+1qM7z8w1u9OeueVbz3g5FiJ8g4HhiMYj9Ft2QS0FjPDnLB10sR/BMWMKGk414AwMYLGSl61GAff82eGP3AIS525yOjWqVdrbBL7bvfzBtRXERc5Y1e7f31L1Uau7Vm640pxsPxb8zFMc+I4hPzVYPN/qah6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOl+ttev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ItvZN+3Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 10:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731578469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzR1SwtuNXrbrrivncUZe2RfYEvCY5BNw6dNVf++9Q8=;
	b=SOl+ttevqEwKfTkARMQA2nQiB3ZZdMqUjfEoF9vMUstqZmnJLmochZ9pDTUCAe3miq9OVd
	6dhyGEoIzj9nFH9Yql6Q8HbAosS2SxorS0yJuHkN6HxSOUTD38b/1F7IC6aGcNIuaUmW4O
	nZaG/RZgZkNhmbtKz4/woW7PNxwhdYe69BpVug8Fp6oRtM01csdsUBXCf/ycBfy1ERoiIb
	byY+Pn3OElF6/eDqjVdxU+1JgmWY3Mfm1RnfmpVLP26mzjqwJGceIB3bO+H+oyjoB1zteY
	JbypJvfZGbkyXiusFOl4+gDdLjSWiLboha+f5Mb1r/cmS7zMY+ECbeyjHZer8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731578469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzR1SwtuNXrbrrivncUZe2RfYEvCY5BNw6dNVf++9Q8=;
	b=ItvZN+3QX6hEkefEs67TlEDy55glIunyl2R9QKrFpROpaZz5N8gzTRTRJKH6j0Ovx93kOe
	t1Y6byD/ehO3GYAQ==
From: "tip-bot2 for Colton Lewis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Correct perf sampling with guest VMs
Cc: Colton Lewis <coltonlewis@google.com>, Ingo Molnar <mingo@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241113190156.2145593-6-coltonlewis@google.com>
References: <20241113190156.2145593-6-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173157846818.32228.5948984956333374783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2c47e7a74f445426d156278e339b7abb259e50de
Gitweb:        https://git.kernel.org/tip/2c47e7a74f445426d156278e339b7abb259e50de
Author:        Colton Lewis <coltonlewis@google.com>
AuthorDate:    Wed, 13 Nov 2024 19:01:55 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 14 Nov 2024 10:40:01 +01:00

perf/core: Correct perf sampling with guest VMs

Previously any PMU overflow interrupt that fired while a VCPU was
loaded was recorded as a guest event whether it truly was or not. This
resulted in nonsense perf recordings that did not honor
perf_event_attr.exclude_guest and recorded guest IPs where it should
have recorded host IPs.

Rework the sampling logic to only record guest samples for events with
exclude_guest = 0. This way any host-only events with exclude_guest
set will never see unexpected guest samples. The behaviour of events
with exclude_guest = 0 is unchanged.

Note that events configured to sample both host and guest may still
misattribute a PMI that arrived in the host as a guest event depending
on KVM arch and vendor behavior.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20241113190156.2145593-6-coltonlewis@google.com
---
 arch/arm64/include/asm/perf_event.h |  4 +----
 arch/arm64/kernel/perf_callchain.c  | 28 +----------------------------
 arch/x86/events/core.c              |  3 +---
 include/linux/perf_event.h          | 21 +++++++++++++++++++--
 kernel/events/core.c                | 21 +++++++++++++++++----
 5 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 31a5584..ee45b4e 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -10,10 +10,6 @@
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
-#define perf_arch_misc_flags(regs)	perf_misc_flags(regs)
 #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 #endif
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 01a9d08..9b7f26b 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -38,31 +38,3 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 
 	arch_stack_walk(callchain_trace, entry, current, regs);
 }
-
-unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
-{
-	if (perf_guest_state())
-		return perf_guest_get_ip();
-
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_arch_misc_flags(struct pt_regs *regs)
-{
-	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
-
-	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
-
-	return misc;
-}
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bfc0a35..c75c482 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3005,9 +3005,6 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 
 unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 {
-	if (perf_guest_state())
-		return perf_guest_get_ip();
-
 	return regs->ip + code_segment_base(regs);
 }
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3b4bf5e..cb99ec8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1676,8 +1676,9 @@ extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  struct task_struct *task);
 extern void perf_bp_event(struct perf_event *event, void *data);
 
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_misc_flags(struct perf_event *event, struct pt_regs *regs);
+extern unsigned long perf_instruction_pointer(struct perf_event *event,
+					      struct pt_regs *regs);
 
 #ifndef perf_arch_misc_flags
 # define perf_arch_misc_flags(regs) \
@@ -1688,6 +1689,22 @@ extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 # define perf_arch_bpf_user_pt_regs(regs) regs
 #endif
 
+#ifndef perf_arch_guest_misc_flags
+static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+
+	if (!(guest_state & PERF_GUEST_ACTIVE))
+		return 0;
+
+	if (guest_state & PERF_GUEST_USER)
+		return PERF_RECORD_MISC_GUEST_USER;
+	else
+		return PERF_RECORD_MISC_GUEST_KERNEL;
+}
+# define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
+#endif
+
 static inline bool has_branch_stack(struct perf_event *event)
 {
 	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6050ce0..1869164 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7026,13 +7026,26 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 #endif
 
-unsigned long perf_misc_flags(struct pt_regs *regs)
+static bool should_sample_guest(struct perf_event *event)
 {
+	return !event->attr.exclude_guest && perf_guest_state();
+}
+
+unsigned long perf_misc_flags(struct perf_event *event,
+			      struct pt_regs *regs)
+{
+	if (should_sample_guest(event))
+		return perf_arch_guest_misc_flags(regs);
+
 	return perf_arch_misc_flags(regs);
 }
 
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
+unsigned long perf_instruction_pointer(struct perf_event *event,
+				       struct pt_regs *regs)
 {
+	if (should_sample_guest(event))
+		return perf_guest_get_ip();
+
 	return perf_arch_instruction_pointer(regs);
 }
 
@@ -7853,7 +7866,7 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
-		data->ip = perf_instruction_pointer(regs);
+		data->ip = perf_instruction_pointer(event, regs);
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
 
@@ -8017,7 +8030,7 @@ void perf_prepare_header(struct perf_event_header *header,
 {
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = perf_sample_data_size(data, event);
-	header->misc = perf_misc_flags(regs);
+	header->misc = perf_misc_flags(event, regs);
 
 	/*
 	 * If you're adding more sample types here, you likely need to do

