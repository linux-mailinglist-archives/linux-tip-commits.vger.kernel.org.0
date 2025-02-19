Return-Path: <linux-tip-commits+bounces-3527-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C95A3BC57
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2025 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A127A6FD4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2025 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ECD1DEFEC;
	Wed, 19 Feb 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qepzxARU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtFy22i4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F381DED66;
	Wed, 19 Feb 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962923; cv=none; b=SCR2UHLzTrfU3EF3JFpXUUPNmaf8GIDAi8PvA/epFv6RKJljGEPpKnSVlWbJBVkXFtXaTcvbgxdPTuNuIk0wRLGnKm9RehhC/23G5GsgnSASS03KXSJ6aLNr33EhY6zmsNcEtf/bWMa5jShSRv67qaxy//uLR0+uA7olAM1X8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962923; c=relaxed/simple;
	bh=wSGiHDYpZmqCFCnTfczpoGZspfQNsfdzrbbOclrs4/Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bFW2yoCUqMthoZOFaZGEDVAarNzzbwpRX1GdKW2vD7p6R+iWvi5F3i0uranVGzflKQVT7CU/8y4UG6h9g2cKx3/yA2wIQYbPfSAdR5LPt6rZKhhODrOMwPJ8j33lGoa8A2QyACSGzC10uP+h7ErfsMhDBplrAdwkNeQ7XCvmG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qepzxARU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtFy22i4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Feb 2025 11:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739962919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QFH8QZMPfgOsO8kUPkQJ/xHIvM7+NM4rjjruTpO+Qc=;
	b=qepzxARU4KtRVC7iG7uT9GUQdwdDeMrUGb4wKADFmn6m23ZOtBvyeaaexDieKOz3+OaCqx
	m3eiSugsivX2zDApSzfLXtoO9bG2/Vq7uJVsbQbhOicxmnVjqMNZOC6DFZG+n77O7ZAIzG
	FKUVy548H5YpSUe029YVoufprp0d4LwRxmBdo4zJ27lcm3aRgOvX1rpwk/cUYDlzDhFepG
	MaUi84qVnpJTVlhwcyyiz0eFrbQQG5EeVSGApCsVk2pzPeqVVZnbtPEaNUT8C/smKQdJy1
	5utXbHCOl6TWZGzHQfFiG8OzrafB8sIMU+nm8bl2S47l93xrqVzvI5NqhXfx7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739962919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QFH8QZMPfgOsO8kUPkQJ/xHIvM7+NM4rjjruTpO+Qc=;
	b=qtFy22i49It4lPWchAQ2GKeMpqDxU/N6ekoLRM8mirkVFpoNJmlxx6KVyHOZz0TDzd79lO
	onGv+hveksIPOoDw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/amd/ibs: Add support for OP Load Latency Filtering
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250205060547.1337-2-ravi.bangoria@amd.com>
References: <20250205060547.1337-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173996291875.10177.14881913290222780210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d20610c19b4a22bc69085b7eb7a02741d51de30e
Gitweb:        https://git.kernel.org/tip/d20610c19b4a22bc69085b7eb7a02741d51de30e
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 05 Feb 2025 06:05:41 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Feb 2025 15:20:05 +01:00

perf/amd/ibs: Add support for OP Load Latency Filtering

IBS Op PMU on Zen5 uarch added new Load Latency filtering capability. It's
advertised by CPUID_Fn8000001B_EAX bit 12. When enabled, IBS HW will raise
interrupt only for sample that had an IbsDcMissLat value greater than N
cycles, where N is a programmable value defined as multiples of 128 (i.e.
128, 256, 384 etc.) from 128-2048 cycles. Similar to L3MissOnly, IBS HW
internally drops the sample and restarts if the sample does not meet the
filtering criteria.

Add support for LdLat filtering in IBS Op PMU. Since hardware supports
threshold in multiple of 128, add a software filter on top to support
latency threshold with the granularity of 1 cycle between [128-2048].

Example usage:
  # perf record -a -e ibs_op/ldlat=128/ -- sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250205060547.1337-2-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c         | 93 +++++++++++++++++++++++++++---
 arch/x86/include/asm/amd-ibs.h    |  3 +-
 arch/x86/include/asm/perf_event.h |  3 +-
 3 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7978d79..85b29b3 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -268,6 +268,14 @@ static int validate_group(struct perf_event *event)
 	return 0;
 }
 
