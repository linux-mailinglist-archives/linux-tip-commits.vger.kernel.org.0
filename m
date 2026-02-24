Return-Path: <linux-tip-commits+bounces-8253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOfqBmubnWnwQgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 13:36:59 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B09187090
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 13:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51D6F301C97A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AE225416;
	Tue, 24 Feb 2026 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGY8JdZF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wyJFgHdW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301D3803D1;
	Tue, 24 Feb 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936616; cv=none; b=CqizT/s81ebvvpyyTuLrpDxEbBwVhDReVqpW1Do1bXt6wYE7jT9pQ6CtO0WgdxSCRKpn/tG/A5kGli3wYy/mX3tBPngiyqAkYmmZNu0pGILvtqXS66IDb0JJoV6vsXnRJbz8iSCUnOrqr2L7ltR15WVR6Iw2lP0zrsT8KdsKCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936616; c=relaxed/simple;
	bh=hTtaIVWFqwtKt8wyMJjyZBa/KtRGfMR8AaHdVxmcNFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WIFSOws6MaFETkPZY2CBaYj4wPgxvYFQJEESiuF4EgDXTDt0mzNouzfBXbdgGtzwWdd46faVVmBHhXT6h825dPaJAbaQe4b63+XGt1D/I2zH5HZkT0j+set2n1GBKPF8A57UF7/OmRMoVIqAedwUGbUOACdviIAnYZdRKy3O8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGY8JdZF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wyJFgHdW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 12:36:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771936613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3/Au2kP5Om3EOJLFjtCzhhmhbbdbQyveovhkztCay4=;
	b=fGY8JdZF1qG9CKmaZRoMe/p42g8wbharSNM4HP9PvUxQfxVuA6Ixo2xhvPkZ0NaHS0h67p
	T4a4vlWxB9xdd5A2IABssx2pTQEk8PO+QWJn+1FC6jlitiI7pJ62q9MKi7BTaKpkWV7TrO
	pq+btCWOkGzhahDHXZac9xxI2jNeC2LM6bwIwmBVUs4b+ErIPu4UiXeMgSr292tKNO8Ztm
	kIGT7FArrUGsEZUE6v1owGuNp+Q8L9OzVm4cQcr7/h+nuPzW8OqDWAqQPbaEK8FpJUjbJp
	RHpVRvhEfBSPvmvMACmwT/qqYo3pJolYfGFO0DOrzgBX1dXRG0mPyqu289oX/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771936613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3/Au2kP5Om3EOJLFjtCzhhmhbbdbQyveovhkztCay4=;
	b=wyJFgHdWZPgX8H1kO9EWFR+TGDbPHKmuisP+Q/DRskhEXPoyF62G7ibiiebZDzdX1xykMe
	2ryHK6LwZsqQGVAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf: Fix data race in perf_event_set_bpf_handler()
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
Message-ID: <177193661171.1647592.9395163829843540847.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8253-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,linutronix.de:dkim]
X-Rspamd-Queue-Id: 88B09187090
X-Rspamd-Action: no action

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5004d5c59874b18c8ecbcb507053750c8b47353c
Gitweb:        https://git.kernel.org/tip/5004d5c59874b18c8ecbcb507053750c8b4=
7353c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 13:29:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Feb 2026 13:33:39 +01:00

perf: Fix data race in perf_event_set_bpf_handler()

On Fri, Jan 30, 2026 at 11:07:33AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 27, 2026 at 04:37:19PM +0800, Qing Wang wrote:
> > On Tue, 27 Jan 2026 at 10:36, Henry Zhang <henryzhangjcle@gmail.com> wrot=
e:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index a0fa488bce84..1f3ed9e87507 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(st=
ruct perf_event *event,
> > >  		return -EPROTO;
> > >  	}
> > >
> > > -	event->prog =3D prog;
> > > +	WRITE_ONCE(event->prog, prog);
> > >  	event->bpf_cookie =3D bpf_cookie;
> > >  	return 0;
> > >  }
> > > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> > >  	if (event->attr.aux_pause)
> > >  		perf_event_aux_pause(event->aux_event, true);
> > >
> > > -	if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT =
&&
> > > +	struct bpf_prog *prog =3D READ_ONCE(event->prog);
> > > +
> > > +	if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> > >  	    !bpf_overflow_handler(event, data, regs))
> > >  		goto out;
> >
> > Looking at this code, I guess there may be an serious issue: a potential
> > use-after-free (UAF) risk when accessing event->prog in __perf_event_over=
flow.
> >
> > CPU 0 (interrupt context)               CPU 1 (process context)
> > read event->prog
> >                                         perf_event_free_bpf_handler()
> >                                             put(prog)
> >                                                 free(prog)
> > access memory pointed to by prog
> >
> > This scenario need to be more analysis.
>
> This can only happen if the event can overlap with removal, which it
> typically cannot -- but I'll have to audit the software events.
>
> Specifically, events happen in IRQ/NMI context, and event removal
> involves an IPI to that very CPU, which by necessity will then have to
> wait for event completion.

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

