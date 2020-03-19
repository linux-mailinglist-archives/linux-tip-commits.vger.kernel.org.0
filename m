Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD618B8BC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Mar 2020 15:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCSOKt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Mar 2020 10:10:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSOKs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvse-0001zI-Hs; Thu, 19 Mar 2020 15:10:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 09E671C22A3;
        Thu, 19 Mar 2020 15:10:40 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf expr: Fix copy/paste mistake
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200315155609.603948-1-jolsa@kernel.org>
References: <20200315155609.603948-1-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158462703969.28353.11784055871858151116.tip-bot2@tip-bot2>
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

Commit-ID:     59a08b4b3b1a9374adacd13cd7544c03e5582e0e
Gitweb:        https://git.kernel.org/tip/59a08b4b3b1a9374adacd13cd7544c03e5582e0e
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 15 Mar 2020 16:56:09 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 17 Mar 2020 18:01:40 -03:00

perf expr: Fix copy/paste mistake

Copy/paste leftover from recent refactor.

Fixes: 26226a97724d ("perf expr: Move expr lexer to flex")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200315155609.603948-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.l | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 1928f2a..eaad292 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -79,10 +79,10 @@ symbol		{spec}*{sym}*{spec}*{sym}*
 	{
 		int start_token;
 
-		start_token = parse_events_get_extra(yyscanner);
+		start_token = expr_get_extra(yyscanner);
 
 		if (start_token) {
-			parse_events_set_extra(NULL, yyscanner);
+			expr_set_extra(NULL, yyscanner);
 			return start_token;
 		}
 	}
