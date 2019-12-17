Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2F122C00
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Dec 2019 13:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfLQMkb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Dec 2019 07:40:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfLQMkE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8l-0001o4-Cg; Tue, 17 Dec 2019 13:39:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC1451C2A3D;
        Tue, 17 Dec 2019 13:39:50 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:50 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/bts: Fix the use of page_private()
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191205142853.28894-2-alexander.shishkin@linux.intel.com>
References: <20191205142853.28894-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157658639063.30329.9964492624988033137.tip-bot2@tip-bot2>
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

Commit-ID:     ff61541cc6c1962957758ba433c574b76f588d23
Gitweb:        https://git.kernel.org/tip/ff61541cc6c1962957758ba433c574b76f588d23
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Thu, 05 Dec 2019 17:28:52 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:46 +01:00

perf/x86/intel/bts: Fix the use of page_private()

Commit

  8062382c8dbe2 ("perf/x86/intel/bts: Add BTS PMU driver")

brought in a warning with the BTS buffer initialization
that is easily tripped with (assuming KPTI is disabled):

instantly throwing:

> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 326 at arch/x86/events/intel/bts.c:86 bts_buffer_setup_aux+0x117/0x3d0
> Modules linked in:
> CPU: 2 PID: 326 Comm: perf Not tainted 5.4.0-rc8-00291-gceb9e77324fa #904
> RIP: 0010:bts_buffer_setup_aux+0x117/0x3d0
> Call Trace:
>  rb_alloc_aux+0x339/0x550
>  perf_mmap+0x607/0xc70
>  mmap_region+0x76b/0xbd0
...

It appears to assume (for lost raisins) that PagePrivate() is set,
while later it actually tests for PagePrivate() before using
page_private().

Make it consistent and always check PagePrivate() before using
page_private().

Fixes: 8062382c8dbe2 ("perf/x86/intel/bts: Add BTS PMU driver")
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lkml.kernel.org/r/20191205142853.28894-2-alexander.shishkin@linux.intel.com
---
 arch/x86/events/intel/bts.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 38de4a7..6a3b599 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -63,9 +63,17 @@ struct bts_buffer {
 
 static struct pmu bts_pmu;
 
+static int buf_nr_pages(struct page *page)
+{
+	if (!PagePrivate(page))
+		return 1;
+
+	return 1 << page_private(page);
+}
+
 static size_t buf_size(struct page *page)
 {
-	return 1 << (PAGE_SHIFT + page_private(page));
+	return buf_nr_pages(page) * PAGE_SIZE;
 }
 
 static void *
@@ -83,9 +91,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	/* count all the high order buffers */
 	for (pg = 0, nbuf = 0; pg < nr_pages;) {
 		page = virt_to_page(pages[pg]);
-		if (WARN_ON_ONCE(!PagePrivate(page) && nr_pages > 1))
-			return NULL;
-		pg += 1 << page_private(page);
+		pg += buf_nr_pages(page);
 		nbuf++;
 	}
 
@@ -109,7 +115,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 		unsigned int __nr_pages;
 
 		page = virt_to_page(pages[pg]);
-		__nr_pages = PagePrivate(page) ? 1 << page_private(page) : 1;
+		__nr_pages = buf_nr_pages(page);
 		buf->buf[nbuf].page = page;
 		buf->buf[nbuf].offset = offset;
 		buf->buf[nbuf].displacement = (pad ? BTS_RECORD_SIZE - pad : 0);
