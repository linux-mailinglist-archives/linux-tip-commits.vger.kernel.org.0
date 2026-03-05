Return-Path: <linux-tip-commits+bounces-8361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB1HMKmzqWkZCwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 17:47:37 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257A2158E2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B63B73018697
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF723BED58;
	Thu,  5 Mar 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjwOwC4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFPCb2jD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03239D6D3;
	Thu,  5 Mar 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729253; cv=none; b=Tr1DmEzqjHw+jDgTbVZ1tOGVwUqFDoIjCcmo7Ygp4m1slpH0EVLmWKZ98jPtqJOfIG5WBBRl50hU8VTwDva+LyyHSRib9orJcVN+ARq9XwUy681IjNh/lsTclXmVHk5L0IAXw3t/WH3FqZkoun/uIhORjMjRWeQJ64Sm0pM++nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729253; c=relaxed/simple;
	bh=t76Pm8Kbng1NfWvkJWTr3hpnL717OCaGtimZ+b5NtOs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xss7iUBoNp2aey8/1WYJRn4DJpt5aYAYJs8boD1XSs++VweZ7EjdtQLX8lr96xUlh7uHuPyUbhA9nlnfwe19sy08UUwbxiJbrinEmq5Tq+xucckD78Ww8JZZ6TkgJBZoe6QNnSjQ9FiRIc9jQh8PNMZG0Wgc8s3b+qSALIikgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SjwOwC4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFPCb2jD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 16:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772729250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIOEEqFjX5gCSxqM6a2xr02vYLUXsQmp6jTxnwKoPck=;
	b=SjwOwC4/DKCVXUdbkpT4THXxGz2Qplo+YEy/c1WBBWJSsdNYtHyeLT3RD9X62VH5kdB+in
	84nW9e3MnE5cXrk+T0PNwPkK1OlFhUqnGs2QJ3ikSDmyHv7cj5mGbCdCkLKYbqClBCz7iS
	KFgycKkib7SgPjGVVmUsQFn7fROUuGdaAguNB1bSGeqSCz7+3i/22D75mkZBAmL2s3p6eI
	c/hToIOWCgcUlHt/TFYuhQniMvk0ahghwIlvK9PZNZyYVd6FVPokCQ0ZOpeIDlZBfny6yU
	qxp+G0LSWY6kQELSA3xNX4ohYx6D8+5KdY94EPEnlDHP6GLZXvAAqnPgFntHxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772729250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIOEEqFjX5gCSxqM6a2xr02vYLUXsQmp6jTxnwKoPck=;
	b=GFPCb2jDcEWCqUQoJPoJ3jNqQJ+NgbKDsk/ycJ3hyqzN14878NlrLCizCQiq3qRa1cssPE
	LkwTovKyYyWyQ1Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/hrtick] clocksource: Update clocksource::freq_khz on registration
Cc: Borislav Petkov <bp@alien8.de>, Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87cy1jsa4m.ffs@tglx>
References: <87cy1jsa4m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177272924913.1647592.16018522888967572464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2257A2158E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8361-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:replyto,linutronix.de:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     53007d526e17d29f0e5b81c07eb594a93bc4d29c
Gitweb:        https://git.kernel.org/tip/53007d526e17d29f0e5b81c07eb594a93bc=
4d29c
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Wed, 04 Mar 2026 19:49:29 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 05 Mar 2026 17:41:06 +01:00

clocksource: Update clocksource::freq_khz on registration

Borislav reported a division by zero in the timekeeping code and random
hangs with the new coupled clocksource/clockevent functionality.

It turned out that the TSC clocksource is not always updating the
freq_khz field of the clocksource on registration. The coupled mode
conversion calculation requires the frequency and as it's not
initialized the resulting factor is zero or a random value. As a
consequence this causes a division by zero or random boot hangs.

Instead of chasing down all clocksources which fail to update that
member, fill it in at registration time where the caller has to supply
the frequency anyway. Except for special clocksources like jiffies which
never can have coupled mode.

To make this more robust put a check into the registration function to
validate that the caller supplied a frequency if the coupled mode
feature bit is set. If not, emit a warning and clear the feature bit.

Fixes: cd38bdb8e696 ("timekeeping: Provide infrastructure for coupled clockev=
ents")
Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://patch.msgid.link/87cy1jsa4m.ffs@tglx
Closes: https://lore.kernel.org/20260303213027.GA2168957@ax162
---
 kernel/time/clocksource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index df71949..3c20544 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1169,6 +1169,9 @@ void __clocksource_update_freq_scale(struct clocksource=
 *cs, u32 scale, u32 freq
=20
 		clocks_calc_mult_shift(&cs->mult, &cs->shift, freq,
 				       NSEC_PER_SEC / scale, sec * scale);
+
+		/* Update cs::freq_khz */
+		cs->freq_khz =3D div_u64((u64)freq * scale, 1000);
 	}
=20
 	/*
@@ -1241,6 +1244,10 @@ int __clocksource_register_scale(struct clocksource *c=
s, u32 scale, u32 freq)
=20
 	if (WARN_ON_ONCE((unsigned int)cs->id >=3D CSID_MAX))
 		cs->id =3D CSID_GENERIC;
+
+	if (WARN_ON_ONCE(!freq && cs->flags & CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT))
+		cs->flags &=3D ~CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT;
+
 	if (cs->vdso_clock_mode < 0 ||
 	    cs->vdso_clock_mode >=3D VDSO_CLOCKMODE_MAX) {
 		pr_warn("clocksource %s registered with invalid VDSO mode %d. Disabling VD=
SO support.\n",

