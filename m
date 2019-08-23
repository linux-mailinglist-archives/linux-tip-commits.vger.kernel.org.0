Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0974C9AF47
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfHWMYR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Aug 2019 08:24:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394571AbfHWMYQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Aug 2019 08:24:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18bz-0001sI-Pg; Fri, 23 Aug 2019 14:24:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 737651C04F3;
        Fri, 23 Aug 2019 14:24:11 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:24:11 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: util/evsel.h needs stdio.h as it uses FILE
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-2ywx5sl031tj3zske7c7edgv@git.kernel.org>
References: <tip-2ywx5sl031tj3zske7c7edgv@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656305132.32129.6341254751718345440.tip-bot2@tip-bot2>
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

Commit-ID:     43cc5d5ecbd194a730f3045547afc1fa8e694389
Gitweb:        https://git.kernel.org/tip/43cc5d5ecbd194a730f3045547afc1fa8e694389
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 21 Aug 2019 14:44:25 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:57 -03:00

perf evsel: util/evsel.h needs stdio.h as it uses FILE

And it was getting it by luck from util/cpumap.h that shouldn't be
included in util/evsel.h as it only needs what is in libperf, i.e.
struct cpu_map, that is in internal/cpumap.h, so add stdio.h before
we fix that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2ywx5sl031tj3zske7c7edgv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f749a7..cd336cf 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -4,6 +4,7 @@
 
 #include <linux/list.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
