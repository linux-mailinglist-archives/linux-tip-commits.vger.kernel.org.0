Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D757CD4FFD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2019 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfJLNTc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Oct 2019 09:19:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbfJLNTc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Oct 2019 09:19:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iJHIl-0000aK-4e; Sat, 12 Oct 2019 15:19:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8F5FF1C0426;
        Sat, 12 Oct 2019 15:19:18 +0200 (CEST)
Date:   Sat, 12 Oct 2019 13:19:18 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add new CPU model numbers for Ice Lake
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570549810-25049-6-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157088635853.9978.567895938553199892.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1a5da78d00ce0152994946debd1417513dc35eb3
Gitweb:        https://git.kernel.org/tip/1a5da78d00ce0152994946debd1417513dc35eb3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 08 Oct 2019 08:50:06 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Oct 2019 15:13:09 +02:00

perf/x86/msr: Add new CPU model numbers for Ice Lake

PPERF and SMI_COUNT MSRs are also supported by Ice Lake desktop and
server.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1570549810-25049-6-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/msr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index c177bbe..8515512 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -92,6 +92,9 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_COMETLAKE_L:
 	case INTEL_FAM6_COMETLAKE:
 	case INTEL_FAM6_ICELAKE_L:
+	case INTEL_FAM6_ICELAKE:
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
