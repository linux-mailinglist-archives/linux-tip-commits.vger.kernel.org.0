Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB1A1CAE39
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEHNHz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730559AbgEHNFo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:05:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F09C05BD09;
        Fri,  8 May 2020 06:05:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gu-0007lm-KB; Fri, 08 May 2020 15:05:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5735A1C0852;
        Fri,  8 May 2020 15:05:08 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:08 -0000
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tests expr: Added test for runtime param in
 metric expression
Cc:     Kajol Jain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401203340.31402-6-kjain@linux.ibm.com>
References: <20200401203340.31402-6-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158894310825.8414.975904064383982223.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9022608ec5babbb0fa631234098d52895e7e34d8
Gitweb:        https://git.kernel.org/tip/9022608ec5babbb0fa631234098d52895e7e34d8
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Thu, 02 Apr 2020 02:03:38 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Apr 2020 10:48:33 -03:00

perf tests expr: Added test for runtime param in metric expression

Added test case for parsing  "?" in metric expression.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20200401203340.31402-6-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 516504c..f9e8e56 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -59,6 +59,14 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
 
+	TEST_ASSERT_VAL("find other",
+			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@", NULL,
+				   &other, &num_other, 3) == 0);
+	TEST_ASSERT_VAL("find other", num_other == 2);
+	TEST_ASSERT_VAL("find other", !strcmp(other[0], "EVENT1,param=3/"));
+	TEST_ASSERT_VAL("find other", !strcmp(other[1], "EVENT2,param=3/"));
+	TEST_ASSERT_VAL("find other", other[2] == NULL);
+
 	for (i = 0; i < num_other; i++)
 		zfree(&other[i]);
 	free((void *)other);
