Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4508F8DFA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKLLSf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:18:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfKLLSe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBq-0000op-5E; Tue, 12 Nov 2019 12:18:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4810F1C04F3;
        Tue, 12 Nov 2019 12:18:20 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:19 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf data: Correctly identify directory data files
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191004083121.12182-2-adrian.hunter@intel.com>
References: <20191004083121.12182-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355749990.29376.8847233510232255053.tip-bot2@tip-bot2>
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

Commit-ID:     490e6db09a9035d7b40a328a2a004ef70b6bdee6
Gitweb:        https://git.kernel.org/tip/490e6db09a9035d7b40a328a2a004ef70b6bdee6
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 04 Oct 2019 11:31:17 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf data: Correctly identify directory data files

In order to rename the "header" file to "data" without conflicting,
correctly identify the non-header files as starting with "data."

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 88fba2b..8993253 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -96,7 +96,7 @@ int perf_data__open_dir(struct perf_data *data)
 		if (stat(path, &st))
 			continue;
 
-		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data", 4))
+		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data.", 5))
 			continue;
 
 		ret = -ENOMEM;
