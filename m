Return-Path: <linux-tip-commits+bounces-8283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCvcAIPMomkj5gQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:07:47 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9782B1C2740
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFBC93011171
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22668428824;
	Sat, 28 Feb 2026 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5Zuziqe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJ6Hv1xO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B72848AD;
	Sat, 28 Feb 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276864; cv=none; b=enAk/WRikG2bVtY/NWsldteqcvCLsRqwHQqEbcvXGh+6JM5P/FpP2vYccRaSMGaO5VFbhAsrSNZq8Kuj0YLozk2ePXrzZzzqeOqqBwIMJq5BfTSrv3lSZahQhQLwy8QS4vswMJbUeVblRB8sszluPiGW3GAkfvT1SVKdGPhI/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276864; c=relaxed/simple;
	bh=ujnR22b+PBbdlgiKBwqH6pO9vrCEMJq8iAZYJ7dm+fQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JYPPChHf0tgB4OqT+r7tLLCBrJdH112BOzoQvskASX1CNIwS5Q6JVKdiQY9hgnlLi9L1TbLLRJ2PKgEo0lqYaq8K3HU8Im3TwWOfJU43EF1iRVfdjt6SToIyBSKO+byZw8giWfJ2ba5x6zo3Uiw8ZqfGgcoxDhNIn8qmWamP/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5Zuziqe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJ6Hv1xO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 11:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYdtpdXMr4PNOv9zcF6+as8sVE4OKl/4YrxElhVueic=;
	b=m5ZuziqekLMXECvhOQSsM7MWoevKOXI7lw92RkHY7sJ92zxq+NV4QC1kMkKneqKfUmEn3y
	/zpDwIM0JSu+cYZ0zSElsSN8/TZW1hGb4c/5F6a+3ujRP8/P/mcUcqHrzp9zxHDgk0M5kt
	GdyaHJRhxTOYoH5nZ2baRNQevgNRT1BiZ2xTWvSBBJ95rri8xdQ8/UxcIYj5NETIUkTFzB
	SRo1GKDmJ+GT2sl8F0hpBNs/K54NgqvhPILhZsipEavqJ0C/8hYI1FjvpYbQaza+pSMUCs
	/bVavYrjj34mvhT5KRfbScAbKGqbG9u9ucrzMEBLCL4/GBoSTcv1B80oNk96Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYdtpdXMr4PNOv9zcF6+as8sVE4OKl/4YrxElhVueic=;
	b=yJ6Hv1xOqfDJTvMa9XLi/dJEWrwEd62TyCm9t8n1VOo7CSUJ02Biy62gbN4ReleInCn5tv
	l7OaHyu7zlhEZsCg==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Enable streaming store filter
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-7-ravi.bangoria@amd.com>
References: <20260216042530.1546-7-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227685991.1647592.16249172934678072524.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8283-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,vger.kernel.org:replyto,msgid.link:url,linutronix.de:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 9782B1C2740
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8ae68bfec97596a3656ce8d0a7b1240d888eab10
Gitweb:        https://git.kernel.org/tip/8ae68bfec97596a3656ce8d0a7b1240d888=
eab10
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:29=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 28 Feb 2026 12:03:29 +01:00

perf/amd/ibs: Enable streaming store filter

IBS OP on future hardware supports recording samples only for instructions
that does streaming store. Like the existing IBS filters, samples pointing
to instruction which does not cause streaming store are discarded and IBS
restarts internally.

Example:

  $ perf record -e ibs_op/strmst=3D1/ -- <workload>

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216042530.1546-7-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c      | 51 +++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/amd/ibs.h |  3 +-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 13ecc8d..0a8313e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -34,6 +34,8 @@ static u32 ibs_caps;
=20
 /* attr.config1 */
 #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+#define IBS_OP_CONFIG1_STRMST_MASK		    (1ULL << 12)
+#define IBS_OP_CONFIG1_STRMST_SHIFT			    (12)
=20
 #define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
=20
@@ -292,6 +294,14 @@ static bool perf_ibs_fetch_lat_event(struct perf_ibs *pe=
rf_ibs,
 	       (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK);
 }
=20
+static bool perf_ibs_strmst_event(struct perf_ibs *perf_ibs,
+				  struct perf_event *event)
+{
+	return perf_ibs =3D=3D &perf_ibs_op &&
+	       (ibs_caps & IBS_CAPS_STRMST_RMTSOCKET) &&
+	       (event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
@@ -419,6 +429,15 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.config |=3D fetchlat << IBS_FETCH_2_FETCHLAT_FILTER_SHIFT;
 	}
=20
+	if (perf_ibs_strmst_event(perf_ibs, event)) {
+		u64 strmst =3D event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK;
+
+		strmst >>=3D IBS_OP_CONFIG1_STRMST_SHIFT;
+
+		hwc->extra_reg.reg =3D perf_ibs->msr2;
+		hwc->extra_reg.config |=3D strmst << IBS_OP_2_STRM_ST_FILTER_SHIFT;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -709,6 +728,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
=20
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr,=
 int i)
@@ -723,6 +744,12 @@ ibs_fetch_lat_is_visible(struct kobject *kobj, struct at=
tribute *attr, int i)
 }
=20
 static umode_t
+ibs_op_strmst_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
+}
+
+static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
@@ -770,6 +797,11 @@ static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] =
=3D {
 	NULL,
 };
=20
+static struct attribute *ibs_op_strmst_cap_attrs[] =3D {
+	&ibs_op_strmst_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats =3D {
 	.name =3D "format",
 	.attrs =3D fetch_attrs,
@@ -811,6 +843,12 @@ static struct attribute_group group_ibs_op_dtlb_pgsize_c=
ap =3D {
 	.is_visible =3D ibs_op_dtlb_pgsize_is_visible,
 };
=20
+static struct attribute_group group_ibs_op_strmst_cap =3D {
+	.name =3D "caps",
+	.attrs =3D ibs_op_strmst_cap_attrs,
+	.is_visible =3D ibs_op_strmst_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] =3D {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -856,6 +894,11 @@ static struct attribute *ibs_op_ldlat_format_attrs[] =3D=
 {
 	NULL,
 };
=20
+static struct attribute *ibs_op_strmst_format_attrs[] =3D {
+	&ibs_op_strmst_format.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl =3D {
 	.name =3D "format",
 	.attrs =3D cnt_ctl_attrs,
@@ -880,6 +923,12 @@ static struct attribute_group group_ibs_op_ldlat_format =
=3D {
 	.is_visible =3D ibs_op_ldlat_is_visible,
 };
=20
+static struct attribute_group group_ibs_op_strmst_format =3D {
+	.name =3D "format",
+	.attrs =3D ibs_op_strmst_format_attrs,
+	.is_visible =3D ibs_op_strmst_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] =3D {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
@@ -887,6 +936,8 @@ static const struct attribute_group *op_attr_update[] =3D=
 {
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
 	&group_ibs_op_dtlb_pgsize_cap,
+	&group_ibs_op_strmst_cap,
+	&group_ibs_op_strmst_format,
 	NULL,
 };
=20
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index fcc8a5a..020916e 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -99,7 +99,8 @@ union ibs_op_data2 {
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
-			reserved1:56;	/* 8-63: reserved */
+			strm_st:1,	/* 8: streaming store */
+			reserved1:55;	/* 9-63: reserved */
 	};
 };
=20

