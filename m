Return-Path: <linux-tip-commits+bounces-8270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JjcCZDKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:59:28 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1591C2662
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5DC30CA24D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267B42DFEE;
	Sat, 28 Feb 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTEo6tf0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZYtN4Yj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979442B723;
	Sat, 28 Feb 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276202; cv=none; b=cKfGrvnEAPH13f+cIUxcuwEI7g3mLzSM7v1wvgrh+NM15ZWs0ltQ4fsaak2gCnEkGG5VbJKwXr2eG1ArQxh+80FQMYirybZAODvKc+r9Tgz6+TfdQE02NFpl3TVaylB7o449Z9dWhJmG9RusvHl1kHM+UmtRXKfu//HfNalz/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276202; c=relaxed/simple;
	bh=Ro6FPTjj6d8kwUufQ7vdLFqgadMz4uzxdc0ah0wMUYk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uKjUU0rG8w6fhuZ4MeCcDIG/hFlwdCYaxWzyQ6IpeqiQxmMaJ8y5uLGyVPUoKV7TKqmSsgX/QBWRAbLe12+JNoEL3aiMDe2iKgOswTJOAQg4OHW1TsNd7Am2A6zC9sJ3i044gByHeFNKtoqyhBrkEk80+NbiI9U9exEDuXt721c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HTEo6tf0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZYtN4Yj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZVInLs1rLB6yooTIZ6wWlMyu+xTjBTDszzfPCefDLY=;
	b=HTEo6tf0LNtmYtmxD95++yrDHOtSPSYSdH0KgYroQm/T/xTKMSb5x5iVmhgwbCO2YzEK7P
	wilGuJpdirVmne9LleRqmC0fDTsNOOuNMTKRmdgGe/mGkLPHKPX61ozWjXkeG7Es8mgxhN
	zQZlZF3WLOr8DAXKYyO5wbSeyRVEhC398CKeAaMdOZFRMDGSBQODOjqIY46jQYBjT78BZH
	+g3HXVGqSmy9I6yXoIWOptsTf9fg0MtNJILBEkuL4aahA1EHNCKp6+sr+5vJP7mwC6VlP9
	XZhvzHS/jTjoNUMnaY0O+c0pKP/8VYQFGSV2pTQGiap3j4le8y8rUfUOS1uq8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZVInLs1rLB6yooTIZ6wWlMyu+xTjBTDszzfPCefDLY=;
	b=1ZYtN4YjhlpHZ7/2gxvKO9E0rW/ibIs83BtJEiuj84Xu2y2Jvfw/u9uu8Q2msjRVidGcu1
	ewj9lle+w+7DMFDw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] to eliminate RMW race
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-4-ravi.bangoria@amd.com>
References: <20260216042530.1546-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227619773.1647592.3812702667944874434.tip-bot2@tip-bot2>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8270-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: AE1591C2662
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     28063f05f38b5c114b0c8d2b0200604196b085ef
Gitweb:        https://git.kernel.org/tip/28063f05f38b5c114b0c8d2b0200604196b=
085ef
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:26=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:24 +01:00

to eliminate RMW race

The existing IBS_{FETCH|OP}_CTL MSRs combine control and status bits
which leads to RMW race between HW and SW:

  HW                               SW
  ------------------------         ------------------------------
                                   config =3D rdmsr(IBS_OP_CTL);
                                   config &=3D ~EN;
  Set IBS_OP_CTL[Val] to 1
  trigger NMI
                                   wrmsr(IBS_OP_CTL, config);
                                   // Val is accidentally cleared

Future hardware adds a control-only MSR, IBS_{FETCH|OP}_CTL2, which
provides a second-level "disable" bit (Dis). IBS is now:

  Enabled:  IBS_{FETCH|OP}_CTL[En] =3D 1 && IBS_{FETCH|OP}_CTL2[Dis] =3D 0
  Disabled: IBS_{FETCH|OP}_CTL[En] =3D 0 || IBS_{FETCH|OP}_CTL2[Dis] =3D 1

