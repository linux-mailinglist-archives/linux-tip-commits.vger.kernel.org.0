Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3662AEB3F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKKIZe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:25:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKIXP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:15 -0500
Date:   Wed, 11 Nov 2020 08:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pwe9Dw1e18KCFlSunQp/d6l6NrJ/N4plglchRQDmLs=;
        b=RGCYlHp09a8pZgscbWJ8ypCwjMHDnbWhWVn9yYrkawKqzb2LDCo6UNW6J5tbJCcKFeWcQc
        jiUtN4rVfNb1XgrqRrbNz5+eNO6fViIbhWHu1awqojuf6m3K83qulvVLsa1v0a9bJR61PK
        BWL0LW6gV6euoiJK4wIeaBn6G8gOIcGT56qmzseWGdrdrLiSmzTOgyrxOOOwnRsGzsMaMw
        Oyhna42fdrfmdCovNCbd6cgT2i0o/CZoA1hDnBUIrk5G722OG7f/QSPsTZ2zLff/vDDIGo
        PerfoDejKEY3h4gS7pbYzStEyLXlIJe2XBDlGK5/fV+rYt/cFEt6tk80hcBYcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pwe9Dw1e18KCFlSunQp/d6l6NrJ/N4plglchRQDmLs=;
        b=sYYDvsRWmDuDxOBP/CENEcP0+YQhcemiczOfqvUqgBYNfv5sCiZv1wgMjRea1g+22jv1zO
        6MXYcFvGV1BvZHBA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix Add BW copypasta
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201026215203.3893972-1-arnd@kernel.org>
References: <20201026215203.3893972-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <160508299133.11244.9181059699387478025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1a8cfa24e21c2f154791f0cdd85fc28496918722
Gitweb:        https://git.kernel.org/tip/1a8cfa24e21c2f154791f0cdd85fc28496918722
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 26 Oct 2020 22:51:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:40 +01:00

perf/x86/intel/uncore: Fix Add BW copypasta

gcc -Wextra points out a duplicate initialization of one array
member:

arch/x86/events/intel/uncore_snb.c:478:37: warning: initialized field overwritten [-Woverride-init]
  478 |  [SNB_PCI_UNCORE_IMC_DATA_READS]  = { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,

The only sensible explanation is that a duplicate 'READS' was used
instead of the correct 'WRITES', so change it back.

Fixes: 24633d901ea4 ("perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201026215203.3893972-1-arnd@kernel.org
---
 arch/x86/events/intel/uncore_snb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 39e632e..bbd1120 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -475,7 +475,7 @@ enum perf_snb_uncore_imc_freerunning_types {
 static struct freerunning_counters snb_uncore_imc_freerunning[] = {
 	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
 							0x0, 0x0, 1, 32 },
-	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
+	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
 							0x0, 0x0, 1, 32 },
 	[SNB_PCI_UNCORE_IMC_GT_REQUESTS]	= { SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE,
 							0x0, 0x0, 1, 32 },
