Return-Path: <linux-tip-commits+bounces-1512-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878EA91517C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EB928A7CE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558519CCE8;
	Mon, 24 Jun 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KoVAVk2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66YZTopZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898B19B5BC;
	Mon, 24 Jun 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241764; cv=none; b=uMIurtxTwjF5vCd8fIPoqml5vjhKWnYC4OBS7qX/1KUYTTGSaeb6qh4OmA/g119BjeXKWo5+vwaJ3iAOhlr3jPEE7019SFOrgNAyGrc3Teg19cbhRWrcTYXf6LLpMobjdqr9mNcov4/Mrx8zmdaYq1/Q9cY8Bd4hCdyf23aGOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241764; c=relaxed/simple;
	bh=4xZJQPKukd1Xm0BsF7g7YWV40xMQ8NLzYpPygQ+HIqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kxO6rTeTyZstjWSP07mgMiuBUvY+e0nBDuQ1+zDKgZ/C+L+JND1SK5xGeKyLggLLIV1CnPB3zPg7kAH/AzGvQkTw81321CoYWgT6qCkfapEMyl4AdaqwMoc/MZqmWV83wGIIMAnpyDv8hFI8jVGwvAR9L/c+ddG1fKpBuGvoTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KoVAVk2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66YZTopZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 15:09:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foIKz4p8S3I8pSxGkmAZu7RN8xFllcbtSeYiA43NvI0=;
	b=KoVAVk2yJHrvggrNVjd/aw7hOWr5GlEeu022anJ3RLtdWasvnHvowIBkXG/4mE7I5/zsHA
	3apWrGQqtUow1G+nst07ToF/Zj3D94hj1fq0dG31z4GyT5GR8/tosWQK0qf5a9AD1iY4ff
	RrHJD1rR/QHm3V+s7gS1jv56dAgdxmonWuqGvA8Eu+SJfdM8fFJknuW8Zqyvu0u+iYFqXb
	8YAXJ2GRpiVa0yaerf9nhoW5L5iRo+3VlNHme8b8/id2O8d8M10c+2TDPKajX6o9EjC82p
	skjILxzmH8F/1jCXOB7saKYSVdXwLp1zjm09t9XnpyGIQ202CRvdfS3oKBtpRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foIKz4p8S3I8pSxGkmAZu7RN8xFllcbtSeYiA43NvI0=;
	b=66YZTopZg6I55SGMscVW8ZspiO0rm6B+U5hDFsI6KBlTy6ul5NG1xzKPGjB1rVRTOYsPev
	6dZg6+M2KoaQFDCQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Apply the unit control RB tree to
 MMIO uncore units
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-5-kan.liang@linux.intel.com>
References: <20240614134631.1092359-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176073.10875.2731258423028850946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     80580dae65b941eb681bd79f31f64f91b58232b4
Gitweb:        https://git.kernel.org/tip/80580dae65b941eb681bd79f31f64f91b58232b4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:57 +02:00

perf/x86/uncore: Apply the unit control RB tree to MMIO uncore units

The unit control RB tree has the unit control and unit ID information
for all the units. Use it to replace the box_ctls/mmio_offsets to get
an accurate unit control address for MMIO uncore units.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 30 ++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index e61e460..ece761c 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -606,34 +606,30 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 
 #define UNCORE_GENERIC_MMIO_SIZE		0x4000
 
-static u64 generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
-{
-	struct intel_uncore_type *type = box->pmu->type;
-
-	if (!type->box_ctls || !type->box_ctls[box->dieid] || !type->mmio_offsets)
-		return 0;
-
-	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
-}
-
 void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
-	u64 box_ctl = generic_uncore_mmio_box_ctl(box);
+	static struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 
-	if (!box_ctl) {
+	unit = intel_uncore_find_discovery_unit(type->boxes, box->dieid, box->pmu->pmu_idx);
+	if (!unit) {
+		pr_warn("Uncore type %d id %d: Cannot find box control address.\n",
+			type->type_id, box->pmu->pmu_idx);
+		return;
+	}
+
+	if (!unit->addr) {
 		pr_warn("Uncore type %d box %d: Invalid box control address.\n",
-			type->type_id, type->box_ids[box->pmu->pmu_idx]);
+			type->type_id, unit->id);
 		return;
 	}
 
-	addr = box_ctl;
+	addr = unit->addr;
 	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
 	if (!box->io_addr) {
 		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
-			type->type_id, type->box_ids[box->pmu->pmu_idx],
-			(unsigned long long)addr);
+			type->type_id, unit->id, (unsigned long long)addr);
 		return;
 	}
 
@@ -722,6 +718,8 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctls = type->box_ctrl_die;
 		uncore->mmio_offsets = type->box_offset;
 		uncore->mmio_map_size = UNCORE_GENERIC_MMIO_SIZE;
+		uncore->boxes = &type->units;
+		uncore->num_boxes = type->num_units;
 		break;
 	default:
 		return false;

