Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80482F8E0F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfKLLTO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:19:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfKLLSc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBn-0000mn-H2; Tue, 12 Nov 2019 12:18:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 40B8E1C04F4;
        Tue, 12 Nov 2019 12:18:19 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:18 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf data: Rename directory "header" file to "data"
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191004083121.12182-4-adrian.hunter@intel.com>
References: <20191004083121.12182-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355749889.29376.8219215484265166163.tip-bot2@tip-bot2>
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

Commit-ID:     9b70b9db4e0cc03d224795a18088fdb916dec823
Gitweb:        https://git.kernel.org/tip/9b70b9db4e0cc03d224795a18088fdb916dec823
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 04 Oct 2019 11:31:19 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf data: Rename directory "header" file to "data"

In preparation to support a single file directory format, rename "header"
to "data" because "header" is a mis-leading name when there is only 1 file.
Note, in the multi-file case, the "header" file also contains data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 2 +-
 tools/perf/util/util.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 8993253..df173f0 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -306,7 +306,7 @@ static int open_dir(struct perf_data *data)
 	 * So far we open only the header, so we can read the data version and
 	 * layout.
 	 */
-	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+	if (asprintf(&data->file.path, "%s/data", data->path) < 0)
 		return -1;
 
 	if (perf_data__is_write(data) &&
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index ae56c76..3096654 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -185,7 +185,7 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
-		"header",
+		"data",
 		"data.*",
 		NULL,
 	};
