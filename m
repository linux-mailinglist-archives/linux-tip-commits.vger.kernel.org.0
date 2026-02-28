Return-Path: <linux-tip-commits+bounces-8285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULILEMTMomkj5gQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:08:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBAE1C27A1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D4683076512
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F442E01A;
	Sat, 28 Feb 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H7oJhm0T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkERLNBt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBA42DFF8;
	Sat, 28 Feb 2026 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276866; cv=none; b=FxcKjdBb8lhQou9MhTfsP9AXCTS0x1jK9H4qAUQeR/dmQNEjiNxUtdLmhyl1M3qsETeTTcsWkuv2XECQksRPTvf7wxQtgpBZ0iGWdsuH+9WyHJfxrEIYrcpwQj2aD5lnmj3cTldxhV1BpvVVnS/mSwYoW3g9zL5xN1XMaCmVPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276866; c=relaxed/simple;
	bh=6r9irqBREcK2Vw7TUsyGrU4mfyM/0CIQOGrN66KkDlo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VcNOiZQazP8H7wvghxTsfnPlZu3Ond2KM+VXNF4xl3jD4Pi0uIMuUHyWHKWPc6se7MsXXC/TXrnCiGWNyCjvoZk3e/GgxNGP+K0OHZk6+XZpLecqMSZPbrdQ84PNw0Fhmsr/bk9jTsVLNMKqvKGZ4d5ikJbsTl1Koz5YTdzy0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H7oJhm0T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkERLNBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 11:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekdm68ILi+NDH/ngvWY5DNdfrKm+qFCG4DLrcinIa9w=;
	b=H7oJhm0TZG2a9ct0NwuwB6Yt8pq11vf9EBe68WvmTxdBAjh9jtxm/enO2fxBkxFVqORJZi
	VBwULJ2OI53y/YZVMoaz7Q/R11dNX1h65/IXDjrFOiH12sG8dehiyzEPiSy+HbkIbsMN1n
	pmEG4BsBHcMTOiGc3gXH3orpO/UeTSa9FSYJfAq1BejdBMu/W9CG6/5MSEgoCFl2FgLMg9
	UJ8vP3BEkLXEQzO8CcPXomtUwY1jj+YqKIn+tEXe4sbElLI3wsGRKQcgsJmNCOS//8PtJ2
	NG65SGb4rOsnrdUokxbhuj+xM6cWCdpe2o2ySF3K3lQ07/dTEo1BlTap5N17+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekdm68ILi+NDH/ngvWY5DNdfrKm+qFCG4DLrcinIa9w=;
	b=DkERLNBtC9eXyS6cNwliPA6P+h5QV5FTpAsnRqGdJtyFVNMF2KSAZ1XfCEqXqKPARnEKRK
	FXrOpn66wIlfG1BA==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Enable fetch latency filtering
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-5-ravi.bangoria@amd.com>
References: <20260216042530.1546-5-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227686219.1647592.1502804905828368056.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8285-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,infradead.org:email];
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
X-Rspamd-Queue-Id: 8DBAE1C27A1
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     35247fa60b74e1c643423c3bc7c6a59cbca262bb
Gitweb:        https://git.kernel.org/tip/35247fa60b74e1c643423c3bc7c6a59cbca=
262bb
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:27=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 28 Feb 2026 12:03:29 +01:00

perf/amd/ibs: Enable fetch latency filtering

IBS Fetch on future hardware adds fetch latency filtering which
generates interrupt only when FetchLat value exceeds a programmable
threshold.

Hardware allows threshold in 128-cycle increment (i.e. 128, 256, 384
etc.) from 128 to 1920 cycles. Like the existing IBS filters, samples
that fail the latency test are dropped and IBS restarts internally.

Since hardware supports threshold in multiple of 128, add a software
filter on top to support latency threshold with the granularity of 1
cycle in between [128-1920].

Example:
  # perf record -e ibs_fetch/fetchlat=3D128/ -c 10000 -a -- sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216042530.1546-5-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 66 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index b7f0aad..cb3ae4e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -35,6 +35,8 @@ static u32 ibs_caps;
 /* attr.config1 */
 #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
