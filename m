Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC2D0F76
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Oct 2019 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfJINA0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Oct 2019 09:00:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJIM71 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYk-0002mj-FQ; Wed, 09 Oct 2019 14:59:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1BDBC1C01BD;
        Wed,  9 Oct 2019 14:59:18 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:18 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add Tiger Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570549810-25049-9-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157062595805.9978.4098955785516680563.tip-bot2@tip-bot2>
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

Commit-ID:     b01a8e2edb924feee1b66f74df1198788fc37cca
Gitweb:        https://git.kernel.org/tip/b01a8e2edb924feee1b66f74df1198788fc37cca
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 08 Oct 2019 08:50:09 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:44:18 +02:00

perf/x86/msr: Add Tiger Lake CPU support

Tiger Lake is the followon to Ice Lake. PPERF and SMI_COUNT MSRs are
also supported.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1570549810-25049-9-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 8515512..6f86650 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -95,6 +95,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ICELAKE:
 	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_D:
+	case INTEL_FAM6_TIGERLAKE_L:
+	case INTEL_FAM6_TIGERLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