+static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
+				 struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
+	       (event->attr.config1 & 0xFFF);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -339,6 +347,17 @@ static int perf_ibs_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	if (perf_ibs_ldlat_event(perf_ibs, event)) {
+		u64 ldlat = event->attr.config1 & 0xFFF;
+
+		if (ldlat < 128 || ldlat > 2048)
+			return -EINVAL;
+		ldlat >>= 7;
+
+		config |= (ldlat - 1) << 59;
+		config |= IBS_OP_L3MISSONLY | IBS_OP_LDLAT_EN;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -607,7 +626,9 @@ PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_FORMAT_ATTR(swfilt,		"config2:0");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -615,6 +636,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
+}
+
 static struct attribute *fetch_attrs[] = {
 	&format_attr_rand_en.attr,
 	&format_attr_swfilt.attr,
@@ -631,6 +658,11 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_ldlat_cap_attrs[] = {
+	&ibs_op_ldlat_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -648,6 +680,12 @@ static struct attribute_group group_zen4_ibs_extensions = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_ibs_op_ldlat_cap = {
+	.name = "caps",
+	.attrs = ibs_op_ldlat_cap_attrs,
+	.is_visible = ibs_op_ldlat_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -686,6 +724,11 @@ static struct attribute_group group_op_formats = {
 	.attrs = op_attrs,
 };
 
+static struct attribute *ibs_op_ldlat_format_attrs[] = {
+	&ibs_op_ldlat_format.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -704,10 +747,18 @@ static const struct attribute_group *op_attr_groups[] = {
 	NULL,
 };
 
+static struct attribute_group group_ibs_op_ldlat_format = {
+	.name = "format",
+	.attrs = ibs_op_ldlat_format_attrs,
+	.is_visible = ibs_op_ldlat_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
 	&group_zen4_ibs_extensions,
+	&group_ibs_op_ldlat_cap,
+	&group_ibs_op_ldlat_format,
 	NULL,
 };
 
@@ -1060,15 +1111,25 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 	}
 }
 
-static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
+static bool perf_ibs_is_mem_sample_type(struct perf_ibs *perf_ibs,
+					struct perf_event *event)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	return perf_ibs == &perf_ibs_op &&
+	       sample_type & (PERF_SAMPLE_DATA_SRC |
+			      PERF_SAMPLE_WEIGHT_TYPE |
+			      PERF_SAMPLE_ADDR |
+			      PERF_SAMPLE_PHYS_ADDR);
+}
+
+static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
+				   struct perf_event *event,
 				   int check_rip)
 {
-	if (sample_type & PERF_SAMPLE_RAW ||
-	    (perf_ibs == &perf_ibs_op &&
-	     (sample_type & PERF_SAMPLE_DATA_SRC ||
-	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
-	      sample_type & PERF_SAMPLE_ADDR ||
-	      sample_type & PERF_SAMPLE_PHYS_ADDR)))
+	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
+	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
+	    perf_ibs_ldlat_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1123,7 +1184,7 @@ fail:
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
 
-	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event, check_rip);
 
 	do {
 		rdmsrl(msr + offset, *buf++);
@@ -1132,6 +1193,22 @@ fail:
 				       perf_ibs->offset_max,
 				       offset + 1);
 	} while (offset < offset_max);
+
+	if (perf_ibs_ldlat_event(perf_ibs, event)) {
+		union ibs_op_data3 op_data3;
+
+		op_data3.val = ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+		/*
+		 * Opening event is errored out if load latency threshold is
+		 * outside of [128, 2048] range. Since the event has reached
+		 * interrupt handler, we can safely assume the threshold is
+		 * within [128, 2048] range.
+		 */
+		if (!op_data3.ld_op || !op_data3.dc_miss ||
+		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
+			goto out;
+	}
+
 	/*
 	 * Read IbsBrTarget, IbsOpData4, and IbsExtdCtl separately
 	 * depending on their availability.
diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index cb2a5e1..77f3a58 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -64,7 +64,8 @@ union ibs_op_ctl {
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
 			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved1:5;	/* 59-63: reserved */
+			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
+			ldlat_en:1;	/* 63: Load Latency enabled */
 	};
 };
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 73b1040..a60efe4 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -502,6 +502,7 @@ struct pebs_cntr_header {
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
+#define IBS_CAPS_OPLDLAT		(1U<<12)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -527,6 +528,8 @@ struct pebs_cntr_header {
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
+#define IBS_OP_LDLAT_EN		(1ULL<<63)
+#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)

