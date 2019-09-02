Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4916A5152
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2019 10:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfIBIQq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Sep 2019 04:16:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbfIBIQq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVx-000893-KR; Mon, 02 Sep 2019 10:16:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9FFAF1C0DF4;
        Mon,  2 Sep 2019 10:16:36 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:36 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: No need for symbol.h, symbol_conf is enough
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-vrda1tuem1o8pk82t2kfjtun@git.kernel.org>
References: <tip-vrda1tuem1o8pk82t2kfjtun@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219656.17354.17625231273415691451.tip-bot2@tip-bot2>
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

Commit-ID:     afce8c482c48e2c42c155eeae4cd048c2b5fbb99
Gitweb:        https://git.kernel.org/tip/afce8c482c48e2c42c155eeae4cd048c2b5fbb99
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 11:56:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf probe: No need for symbol.h, symbol_conf is enough

Remove one more unneeded use of symbol.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vrda1tuem1o8pk82t2kfjtun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6dce172..26bc592 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -21,7 +21,7 @@
 #include "util/build-id.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
-#include "util/symbol.h"
+#include "util/symbol_conf.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/probe-finder.h"
