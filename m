Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A241CADE2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgEHNFh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730537AbgEHNFg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:05:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860AC05BD43;
        Fri,  8 May 2020 06:05:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gx-0007qK-Ee; Fri, 08 May 2020 15:05:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 662891C04D0;
        Fri,  8 May 2020 15:05:10 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:10 -0000
From:   "tip-bot2 for Zou Wei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf c2c: Remove unneeded semicolon
Cc:     Hulk Robot <hulkci@huawei.com>, Zou Wei <zou_wei@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1588064336-70456-1-git-send-email-zou_wei@huawei.com>
References: <1588064336-70456-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Message-ID: <158894311025.8414.1994972639941777601.tip-bot2@tip-bot2>
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

Commit-ID:     2cca512ad2fe14d060838eaf8581cda600764141
Gitweb:        https://git.kernel.org/tip/2cca512ad2fe14d060838eaf8581cda600764141
Author:        Zou Wei <zou_wei@huawei.com>
AuthorDate:    Tue, 28 Apr 2020 16:58:56 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Apr 2020 10:48:32 -03:00

perf c2c: Remove unneeded semicolon

Fixes coccicheck warnings:

 tools/perf/builtin-c2c.c:1712:2-3: Unneeded semicolon
 tools/perf/builtin-c2c.c:1928:2-3: Unneeded semicolon
 tools/perf/builtin-c2c.c:2962:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1588064336-70456-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 0d544c4..0e14c18 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1709,7 +1709,7 @@ static struct c2c_dimension *get_dimension(const char *name)
 
 		if (!strcmp(dim->name, name))
 			return dim;
-	};
+	}
 
 	return NULL;
 }
@@ -1925,7 +1925,7 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		FILTER_HITM(tot_hitm);
 	default:
 		break;
-	};
+	}
 
 #undef FILTER_HITM
 
@@ -2959,7 +2959,7 @@ static int perf_c2c__record(int argc, const char **argv)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
-	};
+	}
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
