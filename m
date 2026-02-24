Return-Path: <linux-tip-commits+bounces-8255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLTYDnadnWnwQgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 13:45:42 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F4187292
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81F13066E5B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098C3815C2;
	Tue, 24 Feb 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTnDD5pG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkPG6Tuu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066124E4AF;
	Tue, 24 Feb 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936939; cv=none; b=PcaRgea3k2rBMFHE4moKTAzfXqyJKnNI28usWQYD9rpKanO+2yt8IcwNX2ryLhBt4yS/6dqHu05Fpgzd5atBkuUebuggLkH8/3+J8Bpvml9HpooXorTuqdJ7O2VTxGWJ6FLXREijtoNWX1yEbQdChLFqo+zjR2wsvkUzJJROZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936939; c=relaxed/simple;
	bh=nkeNOXD9doKVj0xFbW2ypNrgoFXwiSOCZKMFfDPQP6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sET+thjphvleFB0hhDyLpCwh3oLq2VUM4umqby8+N0FdhLraQfDVZ9EKtvNRQk6lORNeiZwA9btf562VSU5/25BhY7gJqUHXstBEsKO+oUrKv6g2AOj4j0apJWgtJtp25A0Cql8796OeOhMn/w1IAYVtLKejL5KoJeaz2EL7iZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTnDD5pG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkPG6Tuu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 12:42:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771936936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqHI/AV1+OOPHmqaQNovcxBkesAlwsmNhixu95XL+CQ=;
	b=jTnDD5pGvlpY4fgFyKdJPOFmznseuRj8jrHbqIy9gOlmpX0IgRBhC1IJ6Wo+NfN4FndvXc
	BCy2sdIr77VfdajK3FBMcrgtOpwx1CQr4wtPDbroimy4Nboi3cYfQex9rH6kn3g7PFkv6k
	/y6CShmdT2cFOy3HufhGh3WMXFhMvDKMa59k4ISsHRswBoW5mL9U6AB4SacEbmQPLZn0wk
	rQCakR0fYKdcdSnc6WQzW00yOgT7BgYHuZ7FwTlWmdYeIalPyOcuLEzttdTRg3w0C3t9j8
	t+68kJbKy/g6CBhPC50pSGLnBA30zRnq6qWdwqlh4CcqNAuALqPDLKT+LHE6uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771936936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqHI/AV1+OOPHmqaQNovcxBkesAlwsmNhixu95XL+CQ=;
	b=JkPG6TuusmBdEu+KXeqr25WSepgV72GxfXlKMijorULo5RVkaDRWs1AYEpwxMA2kXaBnRh
	wxYgzJuHwICFymDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix __perf_event_overflow() vs
 perf_remove_from_context() race
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224122909.GV1395416@noisy.programming.kicks-ass.net>
References: <20260224122909.GV1395416@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177193693533.1647592.7685534417475059133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8255-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email]
X-Rspamd-Queue-Id: 927F4187292
X-Rspamd-Action: no action

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     64a6eb7e10513f371cdb26aa155b562e6556c8a2
Gitweb:        https://git.kernel.org/tip/64a6eb7e10513f371cdb26aa155b562e655=
6c8a2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 13:29:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Feb 2026 13:39:28 +01:00

perf: Fix __perf_event_overflow() vs perf_remove_from_context() race

Make sure that __perf_event_overflow() runs with IRQs disabled for all
possible callchains. Specifically the software events can end up running
it with only preemption disabled.

This opens up a race vs perf_event_exit_event() and friends that will go
and free various things the overflow path expects to be present, like
the BPF program.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224122909.GV1395416@noisy.programming.kic=
ks-ass.net
---
 kernel/events/core.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22a0f40..1f5699b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10777,6 +10777,13 @@ int perf_event_overflow(struct perf_event *event,
 			struct perf_sample_data *data,
 			struct pt_regs *regs)
 {
+	/*
+	 * Entry point from hardware PMI, interrupts should be disabled here.
+	 * This serializes us against perf_event_remove_from_context() in
+	 * things like perf_event_release_kernel().
+	 */
+	lockdep_assert_irqs_disabled();
+
 	return __perf_event_overflow(event, 1, data, regs);
 }
=20
@@ -10853,6 +10860,19 @@ static void perf_swevent_event(struct perf_event *ev=
ent, u64 nr,
 {
 	struct hw_perf_event *hwc =3D &event->hw;
=20
+	/*
+	 * This is:
+	 *   - software		preempt
+	 *   - tracepoint	preempt
+	 *   -   tp_target_task	irq (ctx->lock)
+	 *   - uprobes		preempt/irq
+	 *   - kprobes		preempt/irq
+	 *   - hw_breakpoint	irq
+	 *
+	 * Any of these are sufficient to hold off RCU and thus ensure @event
+	 * exists.
+	 */
+	lockdep_assert_preemption_disabled();
 	local64_add(nr, &event->count);
=20
 	if (!regs)
@@ -10861,6 +10881,16 @@ static void perf_swevent_event(struct perf_event *ev=
ent, u64 nr,
 	if (!is_sampling_event(event))
 		return;
=20
+	/*
+	 * Serialize against event_function_call() IPIs like normal overflow
+	 * event handling. Specifically, must not allow
+	 * perf_event_release_kernel() -> perf_remove_from_context() to make
+	 * progress and 'release' the event from under us.
+	 */
+	guard(irqsave)();
+	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+		return;
+
 	if ((event->attr.sample_type & PERF_SAMPLE_PERIOD) && !event->attr.freq) {
 		data->period =3D nr;
 		return perf_swevent_overflow(event, 1, data, regs);
@@ -11359,6 +11389,11 @@ void perf_tp_event(u16 event_type, u64 count, void *=
record, int entry_size,
 	struct perf_sample_data data;
 	struct perf_event *event;
=20
+	/*
+	 * Per being a tracepoint, this runs with preemption disabled.
+	 */
+	lockdep_assert_preemption_disabled();
+
 	struct perf_raw_record raw =3D {
 		.frag =3D {
 			.size =3D entry_size,
@@ -11691,6 +11726,11 @@ void perf_bp_event(struct perf_event *bp, void *data)
 	struct perf_sample_data sample;
 	struct pt_regs *regs =3D data;
=20
+	/*
+	 * Exception context, will have interrupts disabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
 	perf_sample_data_init(&sample, bp->attr.bp_addr, 0);
=20
 	if (!bp->hw.state && !perf_exclude_event(bp, regs))
@@ -12155,7 +12195,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(stru=
ct hrtimer *hrtimer)
=20
 	if (regs && !perf_exclude_event(event, regs)) {
 		if (!(event->attr.exclude_idle && is_idle_task(current)))
-			if (__perf_event_overflow(event, 1, &data, regs))
+			if (perf_event_overflow(event, &data, regs))
 				ret =3D HRTIMER_NORESTART;
 	}
=20

