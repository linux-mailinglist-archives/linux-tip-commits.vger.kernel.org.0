Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB81CAE35
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgEHNHn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730567AbgEHNFp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:05:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F1C05BD43;
        Fri,  8 May 2020 06:05:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h9-0007xF-Vw; Fri, 08 May 2020 15:05:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E60A61C0871;
        Fri,  8 May 2020 15:05:14 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:14 -0000
From:   "tip-bot2 for Jagadeesh Pagadala" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Remove duplicate headers
Cc:     Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com>
References: <1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Message-ID: <158894311486.8414.8876658025469975033.tip-bot2@tip-bot2>
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

Commit-ID:     8fbd301bf206a3f3fc2c01181a11eb42846b9949
Gitweb:        https://git.kernel.org/tip/8fbd301bf206a3f3fc2c01181a11eb42846b9949
Author:        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
AuthorDate:    Sun, 19 Apr 2020 11:43:56 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 22 Apr 2020 10:01:33 -03:00

perf evlist: Remove duplicate headers

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/evlist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 5b9f2ca..def5505 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -11,10 +11,8 @@
 #include <internal/mmap.h>
 #include <internal/cpumap.h>
 #include <internal/threadmap.h>
-#include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <linux/zalloc.h>
-#include <sys/ioctl.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
