Return-Path: <linux-tip-commits+bounces-8362-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNwGEKuzqWkZCwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8362-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 17:47:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975112158E9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 17:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2B1D303983E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4EA3CC9F4;
	Thu,  5 Mar 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXD07yTc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEKD4wWk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC53BED54;
	Thu,  5 Mar 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729254; cv=none; b=ZDuvAa8MVmRf5/dyJF3NnNsaoV9KwhzbWmwO++2UNtRFRi2fSNuxgNDz9Sb6bmoYRNq9rynsmJSWApB2CIvwUqQX0Kv5pZ+8yvczfznxvrvN29HNZyIRzjlTNvAtfxtt0EptlrIAK90ug4sU1z9Wqak8P//JQ8+YmYGCvAlh+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729254; c=relaxed/simple;
	bh=Dra4KjZRdpX4SvksjYigSPTSF2AeL0k0C6UvgQM/Fms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k8qlw5N7wTXrOBRvSID/nWkYuUERNE8Uzt5nq6lKGBRZXiygMFXzkRbCx7Tn27IdJp6oDB5rsYUpqz3Ogc+jnWS9H542iKc9jqiHOx5iVRJKNPDABIT/mL4x47NKNwQK1BLLtoAfx5nSbdwxl05eoDJLKiHEwYibYaqcI+qaM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXD07yTc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEKD4wWk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 16:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772729251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd5oPYxO+JfUxI0B7VYC0tzKKZIVzngfoywdkwCgQV8=;
	b=LXD07yTc+6uBwjQyjl+mkltrM6Tf3dM0doTP+hVDBwTJ8RK/Im67wWjx5wGoDHJ6FrcEqb
	SxosE5pYPC77jBGPp5cGD7gJ6tgjw8o4D+uAOsnEnF3D+lyyRtSGOacbisquM1GFod3Y5x
	B5w2PgxVLI//CE2sqOuZsbVmp+oG6k7tkkOtmBCd1TVswqNxK6hRByZ1iRzQvZQeDLy9SP
	ehcKjOdaPnf7JvRz2v2bpX1acXLHFGphwSjqW/3g6Czmc1xIH6KQxoUKW89KG+fzFmHdW/
	bAmW8t2YwSYb9q3fUCQVVxsI6GV6MNlvXZHoqgxWIRORmhTYJIBekw0xO7kgcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772729251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd5oPYxO+JfUxI0B7VYC0tzKKZIVzngfoywdkwCgQV8=;
	b=OEKD4wWk70dOoLWIZIVBRvlF0E8hFyqZ/xNGPfIvYGoOuyXFRtUR3f7J3zRhVjBjjNTmO8
	1lL0PNS+5hFlvvCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] timekeeping: Initialize the coupled clocksource
 conversion completely
Cc: Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87bjh4zies.ffs@tglx>
References: <87bjh4zies.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177272925029.1647592.11820682521946672557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 975112158E9
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8362-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     9d5e25b361b7228b422fd32bd1c327fd7fb919b4
Gitweb:        https://git.kernel.org/tip/9d5e25b361b7228b422fd32bd1c327fd7fb=
919b4
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 03 Mar 2026 22:56:27 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 05 Mar 2026 17:40:46 +01:00

timekeeping: Initialize the coupled clocksource conversion completely

Nathan reported a boot failure after the coupled clocksource/event support
was enabled for the TSC deadline timer. It turns out that on the affected
test systems the TSC frequency is not refined against HPET, so it is
registered with the same frequency as the TSC-early clocksource.

As a consequence the update function which checks for a change of the
shift/mult pair of the clocksource fails to compute the conversion
limit, which is zero initialized. This check is there to avoid pointless
computations on every timekeeping update cycle (tick).

So the actual clockevent conversion function limits the delta expiry to
zero, which means the timer is always programmed to expire in the
past. This obviously results in a spectacular timer interrupt storm,
which goes unnoticed because the per CPU interrupts on x86 are not
exposed to the runaway detection mechanism and the NMI watchdog is not
yet functional. So the machine simply stops booting.

That did not show up in testing. All test machines refine the TSC frequency
so TSC has a differrent shift/mult pair than TSC-early and the conversion
limit is properly initialized.

Cure that by setting the conversion limit right at the point where the new
clocksource is installed.

Fixes: cd38bdb8e696 ("timekeeping: Provide infrastructure for coupled clockev=
ents")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/87bjh4zies.ffs@tglx
Closes: https://lore.kernel.org/20260303012905.GA978396@ax162
---
 kernel/time/timekeeping.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b7a0f93..5153218 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -404,6 +404,13 @@ static void tk_setup_internals(struct timekeeper *tk, st=
ruct clocksource *clock)
 		 */
 		clocks_calc_mult_shift(&tk->cs_ns_to_cyc_mult, &tk->cs_ns_to_cyc_shift,
 				       NSEC_PER_MSEC, clock->freq_khz, 3600 * 1000);
+		/*
+		 * Initialize the conversion limit as the previous clocksource
+		 * might have the same shift/mult pair so the quick check in
+		 * tk_update_ns_to_cyc() fails to update it after a clocksource
+		 * change leaving it effectivly zero.
+		 */
+		tk->cs_ns_to_cyc_maxns =3D div_u64(clock->mask, tk->cs_ns_to_cyc_mult);
 	}
 }
=20

