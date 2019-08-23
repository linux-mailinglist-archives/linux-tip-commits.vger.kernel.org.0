Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDC9AF32
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 14:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394488AbfHWMWQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Aug 2019 08:22:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393185AbfHWMVt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18Zb-0001jC-HT; Fri, 23 Aug 2019 14:21:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 298411C04F3;
        Fri, 23 Aug 2019 14:21:43 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:42 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf counts: Add missing headers needed for types used
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-p7bncbi53t4p2kobkbmu86a4@git.kernel.org>
References: <tip-p7bncbi53t4p2kobkbmu86a4@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656290294.31563.390589934415946033.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2d64ae9b85614dc0fcca68aad5da305dec44a9b1
Gitweb:        https://git.kernel.org/tip/2d64ae9b85614dc0fcca68aad5da305dec44a9b1
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 21 Aug 2019 11:56:13 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:56 -03:00

perf counts: Add missing headers needed for types used

We get these by sheer luck, since we're cleaning unneeded headers use,
this needs to be done first to avoid breakage down the line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p7bncbi53t4p2kobkbmu86a4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/counts.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 13430f3..92196df 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -2,8 +2,12 @@
 #ifndef __PERF_COUNTS_H
 #define __PERF_COUNTS_H
 
+#include <linux/types.h>
 #include <internal/xyarray.h>
 #include <perf/evsel.h>
+#include <stdbool.h>
+
+struct evsel;
 
 struct perf_counts {
 	s8			  scaled;
