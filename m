Return-Path: <linux-tip-commits+bounces-8274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KGSFFPKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70E1C2608
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BBF830B62E3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA60426ECF;
	Sat, 28 Feb 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FFIY0d92";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cD7SKZHI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D7436372;
	Sat, 28 Feb 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276206; cv=none; b=YM/fWFl2kWt8WVX6r3kyT7XrbBzl6Gqbt/1ujfBQ8VscBjWSFAFPrfhehyS2QD0f/85Kb7ni+hHCfAEuD/O7K/3huMn8K5BVnZmJZvaHGM91agi3IguxaKz1GuH9zdQm9D2uVKVhj4jLGhzEJwngMF2vhLjRPg01cYILFwoHTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276206; c=relaxed/simple;
	bh=MW1e+FiAW8UMS/m9rnJ5t3TMoyT858bSUSQY0RNxvuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YVnfwYYToqp6If0jKaQoABCd0YOrLC5hS5DVDnBM7fIutmqt+RyIvZuwrfqCWTAsK82SPveJgedV2s1ruGdhR9s2svowL/FgNy5HawYNBDL6ewmEMUxXSvvZb9z0h3Z6oFOsqVusPITy+MOgNJG7dptKGfZeXekO0CARjkEhEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FFIY0d92; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cD7SKZHI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puzbsafhGn7qLTMBnz2gwq27dj5xNNJkHYIywX5kfd8=;
	b=FFIY0d92mVtt0wYGA70i/bRdrhd3DWYL/s/mZWpQO5E4BZLNepkuxoPUsjBncjXT2d1n0g
	/czDXAxhBZTze4sDxDcsWvjih+Fyk/VqDeyu6w7M/skshxw6eFsgtJk4i/4jpoNQ38kzz0
	XrKYD///c4MEofuRQl0xMPnYVtNcnVNZ5/KmnjPD0axD4YixshQ+/021i0RthYD1gXsKmy
	V9LtIIG9fDloARoU6jIveBSkVXuxliUs0XyqX3/7a9LFWHFOUNN70qTSi+ldGa9YzbCBS1
	MYet8Lbwlt9NP6S5UPrdytzb2+hPet+yWuF0yHgDVdkEnrDnE3ZztOttIwAXtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puzbsafhGn7qLTMBnz2gwq27dj5xNNJkHYIywX5kfd8=;
	b=cD7SKZHIPaWYQJhbjsLwXHt+Mxj2f1udh9R2VxjV4Old/bfy69qSbJSP4ae1K2msaslTJt
	/BUuCBvoRveBRzCw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Avoid calling perf_allow_kernel() from
 the IBS NMI handler
Cc: Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042216.1440-5-ravi.bangoria@amd.com>
References: <20260216042216.1440-5-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620247.1647592.14977762441472774078.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8274-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim]
X-Rspamd-Queue-Id: CA70E1C2608
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b0a09142622a994c4f4088c3f61db5da87cfc711
Gitweb:        https://git.kernel.org/tip/b0a09142622a994c4f4088c3f61db5da87c=
fc711
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:22:15=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:23 +01:00

perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI handler

Calling perf_allow_kernel() from the NMI context is unsafe and could be
fatal. Capture the permission at event-initialization time by storing it
in event->hw.flags, and have the NMI handler rely on that cached flag
instead of making the call directly.

Fixes: 50a53b60e141d ("perf/amd/ibs: Prevent leaking sensitive data to usersp=
ace")
Reported-by: Sadasivan Shaiju <sadasivan.shaiju2@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-5-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c          | 5 ++++-
 arch/x86/events/perf_event_flags.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 05b7c9f..004226b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -313,6 +313,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (ret)
 		return ret;
=20
+	if (perf_allow_kernel())
+		hwc->flags |=3D PERF_X86_EVENT_UNPRIVILEGED;
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -1349,7 +1352,7 @@ fail:
 	 * unprivileged users.
 	 */
 	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
-	    perf_allow_kernel()) {
+	    (hwc->flags & PERF_X86_EVENT_UNPRIVILEGED)) {
 		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
 	}
=20
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_=
flags.h
index 7007833..47f84ee 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -23,3 +23,4 @@ PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for =
hybrid */
 PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
 PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra spac=
e of each branch */
 PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
+PERF_ARCH(UNPRIVILEGED,		0x0200000) /* Unprivileged event (wrt perf_allow_ke=
rnel()) */

