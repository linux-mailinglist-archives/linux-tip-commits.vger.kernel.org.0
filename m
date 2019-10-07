Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8406FCE5F9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2019 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfJGOvT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Oct 2019 10:51:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfJGOte (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKH-000646-Lo; Mon, 07 Oct 2019 16:49:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 75F0B1C0DD5;
        Mon,  7 Oct 2019 16:49:17 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:17 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers uapi: Sync asm-generic/mman-common.h
 with the kernel
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Minchan Kim <minchan@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-n40y6c4sa49p29q6sl8w3ufx@git.kernel.org>
References: <tip-n40y6c4sa49p29q6sl8w3ufx@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975738.9978.17486571735826931174.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b1ba55cf1cfb9f3e0e00d743534684a25bf66d28
Gitweb:        https://git.kernel.org/tip/b1ba55cf1cfb9f3e0e00d743534684a25bf66d28
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 27 Sep 2019 11:30:30 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:28:44 -03:00

tools headers uapi: Sync asm-generic/mman-common.h with the kernel

To pick the changes from:

  1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
  9c276cc65a58 ("mm: introduce MADV_COLD")

That result in these changes in the tools:

  $ tools/perf/trace/beauty/madvise_behavior.sh > before
  $ cp include/uapi/asm-generic/mman-common.h tools/include/uapi/asm-generic/mman-common.h
  $ git diff
  diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
  index 63b1f506ea67..c160a5354eb6 100644
  --- a/tools/include/uapi/asm-generic/mman-common.h
  +++ b/tools/include/uapi/asm-generic/mman-common.h
  @@ -67,6 +67,9 @@
   #define MADV_WIPEONFORK 18             /* Zero memory on fork, child only */
   #define MADV_KEEPONFORK 19             /* Undo MADV_WIPEONFORK */

  +#define MADV_COLD      20              /* deactivate these pages */
  +#define MADV_PAGEOUT   21              /* reclaim these pages */
  +
   /* compatibility flags */
   #define MAP_FILE       0

  $ tools/perf/trace/beauty/madvise_behavior.sh > after
  $ diff -u before after
  --- before	2019-09-27 11:29:43.346320100 -0300
  +++ after	2019-09-27 11:30:03.838570439 -0300
  @@ -16,6 +16,8 @@
   	[17] = "DODUMP",
   	[18] = "WIPEONFORK",
   	[19] = "KEEPONFORK",
  +	[20] = "COLD",
  +	[21] = "PAGEOUT",
   	[100] = "HWPOISON",
   	[101] = "SOFT_OFFLINE",
   };
  $

I.e. now when madvise gets those behaviours as args, it will be able to
translate from the number to a human readable string.

This addresses the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n40y6c4sa49p29q6sl8w3ufx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/mman-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 63b1f50..c160a53 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -67,6 +67,9 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
