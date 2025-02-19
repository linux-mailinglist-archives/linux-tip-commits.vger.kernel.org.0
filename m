Return-Path: <linux-tip-commits+bounces-3526-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95356A3BC52
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2025 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CD1188A676
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D81DED7B;
	Wed, 19 Feb 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4W0ZMYtA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8JPkOWbW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773041DED51;
	Wed, 19 Feb 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962922; cv=none; b=WgcW/P3F7PBc96EvRnbs9FDF8lwZI2PoF3unHQm53r93Umwa3s5KXXyivThJ9gkQOuSlY5CrtOXpqcSKWoHQb2rD+FDbD6JjEzK452Ic5y7KDrx6Z+JsZRsVAvIPrExNtnWoMjIlhk0dIbXrkH8NXW85pkap5GLKvj11HdiuJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962922; c=relaxed/simple;
	bh=KXs9zVzD4i6P/uQjHlzqcm7cB3eLZj2stcAgbxfgcr4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ig7Y7i/X7AAXRPSaR6Tk+b9NW+ekOn9zgMzeT2vRrvNPAOQ3WXmxM96viS2vnEN/VroRXPR8IJUlkQIrkQ1Iz1xpLMvPYUOjTKm0ma5NWUCaKKuAMnYUkcy9sk78A6bAdbP5wjzHDhpryUv6lI/LtD/wmiqPEI1uktkXZxLvJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4W0ZMYtA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8JPkOWbW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Feb 2025 11:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739962918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsWH/0Q/GbU6Ab0pHSW0TgmrfBjeO8GzULjwMkX4iek=;
	b=4W0ZMYtAlq56W8SXfWl0k6ZZiSOtjYApXG/6e59nqcsL2KN4/f//xsYAFUoXQ6ENMH3Kuc
	3ssAKk5W3vP89Dd59tuwpI+1xSu+h1VYuTmaZOjm4rB0qx9mKkVM7EWB/hxZMWOQkXXIGc
	MIcdwNunU7AZFpfj6Zf6s9WE0fVdREHPwly8YWp0Fm4bQ+p27d4pMnxZzwfTr8sk0MtWXv
	CgC4wwhwG97x5/u9EaKPasqgvbXLUPKHDjZPy9hTSDJ5rqdCCNsqFGd6umaYXK1he8toc4
	Vu3AgWP0aVesLmP07gjYPi4YxTSmRNODSn3O9QQ9peTew8QyoOlhj0FkyFZS4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739962918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsWH/0Q/GbU6Ab0pHSW0TgmrfBjeO8GzULjwMkX4iek=;
	b=8JPkOWbWlTaSscDKVYmoJGhh/E3pqmSJ1d1G4l1a0QdJ14KesfDQja/D2O1NpnNC15BnDU
	UKRPyQ8lHkVr9BBw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Update DTLB/PageSize decode logic
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250205060547.1337-3-ravi.bangoria@amd.com>
References: <20250205060547.1337-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173996291678.10177.16897526995378165102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0b347a4218da08b1eb400c259d193bff463dae87
Gitweb:        https://git.kernel.org/tip/0b347a4218da08b1eb400c259d193bff463dae87
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 05 Feb 2025 06:05:42 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Feb 2025 15:20:05 +01:00

perf/amd/ibs: Update DTLB/PageSize decode logic

IBS Op PMU on Zen5 reports DTLB and page size information differently
compared to prior generation. The change is enumerated by
CPUID_Fn8000001B_EAX[19].

  IBS_OP_DATA3     Zen3/4                 Zen5
  ----------------------------------------------------------------
  19               IbsDcL2TlbHit1G        Reserved
  ----------------------------------------------------------------
   6               IbsDcL2tlbHit2M        Reserved
  ----------------------------------------------------------------
   5               IbsDcL1TlbHit1G        PageSize:
   4               IbsDcL1TlbHit2M          0 - 4K
                                            1 - 2M
                                            2 - 1G
                                            3 - Reserved
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------
   3               IbsDcL2TlbMiss         IbsDcL2TlbMiss
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------
   2               IbsDcL1tlbMiss         IbsDcL1tlbMiss
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------

o Currently, only bit 2 and 3 are interpreted by IBS NMI handler for
  PERF_SAMPLE_DATA_SRC. Add dependency on IbsDcPhyAddrValid for those
  bits.

o Introduce new IBS Op PMU capability and expose it to userspace via
  PMU's sysfs directory.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250205060547.1337-3-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c         | 23 +++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 85b29b3..7b52b8e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -629,6 +629,7 @@ PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
+PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -642,6 +643,12 @@ ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_dtlb_pgsize_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPDTLBPGSIZE ? attr->mode : 0;
+}
+
 static struct attribute *fetch_attrs[] = {
 	&format_attr_rand_en.attr,
 	&format_attr_swfilt.attr,
@@ -663,6 +670,11 @@ static struct attribute *ibs_op_ldlat_cap_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] = {
+	&ibs_op_dtlb_pgsize_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -686,6 +698,12 @@ static struct attribute_group group_ibs_op_ldlat_cap = {
 	.is_visible = ibs_op_ldlat_is_visible,
 };
 
+static struct attribute_group group_ibs_op_dtlb_pgsize_cap = {
+	.name = "caps",
+	.attrs = ibs_op_dtlb_pgsize_cap_attrs,
+	.is_visible = ibs_op_dtlb_pgsize_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -759,6 +777,7 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_zen4_ibs_extensions,
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
+	&group_ibs_op_dtlb_pgsize_cap,
 	NULL,
 };
 
@@ -1007,6 +1026,10 @@ static void perf_ibs_get_tlb_lvl(union ibs_op_data3 *op_data3,
 	if (!op_data3->dc_lin_addr_valid)
 		return;
 
+	if ((ibs_caps & IBS_CAPS_OPDTLBPGSIZE) &&
+	    !op_data3->dc_phy_addr_valid)
+		return;
+
 	if (!op_data3->dc_l1tlb_miss) {
 		data_src->mem_dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
 		return;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a60efe4..43b17b7 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -503,6 +503,7 @@ struct pebs_cntr_header {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\

