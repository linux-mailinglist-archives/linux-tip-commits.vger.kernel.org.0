Return-Path: <linux-tip-commits+bounces-3042-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB29E9991
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B1B167684
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0661BEF89;
	Mon,  9 Dec 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuHerrgh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCvoq/RQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198D1BEF64;
	Mon,  9 Dec 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756121; cv=none; b=Ea0DNhpP/jLi8m5+f+8khRH5tD+g4OkIIJJ3ioKbuxE+ew+jdROIU9YfTpI2cCbrA+yKdOksRbC2CIFMH2Hi3jnGKnadacNLnkfY5dwzDnx1ZZcNLp4TMS271ymzrk0mt3n0nxWJJu6dl5DiPuANfsQm+YuN9/WKFpu7kZbwbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756121; c=relaxed/simple;
	bh=AN0lwAsq7S+wI26QioqX7em9swSI1y79xx2QrWhKEVg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pz1T7LrCmdNMtdl6FtOqu5k3DIpHnqgQyJjreGXbqr2QbdpG64Ta/tWbu5QAQwvCE5Sfn/fD+IHFl/9BA4Bxv5ZssAZ/+2jp6Kb2kvnFCI3eW045VDHUdTqor+qK50BLccA1TIjwe7Ry4uPGJBdE0MyZxADlERH/wu0q6rf2H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuHerrgh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCvoq/RQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 14:55:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733756117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hLMKBXS/li7gug90+KsYqWa4/VZdytLjvSTZCtRnsM=;
	b=ZuHerrghdESGdv3bC6H5qVaEHKHXw+AJVw43efWgEHnx/QqEqeZ/2tlUmZRFYc/lm3E3CA
	bTktOTTVD9uyV17SlEUQgif8xPu3hrW8hvAaSlwczAz/d9bmzya45we3uBJf924EdPAdfc
	/CGJCcV7YSFwh+unpBO69lajFn+sLPXohcqb991F7JonmQ/z/CPjM7uL6JUqp6gazbR9W4
	gbeoW87XDrYM2ZcKqe9q7TrvU6oMCTnJB9FR9fiGsfIwqEyDK+MNiHkPO2ewADNIG2Mcul
	aoLCppE6I5NDVsXsV0QPA5t/OLm4u/M30Uhqz90EQxcOjEL1G3ZCsfY4THoHRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733756117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hLMKBXS/li7gug90+KsYqWa4/VZdytLjvSTZCtRnsM=;
	b=KCvoq/RQjD70/1flH2yd6TytHdyssqXfvBKaeJWbn7RKkLFTU1AgFltBiDiKbbtCw9pBta
	gDLmiVExvoRcrmCg==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86: Relax privilege filter restriction on AMD IBS
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241203180441.1634709-3-namhyung@kernel.org>
References: <20241203180441.1634709-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173375611540.412.13627544006357536448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d29e744c71673a71da8f8522799ee02744cad6c9
Gitweb:        https://git.kernel.org/tip/d29e744c71673a71da8f8522799ee02744cad6c9
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 03 Dec 2024 10:04:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Dec 2024 15:50:32 +01:00

perf/x86: Relax privilege filter restriction on AMD IBS

While IBS is available for per-thread profiling, still regular users
cannot open an event due to the default paranoid setting (2) which
doesn't allow unprivileged users to get kernel samples.  That means
it needs to set exclude_kernel bit in the attribute but IBS driver
would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
we want and I've been getting requests to fix this issue.

This should be done in the hardware, but until we get the HW fix we may
allow exclude_{kernel,user,hv} in the attribute and silently drop the
samples in the PMU IRQ handler.  It won't guarantee the sampling
frequency or even it'd miss some with fixed period too.  Not ideal,
but that'd still be helpful to regular users.

To minimize the confusion, let's add 'swfilt' bit to attr.config2 which
is exposed in the sysfs format directory so that users can figure out
if the kernel support the privilege filters by software.

  $ perf record -e ibs_op/swfilt=1/u true

This uses perf_exclude_event() which checks regs->cs.  But it should be
fine because set_linear_ip() also updates the CS according to the RIP
provided by IBS.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241203180441.1634709-3-namhyung@kernel.org
---
 arch/x86/events/amd/ibs.c | 59 ++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f029396..e7a8b87 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -31,6 +31,8 @@ static u32 ibs_caps;
 #define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
 #define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
 
+/* attr.config2 */
+#define IBS_SW_FILTER_MASK	1
 
 /*
  * IBS states:
@@ -290,6 +292,16 @@ static int perf_ibs_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* handle exclude_{user,kernel} in the IRQ handler */
+	if (event->attr.exclude_host || event->attr.exclude_guest ||
+	    event->attr.exclude_idle)
+		return -EINVAL;
+
+	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    (event->attr.exclude_kernel || event->attr.exclude_user ||
+	     event->attr.exclude_hv))
+		return -EINVAL;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -550,24 +562,14 @@ static struct attribute *attrs_empty[] = {
 	NULL,
 };
 
-static struct attribute_group empty_format_group = {
-	.name = "format",
-	.attrs = attrs_empty,
-};
-
 static struct attribute_group empty_caps_group = {
 	.name = "caps",
 	.attrs = attrs_empty,
 };
 
-static const struct attribute_group *empty_attr_groups[] = {
-	&empty_format_group,
-	&empty_caps_group,
-	NULL,
-};
-
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
+PMU_FORMAT_ATTR(swfilt,		"config2:0");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
@@ -578,8 +580,9 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
-static struct attribute *rand_en_attrs[] = {
+static struct attribute *fetch_attrs[] = {
 	&format_attr_rand_en.attr,
+	&format_attr_swfilt.attr,
 	NULL,
 };
 
@@ -593,9 +596,9 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group group_rand_en = {
+static struct attribute_group group_fetch_formats = {
 	.name = "format",
-	.attrs = rand_en_attrs,
+	.attrs = fetch_attrs,
 };
 
 static struct attribute_group group_fetch_l3missonly = {
@@ -611,7 +614,7 @@ static struct attribute_group group_zen4_ibs_extensions = {
 };
 
 static const struct attribute_group *fetch_attr_groups[] = {
-	&group_rand_en,
+	&group_fetch_formats,
 	&empty_caps_group,
 	NULL,
 };
@@ -628,6 +631,11 @@ cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return ibs_caps & IBS_CAPS_OPCNT ? attr->mode : 0;
 }
 
+static struct attribute *op_attrs[] = {
+	&format_attr_swfilt.attr,
+	NULL,
+};
+
 static struct attribute *cnt_ctl_attrs[] = {
 	&format_attr_cnt_ctl.attr,
 	NULL,
@@ -638,6 +646,11 @@ static struct attribute *op_l3missonly_attrs[] = {
 	NULL,
 };
 
+static struct attribute_group group_op_formats = {
+	.name = "format",
+	.attrs = op_attrs,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -650,6 +663,12 @@ static struct attribute_group group_op_l3missonly = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static const struct attribute_group *op_attr_groups[] = {
+	&group_op_formats,
+	&empty_caps_group,
+	NULL,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
@@ -667,7 +686,6 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_CONFIG_MASK,
@@ -691,7 +709,6 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
@@ -1111,6 +1128,12 @@ fail:
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    perf_exclude_event(event, &regs)) {
+		throttle = perf_event_account_interrupt(event);
+		goto out;
+	}
+
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
 			.frag = {
@@ -1227,7 +1250,7 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 
-	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
+	perf_ibs_op.pmu.attr_groups = op_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
 	return perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");

