Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF618B8C6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Mar 2020 15:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCSOLK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Mar 2020 10:11:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgCSOLJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvt2-0002Lm-B4; Thu, 19 Mar 2020 15:11:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AFE371C22AB;
        Thu, 19 Mar 2020 15:10:55 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:55 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf llvm: Add debug hint message about missing
 kernel-devel package
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158462705535.28353.17990839248162502200.tip-bot2@tip-bot2>
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

Commit-ID:     357a5d24c4715d454f8acd6796e2adaaef0c48ed
Gitweb:        https://git.kernel.org/tip/357a5d24c4715d454f8acd6796e2adaaef0c48ed
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 27 Feb 2020 11:43:53 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Mar 2020 10:34:10 -03:00

perf llvm: Add debug hint message about missing kernel-devel package

To help in debugging, add this extra message:

  detect_kbuild_dir: Couldn't find "/lib/modules/5.4.20-200.fc31.x86_64/build/include/generated/autoconf.h", missing kernel-devel package?.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index b5af680..dbdffb6 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -265,6 +265,8 @@ static int detect_kbuild_dir(char **kbuild_dir)
 			return -ENOMEM;
 		return 0;
 	}
+	pr_debug("%s: Couldn't find \"%s\", missing kernel-devel package?.\n",
+		 __func__, autoconf_path);
 	free(autoconf_path);
 	return -ENOENT;
 }
