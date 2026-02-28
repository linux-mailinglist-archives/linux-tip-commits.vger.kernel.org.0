Return-Path: <linux-tip-commits+bounces-8268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB/zGnTKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:59:00 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D10391C2632
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3D130A5733
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535B42B748;
	Sat, 28 Feb 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uylQFAo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpX7z521"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DED429801;
	Sat, 28 Feb 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276201; cv=none; b=DYzu9oaX4COMWmYVOPG/FsLvTzo38cZ1C/rj1SBf0yG7d0fj9RjGypoIaq12aVjUgtxMhu1MO5TdAJZVIfQcObbIwcD2n3TXAMg27EnxI5rzwrfRLeNKlOisrWSJB4liE3LGaTADnFPACn19B314ltK0QDc8tMdhjSia27yR5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276201; c=relaxed/simple;
	bh=5kYqJig21tNbWJZxwdQOcHjkrZN5WhDhx3Djgv0NdLg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j5UQHuX3Am9/EAJhke6Wizx7q6VcqzBNd7AMoz8ng3+ar4ClsXAcUQdBMl+lT59m8qvp46TjrphJsJWvA/VrtRTFbLbYS3RyL65TrQZLLFdAKr37TENrjZj8cVIeuEn1kquu/x4hNE5pUDY6jzbzx96XdNVQUl+MwGWGWPKl0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uylQFAo/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpX7z521; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZO2fZVUutL3WKy4VLppJhwQKNaJUrnFMxqMlAgYkl4=;
	b=uylQFAo/BOLKO9ZdHvIVRpGeFxg+JvJWXRoDL8q32PELe0oobemprKSgSdrD6dGi4B5Qov
	uAPlYdI525K5yembST0dOOdDUrZCL1JIgdDzn/Mf/6fNB4O3KdU/8Y/bczMTM5pHyratWb
	aulhpooW+ZIhBcWh+bob0NslHrZL8rcW0Uog+xTubCh9xH746RNpOwp32efbms7jij0ofE
	r+pKwzI8eB5JTKkfpPvviYomWtL2FpH9fqguK/RRYc58l/+LF+I8oSbFHA/+zb2fwGxrNC
	lsswkcugTGdfZrTSlNgPE2BnzhHoj7XDRjxdLqheLdlzMBF72KdvKnMqEr523Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZO2fZVUutL3WKy4VLppJhwQKNaJUrnFMxqMlAgYkl4=;
	b=ZpX7z521+vaZcmeFYY4aL4yzqyiIx9RzLnqV4oO1cci2nio4MFBtKSRlcOFBk4IFkT4tEY
	vKgXxAFlJr02ZuCg==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Enable RIP bit63 hardware filtering
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-6-ravi.bangoria@amd.com>
References: <20260216042530.1546-6-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227619544.1647592.11501282078246744592.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8268-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,infradead.org:email,linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: D10391C2632
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     62ed6df2c8078725ba5bfb6ca2d06acc8d15bd36
Gitweb:        https://git.kernel.org/tip/62ed6df2c8078725ba5bfb6ca2d06acc8d1=
5bd36
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:28=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:25 +01:00

perf/amd/ibs: Enable RIP bit63 hardware filtering

IBS on future hardware adds the ability to filter IBS events by examining
RIP bit 63. Because Linux kernel addresses always have bit 63 set while
user-space addresses never do, this capability can be used as a privilege
filter.

So far, IBS supports privilege filtering in software (swfilt=3D1), where
samples are dropped in the NMI handler. The RIP bit63 hardware filter
enables IBS to be usable by unprivileged users without passing swfilt
flag. So, swfilt flag will silently be ignored when the hardware
filtering capability is present.

Example (non-root user):
  $ perf record -e ibs_op//u -- <workload>

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216042530.1546-6-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 46 +++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index cb3ae4e..13ecc8d 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -321,11 +321,6 @@ static int perf_ibs_init(struct perf_event *event)
 	    event->attr.exclude_idle)
 		return -EINVAL;
=20
-	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (event->attr.exclude_kernel || event->attr.exclude_user ||
-	     event->attr.exclude_hv))
-		return -EINVAL;
-
 	ret =3D validate_group(event);
 	if (ret)
 		return ret;
@@ -338,6 +333,32 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.reg =3D perf_ibs->msr2;
 	}
=20
+	if (ibs_caps & IBS_CAPS_BIT63_FILTER) {
+		if (perf_ibs =3D=3D &perf_ibs_fetch) {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |=3D IBS_FETCH_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg =3D perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |=3D IBS_FETCH_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg =3D perf_ibs->msr2;
+			}
+		} else {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |=3D IBS_OP_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg =3D perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |=3D IBS_OP_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg =3D perf_ibs->msr2;
+			}
+		}
+	} else if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+		   (event->attr.exclude_kernel || event->attr.exclude_user ||
+		    event->attr.exclude_hv)) {
+		return -EINVAL;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -1280,7 +1301,7 @@ static bool perf_ibs_is_kernel_br_target(struct perf_ev=
ent *event,
 			op_data.op_brn_ret && kernel_ip(br_target));
 }
=20
-static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_e=
vent *event,
+static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct perf_e=
vent *event,
 				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
 				    int br_target_idx)
 {
@@ -1435,8 +1456,9 @@ fail:
 		regs.flags |=3D PERF_EFLAGS_EXACT;
 	}
=20
-	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_id=
x)) {
+	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
+	     (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
+	    perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br_target_id=
x)) {
 		throttle =3D perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1899,6 +1921,14 @@ static __init int amd_ibs_init(void)
=20
 	perf_ibs_pm_init();
=20
+#ifdef CONFIG_X86_32
+	/*
+	 * IBS_CAPS_BIT63_FILTER is used for exclude_kernel/user filtering,
+	 * which obviously won't work for 32 bit kernel.
+	 */
+	caps &=3D ~IBS_CAPS_BIT63_FILTER;
+#endif
+
 	ibs_caps =3D caps;
 	/* make ibs_caps visible to other cpus: */
 	smp_mb();

