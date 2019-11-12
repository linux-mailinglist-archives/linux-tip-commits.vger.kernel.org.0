Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4FF8E7F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKLLSD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:18:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLLSC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBJ-0000Is-GF; Tue, 12 Nov 2019 12:17:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D4FAB1C0084;
        Tue, 12 Nov 2019 12:17:55 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:55 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf symbols: Remove needless checks for
 map->groups->machine
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-utiepyiv8b1tf8f79ok9d6j8@git.kernel.org>
References: <tip-utiepyiv8b1tf8f79ok9d6j8@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355747553.29376.4155139171745495061.tip-bot2@tip-bot2>
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

Commit-ID:     b0c76fc4cfd96ae859cc50afe5deb523276f75ae
Gitweb:        https://git.kernel.org/tip/b0c76fc4cfd96ae859cc50afe5deb523276f75ae
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 01 Nov 2019 18:34:44 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 08:30:18 -03:00

perf symbols: Remove needless checks for map->groups->machine

Its sufficient to check if map->groups is NULL before using it to get
->machine value.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-utiepyiv8b1tf8f79ok9d6j8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a4bd61c..4ad39cc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1617,7 +1617,7 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (map->groups && map->groups->machine)
+	if (map->groups)
 		machine = map->groups->machine;
 	else
 		machine = NULL;