The separate "Dis" bit lets software disable IBS without touching any
status fields, eliminating the hardware/software race.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216042530.1546-4-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 45 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 2e8fb06..b7f0aad 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -86,9 +86,11 @@ struct cpu_perf_ibs {
 struct perf_ibs {
 	struct pmu			pmu;
 	unsigned int			msr;
+	unsigned int			msr2;
 	u64				config_mask;
 	u64				cnt_mask;
 	u64				enable_mask;
+	u64				disable_mask;
 	u64				valid_mask;
 	u16				min_period;
 	u64				max_period;
@@ -292,6 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
 		return -ENOENT;
=20
 	config =3D event->attr.config;
+	hwc->extra_reg.config =3D 0;
+	hwc->extra_reg.reg =3D 0;
=20
 	if (event->pmu !=3D &perf_ibs->pmu)
 		return -ENOENT;
@@ -319,6 +323,11 @@ static int perf_ibs_init(struct perf_event *event)
 	if (perf_allow_kernel())
 		hwc->flags |=3D PERF_X86_EVENT_UNPRIVILEGED;
=20
+	if (ibs_caps & IBS_CAPS_DIS) {
+		hwc->extra_reg.config &=3D ~perf_ibs->disable_mask;
+		hwc->extra_reg.reg =3D perf_ibs->msr2;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -448,6 +457,9 @@ static inline void perf_ibs_enable_event(struct perf_ibs =
*perf_ibs,
 		wrmsrq(hwc->config_base, tmp & ~perf_ibs->enable_mask);
=20
 	wrmsrq(hwc->config_base, tmp | perf_ibs->enable_mask);
+
+	if (hwc->extra_reg.reg)
+		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
 }
=20
 /*
@@ -460,6 +472,11 @@ static inline void perf_ibs_enable_event(struct perf_ibs=
 *perf_ibs,
 static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
+	if (ibs_caps & IBS_CAPS_DIS) {
+		wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+		return;
+	}
+
 	config &=3D ~perf_ibs->cnt_mask;
 	if (boot_cpu_data.x86 =3D=3D 0x10)
 		wrmsrq(hwc->config_base, config);
@@ -812,6 +829,7 @@ static struct perf_ibs perf_ibs_fetch =3D {
 		.check_period	=3D perf_ibs_check_period,
 	},
 	.msr			=3D MSR_AMD64_IBSFETCHCTL,
+	.msr2			=3D MSR_AMD64_IBSFETCHCTL2,
 	.config_mask		=3D IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		=3D IBS_FETCH_MAX_CNT,
 	.enable_mask		=3D IBS_FETCH_ENABLE,
@@ -837,6 +855,7 @@ static struct perf_ibs perf_ibs_op =3D {
 		.check_period	=3D perf_ibs_check_period,
 	},
 	.msr			=3D MSR_AMD64_IBSOPCTL,
+	.msr2			=3D MSR_AMD64_IBSOPCTL2,
 	.config_mask		=3D IBS_OP_MAX_CNT,
 	.cnt_mask		=3D IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
@@ -1394,6 +1413,9 @@ fail:
=20
 out:
 	if (!throttle) {
+		if (ibs_caps & IBS_CAPS_DIS)
+			wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+
 		if (perf_ibs =3D=3D &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 				new_config =3D period & IBS_OP_MAX_CNT_EXT_MASK;
@@ -1465,6 +1487,9 @@ static __init int perf_ibs_fetch_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_fetch.config_mask |=3D IBS_FETCH_L3MISSONLY;
=20
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_fetch.disable_mask =3D IBS_FETCH_2_DIS;
+
 	perf_ibs_fetch.pmu.attr_groups =3D fetch_attr_groups;
 	perf_ibs_fetch.pmu.attr_update =3D fetch_attr_update;
=20
@@ -1486,6 +1511,9 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |=3D IBS_OP_L3MISSONLY;
=20
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_op.disable_mask =3D IBS_OP_2_DIS;
+
 	perf_ibs_op.pmu.attr_groups =3D op_attr_groups;
 	perf_ibs_op.pmu.attr_update =3D op_attr_update;
=20
@@ -1732,6 +1760,23 @@ static void clear_APIC_ibs(void)
 static int x86_pmu_amd_ibs_starting_cpu(unsigned int cpu)
 {
 	setup_APIC_ibs();
+
+	if (ibs_caps & IBS_CAPS_DIS) {
+		/*
+		 * IBS enable sequence:
+		 *   CTL[En] =3D 1;
+		 *   CTL2[Dis] =3D 0;
+		 *
+		 * IBS disable sequence:
+		 *   CTL2[Dis] =3D 1;
+		 *
+		 * Set CTL2[Dis] when CPU comes up. This is needed to make
+		 * enable sequence effective.
+		 */
+		wrmsrq(MSR_AMD64_IBSFETCHCTL2, IBS_FETCH_2_DIS);
+		wrmsrq(MSR_AMD64_IBSOPCTL2, IBS_OP_2_DIS);
+	}
+
 	return 0;
 }
=20

