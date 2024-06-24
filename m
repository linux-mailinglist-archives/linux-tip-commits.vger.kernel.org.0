Return-Path: <linux-tip-commits+bounces-1511-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355791517A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA1F28A7FB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D019B5BF;
	Mon, 24 Jun 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YLalL5v/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uuLa8da6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140D19B3DD;
	Mon, 24 Jun 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241763; cv=none; b=O1ge/A1ThvPsCIDRb6KGsslnT2Lf+N+PnOl/rN5yT+4IOmHq8xbxRQSaeazx76JHRB3SKhXHaZbA/ZCt4rzy8yB3vNHrU1kvrARVSNrVq5mTtIU8s6pA9acvgExCrTcgmdyEeOGfEjUkREywC7QoIosSjGkyX1xDYliOc2TMWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241763; c=relaxed/simple;
	bh=FILtOui0cyM143IzRiIW8gYUTvdITQCW1Bvp0fMKuNU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CBDrQEgBCT2mtB3i7Pg2ZMiQMU1AHxDF4UBNvBDm/eg+PQFXnKr47aVTkWhQszeAFANXTliqh0IeWObBfZYdWo5HXJtKRXp3b7+7tpiPvBgWaGhP/GsjUswcDGEpnKkOrO43/0ShnQ93tT/1np/Tnh5ckLhRwstbHtbCQ0FD9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YLalL5v/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uuLa8da6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 15:09:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719241760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YjAmwyU2I36ExxuOlcSmwuiYuD9EafTB1DYtgEfIeY=;
	b=YLalL5v/7yiQQ1s0ACfLFTM/KT63YEycJmZkwHcIeBYWUAQ3OPaCztS5XW5bWf6q4jTk/S
	jUBhWXnSwUhwCBUO1ULCIxjUownTvZAcRwQaldui2Ghw13amx/w38thHKn8aLH8dnhDOx+
	7nFpEt5v5BGhmLmGF/eJPBSN8C9uN1HqyKcLrV3NJ7pzhrVosMlZqqCi6NzLw8paYm6K54
	klp0umRRn0xQTJBli16uTppeLmZqc6pixTI7yBNtuJDuyhsmgR0JdfiqkrD8C4R3kY+z7L
	o6Tn6Ou6708TM03uVDc2m5STCBFv6e3w2f1hkYPZmZ+xGjbCgl4XZrEV5vdlUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YjAmwyU2I36ExxuOlcSmwuiYuD9EafTB1DYtgEfIeY=;
	b=uuLa8da6Y87xLqZQLlDhR361VsuCswgMnphmiujxvxVnf+oR5lTvRQWCfdCROzFhUU5wsB
	EeGo75uBvBYYAbCw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Support HBM and CXL PMON counters
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-9-kan.liang@linux.intel.com>
References: <20240614134631.1092359-9-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924175978.10875.17391461585888154745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f8a86a9bb5f7e65d8c4405052de062639a8783bb
Gitweb:        https://git.kernel.org/tip/f8a86a9bb5f7e65d8c4405052de062639a8783bb
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:59 +02:00

perf/x86/intel/uncore: Support HBM and CXL PMON counters

Unknown uncore PMON types can be found in both SPR and EMR with HBM or
CXL.

 $ls /sys/devices/ | grep type
 uncore_type_12_16
 uncore_type_12_18
 uncore_type_12_2
 uncore_type_12_4
 uncore_type_12_6
 uncore_type_12_8
 uncore_type_13_17
 uncore_type_13_19
 uncore_type_13_3
 uncore_type_13_5
 uncore_type_13_7
 uncore_type_13_9

The unknown PMON types are HBM and CXL PMON. Except for the name, the
other information regarding the HBM and CXL PMON counters can be
retrieved via the discovery table. Add them into the uncores tables for
SPR and EMR.

The event config registers for all CXL related units are 8-byte apart.
Add SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT to specially handle it.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-9-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fde123a..a7ea221 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6163,7 +6163,55 @@ static struct intel_uncore_type spr_uncore_mdf = {
 	.name			= "mdf",
 };
 
-#define UNCORE_SPR_NUM_UNCORE_TYPES		12
+static void spr_uncore_mmio_offs8_init_box(struct intel_uncore_box *box)
+{
+	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
+	intel_generic_uncore_mmio_init_box(box);
+}
+
+static struct intel_uncore_ops spr_uncore_mmio_offs8_ops = {
+	.init_box		= spr_uncore_mmio_offs8_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= spr_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+#define SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT()			\
+	SPR_UNCORE_COMMON_FORMAT(),				\
+	.ops			= &spr_uncore_mmio_offs8_ops
+
+static struct event_constraint spr_uncore_cxlcm_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x02, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x05, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x40, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type spr_uncore_cxlcm = {
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
+	.name			= "cxlcm",
+	.constraints		= spr_uncore_cxlcm_constraints,
+};
+
+static struct intel_uncore_type spr_uncore_cxldp = {
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
+	.name			= "cxldp",
+};
+
+static struct intel_uncore_type spr_uncore_hbm = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "hbm",
+};
+
+#define UNCORE_SPR_NUM_UNCORE_TYPES		15
 #define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
@@ -6187,6 +6235,9 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	NULL,
 	NULL,
 	&spr_uncore_mdf,
+	&spr_uncore_cxlcm,
+	&spr_uncore_cxldp,
+	&spr_uncore_hbm,
 };
 
 /*
@@ -6656,7 +6707,7 @@ static struct intel_uncore_type gnr_uncore_b2cmi = {
 };
 
 static struct intel_uncore_type gnr_uncore_b2cxl = {
-	SPR_UNCORE_MMIO_COMMON_FORMAT(),
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
 	.name			= "b2cxl",
 };
 

