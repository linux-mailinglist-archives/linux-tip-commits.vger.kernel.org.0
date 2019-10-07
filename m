Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D7CE5A7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2019 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfJGOt3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Oct 2019 10:49:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfJGOt2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKC-0005zx-4y; Mon, 07 Oct 2019 16:49:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E5C871C0DCF;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf vendor events s390: Add JSON transaction for
 machine type 8561
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190927081147.18345-1-tmricht@linux.ibm.com>
References: <20190927081147.18345-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157045975590.9978.13228099256714455251.tip-bot2@tip-bot2>
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

Commit-ID:     02d084792273e8a5f1813dcad988229a45be96ea
Gitweb:        https://git.kernel.org/tip/02d084792273e8a5f1813dcad988229a45be96ea
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Fri, 27 Sep 2019 10:11:46 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:42 -03:00

perf vendor events s390: Add JSON transaction for machine type 8561

Add s390 transaction counter definition for machine 8561. This is the
same file as for the predecessor machine.

Fixes: 6e67d77d673d ("perf vendor events s390: Add JSON files for machine type 8561")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190927081147.18345-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json | 7 +++++++-
 1 file changed, 7 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json b/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
new file mode 100644
index 0000000..1a0034f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
