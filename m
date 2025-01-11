Return-Path: <linux-tip-commits+bounces-3202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6369CA0A3DB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 14:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734A2164207
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381B199234;
	Sat, 11 Jan 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8y6CLrq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwuaYsS0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00A191F60;
	Sat, 11 Jan 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601721; cv=none; b=sb1WzF+hFADANEfyqF6yqYydznEdz6JGtwc4rr9183oY8PDXF5A66zgFJLHvP6Ei+C9jxVRnwGNfuRvEftb5/bTdumE0PZEqYyXwISz+hb+4hN/9ghAtntRJM0CG2YYx9p2Zsri+oJKEPn82oel4vIp+OJFyrL0c26mECOAZsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601721; c=relaxed/simple;
	bh=5WY8oIapPutyCyWtEWWT0VN5hVF+qWi8xJmCswlgAlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uEjeywOzd/dboBT+C5QXqkkSszMXVRVfuzsPSl1xV7qmWQiU/vc9AvrJxCpWldla6EctRC1veJBSSgnhLckFUq+5Z2gX+XFeIpkMqkPrlNrqEAs/4xhy2q16rnwvJP27AQ2ULngBjyQPOmpI2J/ixSaVR+oU6oK4HhiP7l7jSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8y6CLrq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwuaYsS0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 11 Jan 2025 13:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736601718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2IfcjZEV3VAXPlmpq7Ysu59lvxWT1ya851j/Dvdmns=;
	b=S8y6CLrqBYrs4tgmLqr0ImU+5EOi2YL6vDYdaavwEPwCc3B/V+BI/FMWksTUPlPgj5HiZP
	SJvyndUumz0DBreC94hopIMaUcAyUU1khsvj4nYz3+im8fky1NCOIxK5D0XEoh/yrwUFCq
	qt8xXeFdXeYckwgmebjmh0+HKdjvij0zg39F9gdQAdnYXpYE6dApaN0MrlZfRK+IKwwdoQ
	/+67NtmJlgU8rXf2CbnXMExkuc0W0bn6YHvdgSZM+XfjbPQQj6b1UGKR5iZ7ycPFeyv3yi
	SiCaqSlxVbqOuIZLBjY0zrEnxexxLpHcwaIpUK5fhoOoU+Sf0beQY/luT8yYNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736601718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2IfcjZEV3VAXPlmpq7Ysu59lvxWT1ya851j/Dvdmns=;
	b=JwuaYsS0rP+cy+/0wYUBLO4uUM7WdbBnYNtb+fc7Q4u4Fkbwnohxhm/inOUuf/hpiNoqLL
	YUvvIvz+G3cGyuAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Support more units on Granite Rapids
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Eric Hu <eric.hu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250108143017.1793781-2-kan.liang@linux.intel.com>
References: <20250108143017.1793781-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173660171775.399.3417251032193015241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6d642735cdb6cdb814d2b6c81652caa53ce04842
Gitweb:        https://git.kernel.org/tip/6d642735cdb6cdb814d2b6c81652caa53ce04842
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 08 Jan 2025 06:30:17 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jan 2025 18:16:50 +01:00

perf/x86/intel/uncore: Support more units on Granite Rapids

The same CXL PMONs support is also avaiable on GNR. Apply
spr_uncore_cxlcm and spr_uncore_cxldp to GNR as well.

The other units were broken on early HW samples, so they were ignored in
the early enabling patch. The issue has been fixed and verified on the
later production HW. Add UPI, B2UPI, B2HOT, PCIEX16 and PCIEX8 for GNR.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Eric Hu <eric.hu@intel.com>
Link: https://lkml.kernel.org/r/20250108143017.1793781-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++++++---------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ca98744..60973c2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6684,17 +6684,8 @@ void spr_uncore_mmio_init(void)
 /* GNR uncore support */
 
 #define UNCORE_GNR_NUM_UNCORE_TYPES	23
-#define UNCORE_GNR_TYPE_15		15
-#define UNCORE_GNR_B2UPI		18
-#define UNCORE_GNR_TYPE_21		21
-#define UNCORE_GNR_TYPE_22		22
 
 int gnr_uncore_units_ignore[] = {
-	UNCORE_SPR_UPI,
-	UNCORE_GNR_TYPE_15,
-	UNCORE_GNR_B2UPI,
-	UNCORE_GNR_TYPE_21,
-	UNCORE_GNR_TYPE_22,
 	UNCORE_IGNORE_END
 };
 
@@ -6703,6 +6694,31 @@ static struct intel_uncore_type gnr_uncore_ubox = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct intel_uncore_type gnr_uncore_pciex8 = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "pciex8",
+};
+
+static struct intel_uncore_type gnr_uncore_pciex16 = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "pciex16",
+};
+
+static struct intel_uncore_type gnr_uncore_upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "upi",
+};
+
+static struct intel_uncore_type gnr_uncore_b2upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "b2upi",
+};
+
+static struct intel_uncore_type gnr_uncore_b2hot = {
+	.name			= "b2hot",
+	.attr_update		= uncore_alias_groups,
+};
+
 static struct intel_uncore_type gnr_uncore_b2cmi = {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			= "b2cmi",
@@ -6727,21 +6743,21 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	&gnr_uncore_ubox,
 	&spr_uncore_imc,
 	NULL,
+	&gnr_uncore_upi,
 	NULL,
 	NULL,
 	NULL,
+	&spr_uncore_cxlcm,
+	&spr_uncore_cxldp,
 	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
+	&gnr_uncore_b2hot,
 	&gnr_uncore_b2cmi,
 	&gnr_uncore_b2cxl,
-	NULL,
+	&gnr_uncore_b2upi,
 	NULL,
 	&gnr_uncore_mdf_sbo,
-	NULL,
-	NULL,
+	&gnr_uncore_pciex16,
+	&gnr_uncore_pciex8,
 };
 
 static struct freerunning_counters gnr_iio_freerunning[] = {

