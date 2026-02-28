Return-Path: <linux-tip-commits+bounces-8317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDZSIbcOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:50:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D418E1C4245
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5A2130AFDF4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490F47F2CD;
	Sat, 28 Feb 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="id9flu11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uIPd1kh8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6C47D943;
	Sat, 28 Feb 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293014; cv=none; b=WsaB0uI5p4nSHsnCyJB72yenHpFlnD4Ru722QtyaTvMPafV9SxdkQ0W/SH2pt0/n5IwMRzFi8oVQCtqfUnv2RDcKIT1Qmu9T3k8CpItD6HjsMgCtqwbNQn4A4alpiODFHFwqec+S6FkTSyuLyouHvaYf9Fp3fwBbimXCLSRovV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293014; c=relaxed/simple;
	bh=uxfpkOry+nzXlsLv8Mr6tQ/vkHEB2zs9SumTj6wUCeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=scO3lRQNpQGuIwBsNlbivaU+w2xI2lDsvveh632WIOuzl1LM7nnqrrohJKxqdU3rSsyoVeV1Bix/B93bKiLX8GVqbebY/+jCCSuXTnS9ia/ty0vy95iJl+a9FLbqur4Uii+OG0xGYqvA2KUnjwwyY/TiiNWKm8GUIPHUqvrrs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=id9flu11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uIPd1kh8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtWS//o9/BrU7VmwTAzwMrCKGTT7DBQ+Ihb528qFORE=;
	b=id9flu11qcboHpfV4wJcisJH4XKZDyWR1yuG8XKb/5TDGBg36qX+exjr4WWVAaa8Wh4V3K
	qmhCVIMKKBTMXEtkDBWat+rEMilx2MpmZLODu9EJ3SLCeOSSQw3uCwwRUCMXKD5nK0jian
	l5vvNcVBYPvV5sLTUYPOcjOD34nWt56PvdfGrO4+ErkMOy7Tg/YSfSmjzWOuqFGdKuyIrn
	kvhrxj/J6uzgBLWL1hgELI2mXTmXqhrbCtdaZ1cV9zdYthfrQpFt/RK2w9snwdJAJsYY0Z
	qyzoPxL+HHoyhxy+1Vv//OU4vTSgE4z/h6rDSmlrF271Lp3e1W2C2xzad/PA4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtWS//o9/BrU7VmwTAzwMrCKGTT7DBQ+Ihb528qFORE=;
	b=uIPd1kh8dZKPgkSksCo1giMPG4yd2PnNT4slBIIqnwM+OBCESd5fCwF4qhEt7hQF0ZuRjV
	Yww4bbkafsAuvhAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] timekeeping: Provide infrastructure for coupled
 clockevents
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.944763521@kernel.org>
References: <20260224163429.944763521@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300517.1647592.711345070837400997.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8317-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,msgid.link:url,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: D418E1C4245
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     cd38bdb8e696a1a1eb12fc6662a6e420977aacfd
Gitweb:        https://git.kernel.org/tip/cd38bdb8e696a1a1eb12fc6662a6e420977=
aacfd
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:08 +01:00

timekeeping: Provide infrastructure for coupled clockevents

Some architectures have clockevent devices which are coupled to the system
clocksource by implementing a less than or equal comparator which compares
the programmed absolute expiry time against the underlying time
counter. Well known examples are TSC/TSC deadline timer and the S390 TOD
clocksource/comparator.

While the concept is nice it has some downsides:

  1) The clockevents core code is strictly based on relative expiry times
     as that's the most common case for clockevent device hardware. That
     requires to convert the absolute expiry time provided by the caller
     (hrtimers, NOHZ code) to a relative expiry time by reading and
     substracting the current time.

     The clockevent::set_next_event() callback must then read the counter
     again to convert the relative expiry back into a absolute one.

  2) The conversion factors from nanoseconds to counter clock cycles are
     set up when the clockevent is registered. When NTP applies corrections
     then the clockevent conversion factors can deviate from the
     clocksource conversion substantially which either results in timers
     firing late or in the worst case early. The early expiry then needs to
     do a reprogam with a short delta.

     In most cases this is papered over by the fact that the read in the
     set_next_event() callback happens after the read which is used to
     calculate the delta. So the tendency is that timers expire mostly
     late.

