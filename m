Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7EB9526
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Sep 2019 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404914AbfITQVO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Sep 2019 12:21:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404879AbfITQVN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLec-000486-HA; Fri, 20 Sep 2019 18:21:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 72E381C0E32;
        Fri, 20 Sep 2019 18:21:00 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:00 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf symbols: Add missing dso.h header
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-xeolxwr3iftwfw9kmw26shfe@git.kernel.org>
References: <tip-xeolxwr3iftwfw9kmw26shfe@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899646042.24167.11317929080282673385.tip-bot2@tip-bot2>
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

Commit-ID:     09aa3b002c8cfcea65b2925ec4ff5a6ccdc44d87
Gitweb:        https://git.kernel.org/tip/09aa3b002c8cfcea65b2925ec4ff5a6ccdc44d87
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 10 Sep 2019 16:17:19 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:21 -03:00

perf symbols: Add missing dso.h header

This was being obtained only indirectly, by luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xeolxwr3iftwfw9kmw26shfe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8b9199c..6fbfdf8 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
+#include "dso.h"
 #include "map.h"
 #include "map_groups.h"
 #include "symbol.h"