=20
+#define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
+
 /*
  * IBS states:
  *
@@ -282,6 +284,14 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_i=
bs,
 	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
 }
=20
+static bool perf_ibs_fetch_lat_event(struct perf_ibs *perf_ibs,
+				     struct perf_event *event)
+{
+	return perf_ibs =3D=3D &perf_ibs_fetch &&
+	       (ibs_caps & IBS_CAPS_FETCHLAT) &&
+	       (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
@@ -377,6 +387,17 @@ static int perf_ibs_init(struct perf_event *event)
 			config |=3D IBS_OP_L3MISSONLY;
 	}
=20
+	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
+		u64 fetchlat =3D event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK;
+
+		if (fetchlat < 128 || fetchlat > 1920)
+			return -EINVAL;
+		fetchlat >>=3D 7;
+
+		hwc->extra_reg.reg =3D perf_ibs->msr2;
+		hwc->extra_reg.config |=3D fetchlat << IBS_FETCH_2_FETCHLAT_FILTER_SHIFT;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -665,6 +686,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config=
1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
=20
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr,=
 int i)
@@ -673,6 +696,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, str=
uct attribute *attr, int
 }
=20
 static umode_t
+ibs_fetch_lat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_FETCHLAT ? attr->mode : 0;
+}
+
+static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
@@ -700,6 +729,16 @@ static struct attribute *zen4_ibs_extensions_attrs[] =3D=
 {
 	NULL,
 };
=20
+static struct attribute *ibs_fetch_lat_format_attrs[] =3D {
+	&ibs_fetch_lat_format.attr.attr,
+	NULL,
+};
+
+static struct attribute *ibs_fetch_lat_cap_attrs[] =3D {
+	&ibs_fetch_lat_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute *ibs_op_ldlat_cap_attrs[] =3D {
 	&ibs_op_ldlat_cap.attr.attr,
 	NULL,
@@ -727,6 +766,18 @@ static struct attribute_group group_zen4_ibs_extensions =
=3D {
 	.is_visible =3D zen4_ibs_extensions_is_visible,
 };
=20
+static struct attribute_group group_ibs_fetch_lat_cap =3D {
+	.name =3D "caps",
+	.attrs =3D ibs_fetch_lat_cap_attrs,
+	.is_visible =3D ibs_fetch_lat_is_visible,
+};
+
+static struct attribute_group group_ibs_fetch_lat_format =3D {
+	.name =3D "format",
+	.attrs =3D ibs_fetch_lat_format_attrs,
+	.is_visible =3D ibs_fetch_lat_is_visible,
+};
+
 static struct attribute_group group_ibs_op_ldlat_cap =3D {
 	.name =3D "caps",
 	.attrs =3D ibs_op_ldlat_cap_attrs,
@@ -748,6 +799,8 @@ static const struct attribute_group *fetch_attr_groups[] =
=3D {
 static const struct attribute_group *fetch_attr_update[] =3D {
 	&group_fetch_l3missonly,
 	&group_zen4_ibs_extensions,
+	&group_ibs_fetch_lat_cap,
+	&group_ibs_fetch_lat_format,
 	NULL,
 };
=20
@@ -1191,7 +1244,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *per=
f_ibs,
 {
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
-	    perf_ibs_ldlat_event(perf_ibs, event))
+	    perf_ibs_ldlat_event(perf_ibs, event) ||
+	    perf_ibs_fetch_lat_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1333,6 +1387,16 @@ fail:
 		}
 	}
=20
+	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
+		union ibs_fetch_ctl fetch_ctl;
+
+		fetch_ctl.val =3D ibs_data.regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)];
+		if (fetch_ctl.fetch_lat < (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLA=
T_MASK)) {
+			throttle =3D perf_event_account_interrupt(event);
+			goto out;
+		}
+	}
+
 	/*
 	 * Read IbsBrTarget, IbsOpData4, and IbsExtdCtl separately
 	 * depending on their availability.

