Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7D44099D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 30 Oct 2021 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhJ3On1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 30 Oct 2021 10:43:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60890 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhJ3On1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 30 Oct 2021 10:43:27 -0400
Date:   Sat, 30 Oct 2021 14:40:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635604855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8t0KtVOtLunBIxqG/hnivJdh/g9OkKPzJgZjFjqETCk=;
        b=EoGvo74sFJ3IxT3kk0YtpZICjfMI2X+2zZUuI44VXGkuffMT9Da7iW6j9OFrsYsQ+nnGmM
        JdoyhPzjWaP1UWBeP3m/SvHCooF7BJ666AoMkSu/rxVMYL2Jbk+d1dx6QsKDTnIiJmOS29
        RUYGw0PwB3XBV4aB6W/Q/UUFFagD2Yi1iQNwJhhYfHSyRd0rkOhaHx6jqgCOqRw0K7SWjb
        iV/8SRwzlfq0wwFOME3BM5UEFqeyoq+FRJlSbjl6N4NV0PSYLefrzdASCbXjGnYxnd0Dtx
        5JuUfRn+3OcwbDa/ZZwfGMCUdEvqtsci3eBm6lynXCOZuUeq5aF9QGmRRXZf3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635604855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8t0KtVOtLunBIxqG/hnivJdh/g9OkKPzJgZjFjqETCk=;
        b=62keuKU5dmQ8YXzribeYyorSgqT2Pkqz2tA/mF8SEKOfD08NapI2H1lvs6mel8A+yXcuVS
        Uf+c2dRgM4N0khBw==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix ICL/SPR INST_RETIRED.PREC_DIST encodings
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211014001214.2680534-1-eranian@google.com>
References: <20211014001214.2680534-1-eranian@google.com>
MIME-Version: 1.0
Message-ID: <163560485424.626.11979984743391318856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2de71ee153efa93099d2ab864acffeec70a8dcd5
Gitweb:        https://git.kernel.org/tip/2de71ee153efa93099d2ab864acffeec70a8dcd5
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 13 Oct 2021 17:12:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 30 Oct 2021 16:37:24 +02:00

perf/x86/intel: Fix ICL/SPR INST_RETIRED.PREC_DIST encodings

This patch fixes the encoding for INST_RETIRED.PREC_DIST as published by Intel
(download.01.org/perfmon/) for Icelake. The official encoding
is event code 0x00 umask 0x1, a change from Skylake where it was code 0xc0
umask 0x1.

With this patch applied it is possible to run:
$ perf record -a -e cpu/event=0x00,umask=0x1/pp .....

Whereas before this would fail.

To avoid problems with tools which may use the old code, we maintain the old
encoding for Icelake.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211014001214.2680534-1-eranian@google.com
---
 arch/x86/events/intel/core.c | 5 +++--
 arch/x86/events/intel/ds.c   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a555e7c..c67d95e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -243,7 +243,8 @@ static struct extra_reg intel_skl_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* old INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
@@ -287,7 +288,7 @@ static struct extra_reg intel_spr_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_spr_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8647713..4dbb55a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -923,7 +923,8 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_icl_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
 
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
@@ -943,7 +944,7 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_spr_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
