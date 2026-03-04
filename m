Return-Path: <linux-tip-commits+bounces-8355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCdfDuWDqGmgvQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:11:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1147206F32
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02AF1300888F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4020C3DA5C3;
	Wed,  4 Mar 2026 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9ZgvxxF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSWlBRBs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44353DA5BB;
	Wed,  4 Mar 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651439; cv=none; b=f8mTFGeYquiKHbcFrla/Tj3vVDkmePOL2KOYgXdLt6KN9TJSbvMgchxB44hF9Yxpx9mgWcM2MsSKfI+LvqsSLgYB89lUeQ39JdyzfUuNq5eEzn92wij2/CxGU4lPo8Lc2cVuqoQnox5lESf78+mADkN+S3+/AxvMwKTC3YE2OSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651439; c=relaxed/simple;
	bh=c5vV3C/OtjMxupYwAoXkrxzwFDadALK3DD3smAroTo0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q38tFU8nigj4zIwDBTA8elAC3ivKkLRzTGrXbTvJa2EBBBuwBKlerqjZuUU0C8JCaixb78LiipKI1w/UTFNMtiDIlhPBI3oOQt/ysA/rEU49km459ZOnvOU0TjFkcLQ7D/3ADmBtdxUd3JfmkL/MWq7+52o6TbKMGETVxxTjdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9ZgvxxF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSWlBRBs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 19:10:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772651435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CshVRWc/9fF8lfHmxRFSHIyd6VyFHGoBIYJAr6YSutA=;
	b=z9ZgvxxFi7X2K/TZtE8vOTa7FdFak9xOqNrlRvbJ3Z9r36SktPoIe7H7tgVVsuvn7g/7Id
	fDO1hP3DJnngtl4TKFkL1lHQ/LEwXyYPyv/xOosoD2SIxQrpnR2wpcvDKwUwpMbkzzBM7F
	CVKNqVM9qfu2Eo5mJi78xI90XkkkTJ57X5QU3vwhjeaAOWXTYuA29vKKQRDGaz6bfFCmFV
	LWRHWLVAwGmpK9yEsZhYRb+rufSykVLbiuCTCsHtJVKNJhK4q/3R42A5Ec797AKJ9z2u+J
	mOHiAO1Vv260ams0ENZt9YaqSNGP+Pv1gX3LnzOohJXH/it0aO87mo0hW0Q7Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772651435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CshVRWc/9fF8lfHmxRFSHIyd6VyFHGoBIYJAr6YSutA=;
	b=oSWlBRBs/E/8IhUqJZnp7C3zqoKq4ULahPthXWxc2GNOoxYcnWCr4OlXMs5x3XFqvraWAW
	k3Le0ioPnn7IiCBw==
From: "tip-bot2 for Miroslav Lichvar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Fix timex status validation for
 auxiliary clocks
Cc: Miroslav Lichvar <mlichvar@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260225085231.276751-1-mlichvar@redhat.com>
References: <20260225085231.276751-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177265143406.1647592.4859139336525737427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A1147206F32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8355-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e48a869957a70cc39b4090cd27c36a86f8db9b92
Gitweb:        https://git.kernel.org/tip/e48a869957a70cc39b4090cd27c36a86f8d=
b9b92
Author:        Miroslav Lichvar <mlichvar@redhat.com>
AuthorDate:    Wed, 25 Feb 2026 09:51:35 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 04 Mar 2026 20:05:37 +01:00

timekeeping: Fix timex status validation for auxiliary clocks

The timekeeping_validate_timex() function validates the timex status
of an auxiliary system clock even when the status is not to be changed,
which causes unexpected errors for applications that make read-only
clock_adjtime() calls, or set some other timex fields, but without
clearing the status field.

Do the AUX-specific status validation only when the modes field contains
ADJ_STATUS, i.e. the application is actually trying to change the
status. This makes the AUX-specific clock_adjtime() behavior consistent
with CLOCK_REALTIME.

Fixes: 4eca49d0b621 ("timekeeping: Prepare do_adtimex() for auxiliary clocks")
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260225085231.276751-1-mlichvar@redhat.com
---
 kernel/time/timekeeping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 91fa200..c07e562 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2653,7 +2653,8 @@ static int timekeeping_validate_timex(const struct __ke=
rnel_timex *txc, bool aux
=20
 	if (aux_clock) {
 		/* Auxiliary clocks are similar to TAI and do not have leap seconds */
-		if (txc->status & (STA_INS | STA_DEL))
+		if (txc->modes & ADJ_STATUS &&
+		    txc->status & (STA_INS | STA_DEL))
 			return -EINVAL;
=20
 		/* No TAI offset setting */
@@ -2661,7 +2662,8 @@ static int timekeeping_validate_timex(const struct __ke=
rnel_timex *txc, bool aux
 			return -EINVAL;
=20
 		/* No PPS support either */
-		if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
+		if (txc->modes & ADJ_STATUS &&
+		    txc->status & (STA_PPSFREQ | STA_PPSTIME))
 			return -EINVAL;
 	}
=20

