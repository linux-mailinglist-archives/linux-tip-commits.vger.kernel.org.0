Return-Path: <linux-tip-commits+bounces-8277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFiBK4zKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:59:24 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C491C2653
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E018A30D3E83
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13506436372;
	Sat, 28 Feb 2026 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmAmWn/w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZ1sD7cc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CC428474;
	Sat, 28 Feb 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276210; cv=none; b=CEOG/IxdtjWSpaSksS2F0yGhTygOV6+sRUISzpNOl0+9ek8e3ZDGGJ0z2pG7ckGjCmjFfkMyq3LR2tv08DqfXHmwIXibkfCilJtEsSNGp9R/1sYc1+FcCP1pPSKY5rL62bPgBKb2C1rcnu334qPNSiKgGSFZUmwOHyVT0y/5iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276210; c=relaxed/simple;
	bh=hH/rw7jRBt3QywKW+qR9f8jzAW/KVWu7ZLZHhhXWQ2o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I3UVuc50HCqCqHYV71ETayfLqb3YKXiiKzQccqkQJqwZ6+Wrf1ixxM48BTUpSibchWCvlqaLi0f0YPGEIqNRluYHTG+TngN5R1W0GbtvCVafCbZW7WnCUpmsxlBtKk+4Sv308uO1+gppD8yk26y6bhquLBLwh5z2jaeblloxsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmAmWn/w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZ1sD7cc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNA4INRE6fKtTT7gT/jvlTRhtEAAk8zAVNbH97XSkZk=;
	b=wmAmWn/woLFF0q+WQhCvxrncRsVs9YumkYC5yHzPa72mWcBeWyUu0TCcjx1J9d/f614uAj
	lTGEVnlbcoS/Tou+n57Pbf407SK7v3glTXbsRtmyBqwAFxS5iiVimg6kXgEYOlykodMD+m
	MsBYd3N8trp+ry1/+a2ldb0CwBid9p9tXHR4m92pY6tFaslzBdSiqzwmP8DvSuA4TrGXXc
	m02nfYOSq+LpXveidwqTGSJHhEtjuod4PQLt47zdTTmTRZyn0IzcG4Th+HbecWu5l1ENzo
	b2bRRjKJ9Ejo/FrzHapjVTjZbLQ6TTmkS8Ud1am/r5zl05cI2Bj2Op/985P7tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNA4INRE6fKtTT7gT/jvlTRhtEAAk8zAVNbH97XSkZk=;
	b=uZ1sD7cct7Ry2n7OZ4zm51rz2FRdZbNQQp/gZemB+VKwH+pKZOlP4n2bEK6z+by6AgnQsp
	lMfD1RXF2ICVTwAw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/amd/ibs: Account interrupt for discarded samples
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042216.1440-2-ravi.bangoria@amd.com>
References: <20260216042216.1440-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620598.1647592.17396978837370736109.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8277-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,linutronix.de:dkim,amd.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 49C491C2653
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     01336b5559785a136de1cac49705f63a70a755bc
Gitweb:        https://git.kernel.org/tip/01336b5559785a136de1cac49705f63a70a=
755bc
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:22:12=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:22 +01:00

perf/amd/ibs: Account interrupt for discarded samples

Add interrupt throttling accounting for below cases:

  o IBS Op PMU: A software filter (in addition to the hardware filter)
    drops samples whose load latency is below the user-specified
    threshold.

  o IBS Fetch PMU: Samples discarded due to the zero-RIP erratum (#1197).

Although these samples are discarded, the NMI cost is still incurred, so
they should be counted for interrupt throttling.

Fixes: 26db2e0c51fe83e1dd852c1321407835b481806e ("perf/x86/amd/ibs: Work arou=
nd erratum #1197")
Fixes: d20610c19b4a22bc69085b7eb7a02741d51de30e ("perf/amd/ibs: Add support f=
or OP Load Latency Filtering")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-2-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aca89f2..705ef43 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1293,8 +1293,10 @@ fail:
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <=3D (event->attr.config1 & 0xFFF))
+		    op_data3.dc_miss_lat <=3D (event->attr.config1 & 0xFFF)) {
+			throttle =3D perf_event_account_interrupt(event);
 			goto out;
+		}
 	}
=20
 	/*
@@ -1326,8 +1328,10 @@ fail:
 		regs.flags &=3D ~PERF_EFLAGS_EXACT;
 	} else {
 		/* Workaround for erratum #1197 */
-		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
+		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1])) {
+			throttle =3D perf_event_account_interrupt(event);
 			goto out;
+		}
=20
 		set_linear_ip(&regs, ibs_data.regs[1]);
 		regs.flags |=3D PERF_EFLAGS_EXACT;

