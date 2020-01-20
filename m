Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9427A142577
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Jan 2020 09:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgATI1R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Jan 2020 03:27:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgATI1R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Jan 2020 03:27:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itSOu-0002sB-OE; Mon, 20 Jan 2020 09:27:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED7121C1A3A;
        Mon, 20 Jan 2020 09:27:11 +0100 (CET)
Date:   Mon, 20 Jan 2020 08:27:11 -0000
From:   "tip-bot2 for Michael Petlan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf header: Use last modification time for timestamp
Cc:     Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157950883176.396.4878083330473631264.tip-bot2@tip-bot2>
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

Commit-ID:     8af19d66b956401bab1ef24049eec9421be93862
Gitweb:        https://git.kernel.org/tip/8af19d66b956401bab1ef24049eec9421be93862
Author:        Michael Petlan <mpetlan@redhat.com>
AuthorDate:    Tue, 14 Jan 2020 11:42:36 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 15 Jan 2020 10:17:20 -03:00

perf header: Use last modification time for timestamp

Using .st_ctime clobbers the timestamp information in perf report header
whenever any operation is done with the file. Even tar-ing and untar-ing
the perf.data file (which preserves the file last modification timestamp)
doesn't prevent that:

    [Michael@Diego tmp]$ ls -l perf.data
->	-rw-------. 1 Michael Michael 169888 Dec  2 15:23 perf.data

	[Michael@Diego tmp]$ perf report --header-only
	# ========
->	# captured on    : Mon Dec  2 15:23:42 2019
	 [...]

	[Michael@Diego tmp]$ tar c perf.data | xz > perf.data.tar.xz
	[Michael@Diego tmp]$ mkdir aaa
	[Michael@Diego tmp]$ cd aaa
	[Michael@Diego aaa]$ xzcat ../perf.data.tar.xz | tar x
	[Michael@Diego aaa]$ ls -l -a
	total 172
	drwxrwxr-x. 2 Michael Michael     23 Jan 14 11:26 .
	drwxrwxr-x. 6 Michael Michael   4096 Jan 14 11:26 ..
->	-rw-------. 1 Michael Michael 169888 Dec  2 15:23 perf.data

	[Michael@Diego aaa]$ perf report --header-only
	# ========
->	# captured on    : Tue Jan 14 11:26:16 2020
	 [...]

When using .st_mtime instead, correct information is printed:

	[Michael@Diego aaa]$ ~/acme/tools/perf/perf report --header-only
	# ========
->	# captured on    : Mon Dec  2 15:23:42 2019
	 [...]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20200114104236.31555-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 93ad278..4246e74 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2922,7 +2922,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	stctime = st.st_ctime;
+	stctime = st.st_mtime;
 	fprintf(fp, "# captured on    : %s", ctime(&stctime));
 
 	fprintf(fp, "# header version : %u\n", header->version);