All of this can be avoided by providing support for these devices in the
core code:

  1) The timekeeping core keeps track of the last update to the clocksource
     by storing the base nanoseconds and the corresponding clocksource
     counter value. That's used to keep the conversion math for reading the
     time within 64-bit in the common case.

     This information can be used to avoid both reads of the underlying
     clocksource in the clockevents reprogramming path:

     delta =3D expiry - base_ns;
     cycles =3D base_cycles + ((delta * clockevent::mult) >> clockevent::shif=
t);

     The resulting cycles value can be directly used to program the
     comparator.

  2) As #1 does not longer provide the "compensation" through the second
     read the deviation of the clocksource and clockevent conversions
     caused by NTP become more prominent.

     This can be cured by letting the timekeeping core compute and store
     the reverse conversion factors when the clocksource cycles to
     nanoseconds factors are modified by NTP:

         CS::MULT      (1 << NS_TO_CYC_SHIFT)
     --------------- =3D ----------------------
     (1 << CS:SHIFT)       NS_TO_CYC_MULT

     Ergo: NS_TO_CYC_MULT =3D (1 << (CS::SHIFT + NS_TO_CYC_SHIFT)) / CS::MULT

     The NS_TO_CYC_SHIFT value is calculated when the clocksource is
     installed so that it aims for a one hour maximum sleep time.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.944763521@kernel.org
