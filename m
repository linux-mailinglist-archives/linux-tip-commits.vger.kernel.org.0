Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83699A57D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbfHWC2R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:28:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390216AbfHWC2M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJA-00019E-OT; Fri, 23 Aug 2019 04:28:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C4DA61C07E4;
        Fri, 23 Aug 2019 04:28:07 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:07 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf ui: Make 'exit_msg' optional in
 ui__question_window()
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-pnx1dn17bsz7lqt9ty95nnjx@git.kernel.org>
References: <tip-pnx1dn17bsz7lqt9ty95nnjx@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652728773.12698.1207944733354060591.tip-bot2@tip-bot2>
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

Commit-ID:     9e79ff77e4195e40e7a47a2001132db66e25d541
Gitweb:        https://git.kernel.org/tip/9e79ff77e4195e40e7a47a2001132db66e25d541
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 16:09:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:21:27 -03:00

perf ui: Make 'exit_msg' optional in ui__question_window()

We will not need it when refactoring this function to be
non-interactive, so make it optional.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pnx1dn17bsz7lqt9ty95nnjx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/util.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index fe5e571..5d65ea8 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -188,7 +188,9 @@ int ui__question_window(const char *title, const char *text,
 	pthread_mutex_lock(&ui__lock);
 
 	max_len += 2;
-	nr_lines += 4;
+	nr_lines += 2;
+	if (exit_msg)
+		nr_lines += 2;
 	y = SLtt_Screen_Rows / 2 - nr_lines / 2,
 	x = SLtt_Screen_Cols / 2 - max_len / 2;
 
@@ -199,14 +201,20 @@ int ui__question_window(const char *title, const char *text,
 		SLsmg_write_string((char *)title);
 	}
 	SLsmg_gotorc(++y, x);
-	nr_lines -= 2;
+	if (exit_msg)
+		nr_lines -= 2;
 	max_len -= 2;
 	SLsmg_write_wrapped_string((unsigned char *)text, y, x,
 				   nr_lines, max_len, 1);
 	SLsmg_gotorc(y + nr_lines - 2, x);
 	SLsmg_write_nstring((char *)" ", max_len);
 	SLsmg_gotorc(y + nr_lines - 1, x);
-	SLsmg_write_nstring((char *)exit_msg, max_len);
+	if (exit_msg) {
+		SLsmg_gotorc(y + nr_lines - 2, x);
+		SLsmg_write_nstring((char *)" ", max_len);
+		SLsmg_gotorc(y + nr_lines - 1, x);
+		SLsmg_write_nstring((char *)exit_msg, max_len);
+	}
 	SLsmg_refresh();
 
 	pthread_mutex_unlock(&ui__lock);
