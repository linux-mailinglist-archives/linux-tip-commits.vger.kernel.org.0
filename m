Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B649AF80
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfHWM33 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Aug 2019 08:29:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfHWM33 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Aug 2019 08:29:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18h2-00024L-DU; Fri, 23 Aug 2019 14:29:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 098231C089A;
        Fri, 23 Aug 2019 14:29:24 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:29:23 -0000
From:   tip-bot2 for Ravi Bangoria <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf c2c: Fix report with offline cpus
Cc:     Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
References: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <156656336391.32670.13819000137400710283.tip-bot2@tip-bot2>
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

Commit-ID:     1ea770f6c1971bc101b3741f4d88b0b4ea5c4181
Gitweb:        https://git.kernel.org/tip/1ea770f6c1971bc101b3741f4d88b0b4ea5c4181
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 22 Aug 2019 14:20:45 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:57 -03:00

perf c2c: Fix report with offline cpus

If c2c is recorded on a machine where any cpus are offline, 'perf c2c
report' throws an error "node/cpu topology bugFailed setup nodes".

It fails because while preparing node-cpu mapping we don't consider
offline cpus.

Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Link: http://lkml.kernel.org/r/20190822085045.25108-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 01629f5..2111437 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2027,7 +2027,7 @@ static int setup_nodes(struct perf_session *session)
 		c2c.node_info = 2;
 
 	c2c.nodes_cnt = session->header.env.nr_numa_nodes;
-	c2c.cpus_cnt  = session->header.env.nr_cpus_online;
+	c2c.cpus_cnt  = session->header.env.nr_cpus_avail;
 
 	n = session->header.env.numa_nodes;
 	if (!n)
