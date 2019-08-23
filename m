Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60D9A565
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfHWCQp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:16:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfHWCQp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:16:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z7t-00014z-2y; Fri, 23 Aug 2019 04:16:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8779D1C07E4;
        Fri, 23 Aug 2019 04:16:28 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:16:25 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Fix arch include paths
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20190820124624.GG24105@krava>
References: <20190820124624.GG24105@krava>
MIME-Version: 1.0
Message-ID: <156652658595.12449.3232580818277514733.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b81d39c7a1efb83caa3f4419939a46e96191abb6
Gitweb:        https://git.kernel.org/tip/b81d39c7a1efb83caa3f4419939a46e96191abb6
Author:        Jiri Olsa <jolsa@redhat.com>
AuthorDate:    Tue, 20 Aug 2019 14:46:24 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:29:36 -03:00

libperf: Fix arch include paths

Guenter Roeck reported problem with compilation when the ARCH is
specified:

  $ make ARCH=x86_64
  In file included from tools/include/asm/atomic.h:6:0,
                   from include/linux/atomic.h:5,
                   from tools/include/linux/refcount.h:41,
                   from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
  fatal error: asm/cmpxchg.h: No such file or directory

The problem is that we don't use SRCARCH (the sanitized ARCH version)
and we don't get the proper include path.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 314350491810 ("libperf: Make libperf.a part of the perf build")
Link: http://lkml.kernel.org/r/20190820124624.GG24105@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 8a9ae50..a67efb8 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -59,7 +59,7 @@ else
   CFLAGS := -g -Wall
 endif
 
-INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/ -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
+INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