---
 include/linux/clocksource.h         |   1 +-
 include/linux/timekeeper_internal.h |   8 ++-
 kernel/time/Kconfig                 |   3 +-
 kernel/time/timekeeping.c           | 110 +++++++++++++++++++++++++++-
 kernel/time/timekeeping.h           |   2 +-
 5 files changed, 124 insertions(+)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 54366d5..25774fc 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -150,6 +150,7 @@ struct clocksource {
 #define CLOCK_SOURCE_RESELECT			0x100
 #define CLOCK_SOURCE_VERIFY_PERCPU		0x200
 #define CLOCK_SOURCE_CAN_INLINE_READ		0x400
+#define CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT	0x800
=20
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index b8ae89e..e36d11e 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -72,6 +72,10 @@ struct tk_read_base {
  * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
+ * @cs_id:			The ID of the current clocksource
+ * @cs_ns_to_cyc_mult:		Multiplicator for nanoseconds to cycles conversion
+ * @cs_ns_to_cyc_shift:		Shift value for nanoseconds to cycles conversion
+ * @cs_ns_to_cyc_maxns:		Maximum nanoseconds to cyles conversion range
  * @clock_was_set_seq:		The sequence number of clock was set events
  * @cs_was_changed_seq:		The sequence number of clocksource change events
  * @clock_valid:		Indicator for valid clock
@@ -159,6 +163,10 @@ struct timekeeper {
 	u64			raw_sec;
=20
 	/* Cachline 3 and 4 (timekeeping internal variables): */
+	enum clocksource_ids	cs_id;
+	u32			cs_ns_to_cyc_mult;
+	u32			cs_ns_to_cyc_shift;
+	u64			cs_ns_to_cyc_maxns;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
 	u8			clock_valid;
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 07b048b..b51bc56 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -47,6 +47,9 @@ config GENERIC_CLOCKEVENTS_BROADCAST_IDLE
 config GENERIC_CLOCKEVENTS_MIN_ADJUST
 	bool
=20
+config GENERIC_CLOCKEVENTS_COUPLED
+	bool
+
 # Generic update of CMOS clock
 config GENERIC_CMOS_UPDATE
 	bool
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 63aa31f..b7a0f93 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -391,6 +391,20 @@ static void tk_setup_internals(struct timekeeper *tk, st=
ruct clocksource *clock)
 	tk->tkr_raw.mult =3D clock->mult;
 	tk->ntp_err_mult =3D 0;
 	tk->skip_second_overflow =3D 0;
+
+	tk->cs_id =3D clock->id;
+
+	/* Coupled clockevent data */
+	if (IS_ENABLED(CONFIG_GENERIC_CLOCKEVENTS_COUPLED) &&
+	    clock->flags & CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT) {
+		/*
+		 * Aim for an one hour maximum delta and use KHz to handle
+		 * clocksources with a frequency above 4GHz correctly as
+		 * the frequency argument of clocks_calc_mult_shift() is u32.
+		 */
+		clocks_calc_mult_shift(&tk->cs_ns_to_cyc_mult, &tk->cs_ns_to_cyc_shift,
+				       NSEC_PER_MSEC, clock->freq_khz, 3600 * 1000);
+	}
 }
=20
 /* Timekeeper helper functions. */
@@ -720,6 +734,36 @@ static inline void tk_update_ktime_data(struct timekeepe=
r *tk)
 	tk->tkr_raw.base =3D ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
=20
+static inline void tk_update_ns_to_cyc(struct timekeeper *tks, struct timeke=
eper *tkc)
+{
+	struct tk_read_base *tkrs =3D &tks->tkr_mono;
+	struct tk_read_base *tkrc =3D &tkc->tkr_mono;
+	unsigned int shift;
+
+	if (!IS_ENABLED(CONFIG_GENERIC_CLOCKEVENTS_COUPLED) ||
+	    !(tkrs->clock->flags & CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT))
+		return;
+
+	if (tkrs->mult =3D=3D tkrc->mult && tkrs->shift =3D=3D tkrc->shift)
+		return;
+	/*
+	 * The conversion math is simple:
+	 *
+	 *      CS::MULT       (1 << NS_TO_CYC_SHIFT)
+	 *   --------------- =3D ----------------------
+	 *   (1 << CS:SHIFT)       NS_TO_CYC_MULT
+	 *
+	 * Ergo:
+	 *
+	 *   NS_TO_CYC_MULT =3D (1 << (CS::SHIFT + NS_TO_CYC_SHIFT)) / CS::MULT
+	 *
+	 * NS_TO_CYC_SHIFT has been set up in tk_setup_internals()
+	 */
+	shift =3D tkrs->shift + tks->cs_ns_to_cyc_shift;
+	tks->cs_ns_to_cyc_mult =3D (u32)div_u64(1ULL << shift, tkrs->mult);
+	tks->cs_ns_to_cyc_maxns =3D div_u64(tkrs->clock->mask, tks->cs_ns_to_cyc_mu=
lt);
+}
+
 /*
  * Restore the shadow timekeeper from the real timekeeper.
  */
@@ -754,6 +798,7 @@ static void timekeeping_update_from_shadow(struct tk_data=
 *tkd, unsigned int act
 	tk->tkr_mono.base_real =3D tk->tkr_mono.base + tk->offs_real;
=20
 	if (tk->id =3D=3D TIMEKEEPER_CORE) {
+		tk_update_ns_to_cyc(tk, &tkd->timekeeper);
 		update_vsyscall(tk);
 		update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
=20
@@ -808,6 +853,71 @@ static void timekeeping_forward_now(struct timekeeper *t=
k)
 	tk_update_coarse_nsecs(tk);
 }
=20
+/*
+ * ktime_expiry_to_cycles - Convert a expiry time to clocksource cycles
+ * @id:		Clocksource ID which is required for validity
+ * @expires_ns:	Absolute CLOCK_MONOTONIC expiry time (nsecs) to be converted
+ * @cycles:	Pointer to storage for corresponding absolute cycles value
+ *
+ * Convert a CLOCK_MONOTONIC based absolute expiry time to a cycles value
+ * based on the correlated clocksource of the clockevent device by using
+ * the base nanoseconds and cycles values of the last timekeeper update and
+ * converting the delta between @expires_ns and base nanoseconds to cycles.
+ *
+ * This only works for clockevent devices which are using a less than or
+ * equal comparator against the clocksource.
+ *
+ * Utilizing this avoids two clocksource reads for such devices, the
+ * ktime_get() in clockevents_program_event() to calculate the delta expiry
+ * value and the readout in the device::set_next_event() callback to
+ * convert the delta back to a absolute comparator value.
+ *
+ * Returns: True if @id matches the current clocksource ID, false otherwise
+ */
+bool ktime_expiry_to_cycles(enum clocksource_ids id, ktime_t expires_ns, u64=
 *cycles)
+{
+	struct timekeeper *tk =3D &tk_core.timekeeper;
+	struct tk_read_base *tkrm =3D &tk->tkr_mono;
+	ktime_t base_ns, delta_ns, max_ns;
+	u64 base_cycles, delta_cycles;
+	unsigned int seq;
+	u32 mult, shift;
+
+	/*
+	 * Racy check to avoid the seqcount overhead when ID does not match. If
+	 * the relevant clocksource is installed concurrently, then this will
+	 * just delay the switch over to this mechanism until the next event is
+	 * programmed. If the ID is not matching the clock events code will use
+	 * the regular relative set_next_event() callback as before.
+	 */
+	if (data_race(tk->cs_id) !=3D id)
+		return false;
+
+	do {
+		seq =3D read_seqcount_begin(&tk_core.seq);
+
+		if (tk->cs_id !=3D id)
+			return false;
+
+		base_cycles =3D tkrm->cycle_last;
+		base_ns =3D tkrm->base + (tkrm->xtime_nsec >> tkrm->shift);
+
+		mult =3D tk->cs_ns_to_cyc_mult;
+		shift =3D tk->cs_ns_to_cyc_shift;
+		max_ns =3D tk->cs_ns_to_cyc_maxns;
+
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	/* Prevent negative deltas and multiplication overflows */
+	delta_ns =3D min(expires_ns - base_ns, max_ns);
+	delta_ns =3D max(delta_ns, 0);
+
+	/* Convert to cycles */
+	delta_cycles =3D ((u64)delta_ns * mult) >> shift;
+	*cycles =3D base_cycles + delta_cycles;
+	return true;
+}
+
 /**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 543beba..198d060 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -9,6 +9,8 @@ extern ktime_t ktime_get_update_offsets_now(unsigned int *cws=
seq,
 					    ktime_t *offs_boot,
 					    ktime_t *offs_tai);
=20
+bool ktime_expiry_to_cycles(enum clocksource_ids id, ktime_t expires_ns, u64=
 *cycles);
+
 extern int timekeeping_valid_for_hres(void);
 extern u64 timekeeping_max_deferment(void);
 extern void timekeeping_warp_clock(void);

