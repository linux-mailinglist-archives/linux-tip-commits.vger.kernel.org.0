Return-Path: <linux-tip-commits+bounces-8273-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NPVMUDKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8273-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:08 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B01C25FA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DBB430A35F0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D9342846A;
	Sat, 28 Feb 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cr8sE+PQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMhDvLjG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11842980B;
	Sat, 28 Feb 2026 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276205; cv=none; b=RPQKBRtjivLb36Mawkhn1lZ9dZu14WXsZCUJ86mFGlODqp7yWVcnAioUrQfvcqRKWQCmwwbHqYEhyYgtjgU2jPAlkczAJBMbtJKszrOjglS3sUSXt1TRtFV02gfkKKQo1Knd1RffzTudhVrUxDREqqD7raBPRudV+Nw23QhiPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276205; c=relaxed/simple;
	bh=kN0FZ+iFXohv7kbU0b97WWEGeVX8/bmh3A0MvzzTHdg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hVx70hdC6RCdVjG6jQ9LWhKNo5c7SkyROyRk7frijY3LULN3loJt5yeFXvyqKFWFNsP5CWtCJouLFLhM3vUTp9nP8y5YDWB3Au8Vr52ZCj5OyUPVfHfLQLSmEP6S0g9+y/nGZRNYnWk2/rABUBZUOwExPFRi90MwdyHJqJJpCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cr8sE+PQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMhDvLjG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4AvDA+wvzn2VM0Wb69AwiysKmgzF2/+VAJRHmdaWT4=;
	b=Cr8sE+PQEZWYnS3pViGnbrEasEkNFAUaYKoSqLu0q8f1f8SwY2G56bKVO9nXpfEzxmYNix
	Il+kwLpkoE7uZABdy395sBJ/boi76cIP73tr+KU42U3u+aIuNhSXPAKtI2lCODE1HgO4Qd
	V3vDdjbFWdh2ka95mTbthy9PigO08mlmlHyJloCTw/I+rvCxzE3us1nkAvFKxzqGUIxG3R
	UpREt6zGaCwme6fx3E28v/li7mvJU0EsBsGHrLldbWtheAXPJdnaIDa11azn5YmxnSI6wK
	V4n0jOvtql4JwUKwFsdli3MKz6bS74URFnNqTJyKhHOH/4ZFnf1Pu0xEF22eOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4AvDA+wvzn2VM0Wb69AwiysKmgzF2/+VAJRHmdaWT4=;
	b=YMhDvLjGBl0p0dvlCM3KTKx7BbEgzUbSLStoqlZyZiPL+LhCZcSwlVwnlTfJHS2h8XNWc9
	2dgxgHNUGWLUgyAQ==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Avoid race between event add and NMI
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042216.1440-6-ravi.bangoria@amd.com>
References: <20260216042216.1440-6-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620113.1647592.2688068209002203305.tip-bot2@tip-bot2>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8273-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7A5B01C25FA
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1b044ff3c17e9d7fd93ffc0ba541ccdeb992d7f5
Gitweb:        https://git.kernel.org/tip/1b044ff3c17e9d7fd93ffc0ba541ccdeb99=
2d7f5
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:22:16=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:23 +01:00

perf/amd/ibs: Avoid race between event add and NMI

Consider the following race:

  --------
  o OP_CTL contains stale value: OP_CTL[Val]=3D1, OP_CTL[En]=3D0
  o A new IBS OP event is being added
  o [P]: Process context, [N]: NMI context

  [P] perf_ibs_add(event) {
  [P]     if (test_and_set_bit(IBS_ENABLED, pcpu->state))
  [P]         return;
  [P]     /* pcpu->state =3D IBS_ENABLED */
  [P]
  [P]     pcpu->event =3D event;
  [P]
  [P]     perf_ibs_start(event) {
  [P]         set_bit(IBS_STARTED, pcpu->state);
  [P]         /* pcpu->state =3D IBS_ENABLED | IBS_STARTED */
  [P]         clear_bit(IBS_STOPPING, pcpu->state);
  [P]         /* pcpu->state =3D IBS_ENABLED | IBS_STARTED */

  [N] --> NMI due to genuine FETCH event. perf_ibs_handle_irq()
  [N]     called for OP PMU as well.
  [N]
  [N] perf_ibs_handle_irq(perf_ibs) {
  [N]     event =3D pcpu->event; /* See line 6 */
  [N]
  [N]     if (!test_bit(IBS_STARTED, pcpu->state)) /* false */
  [N]         return 0;
  [N]
  [N]     if (WARN_ON_ONCE(!event)) /* false */
  [N]         goto fail;
  [N]
  [N]     if (!(*buf++ & perf_ibs->valid_mask)) /* false due to stale
  [N]                                            * IBS_OP_CTL value */
  [N]         goto fail;
  [N]
  [N]         ...
  [N]
  [N]     perf_ibs_enable_event() // *Accidentally* enable the event.
  [N] }
  [N]
  [N] /*
  [N]  * Repeated NMIs may follow due to accidentally enabled IBS OP
  [N]  * event if the sample period is very low. It could also lead
  [N]  * to pcpu->state corruption if the event gets throttled due
  [N]  * to too frequent NMIs.
  [N]  */

  [P]         perf_ibs_enable_event();
  [P]     }
  [P] }
  --------

We cannot safely clear IBS_{FETCH|OP}_CTL while disabling the event,
because the register might be read again later. So, clear the register
in the enable path - before we update pcpu->state and enable the event.
This guarantees that any NMI that lands in the gap finds Val=3D0 and
bails out cleanly.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-6-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 004226b..32e6456 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -494,6 +494,14 @@ static void perf_ibs_start(struct perf_event *event, int=
 flags)
 	config |=3D period >> 4;
=20
 	/*
+	 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
+	 * Doing so prevents a race condition in which an NMI due to other
+	 * source might accidentally activate the event before we enable
+	 * it ourselves.
+	 */
+	perf_ibs_disable_event(perf_ibs, hwc, 0);
+
+	/*
 	 * Set STARTED before enabling the hardware, such that a subsequent NMI
 	 * must observe it.
 	 */

