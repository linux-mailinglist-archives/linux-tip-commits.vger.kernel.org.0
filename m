Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8CA29E989
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgJ2Kvs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgJ2Kvp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:45 -0400
Date:   Thu, 29 Oct 2020 10:51:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=879FchWtkBNJGY0z5FfT4BU2XWhSgyYepIWqk7mNewU=;
        b=aEVsoHCzJmOnsiHNF//Lg6qPc6XPSikPxyoK6pnE1hRTu5Nx66na2RB9yIubAgmZW/4cmF
        Ws4DAtjG1FcK2N/OwK2z3U/ZvSS4GIR8+huq/ati5T/PeYOdtAGUtK41mfWmCsMgY1hZxA
        oFlsz/JCZ29TL3uDLn3BqXf3j6M5e6RBbBrbf3y0zZTNowMB8nQwwJKXxsEvJcpzWiXOOH
        AMeuzRilZUhT88lDrfKdcSWSDcdCimWmpnJZ8553ij1yryC7FvY9T9j9mWaE/4OhqB807i
        pRgv5bCElppNME1o3klJAVI9Dvv9z+E7G/Ds4cTlICG+EOhet47Kl/Rn+ZfnwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=879FchWtkBNJGY0z5FfT4BU2XWhSgyYepIWqk7mNewU=;
        b=yMOwLLQIMUrYxCa6S1vmkmul0LELZwNAkrRG3Sbe0rinVz8QQDK686JWQnY2gZ4DcMruik
        V3sHTJGa1kx/AvBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001135749.2804-4-kan.liang@linux.intel.com>
References: <20201001135749.2804-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396870198.397.15908165802407650170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4cb6a42e4c4bc1902644eced67563e7405d4588e
Gitweb:        https://git.kernel.org/tip/4cb6a42e4c4bc1902644eced67563e7405d4588e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Oct 2020 06:57:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:39 +01:00

powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE

The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
address. Update the data->addr if the sample type is set.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201001135749.2804-4-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 78fe349..ce22bd2 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2065,6 +2065,9 @@ static struct pmu power_pmu = {
 	.sched_task	= power_pmu_sched_task,
 };
 
+#define PERF_SAMPLE_ADDR_TYPE  (PERF_SAMPLE_ADDR |		\
+				PERF_SAMPLE_PHYS_ADDR |		\
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
@@ -2120,8 +2123,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, ~0ULL, event->hw.last_period);
 
-		if (event->attr.sample_type &
-		    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (event->attr.sample_type & PERF_SAMPLE_ADDR_TYPE)
 			perf_get_data_addr(event, regs, &data.addr);
 
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
