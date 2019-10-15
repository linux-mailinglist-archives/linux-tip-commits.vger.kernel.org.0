Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E057D6EFE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfJOFcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 01:32:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfJOFcH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRA-0000Lg-LD; Tue, 15 Oct 2019 07:32:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 291BF1C04F4;
        Tue, 15 Oct 2019 07:31:46 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf beauty: Make strarray's offset be u64
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-g8t2d0jr0mg3yimg2qrjkvlt@git.kernel.org>
References: <tip-g8t2d0jr0mg3yimg2qrjkvlt@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750605.12254.17644823640333429994.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8d6505bae391e640aaefd182907e7c1d673af17e
Gitweb:        https://git.kernel.org/tip/8d6505bae391e640aaefd182907e7c1d673af17e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 09 Oct 2019 11:22:43 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf beauty: Make strarray's offset be u64

We need it for things like MSRs that are sparse and go over MAXINT.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-g8t2d0jr0mg3yimg2qrjkvlt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 4cc4f6b..5ad7542 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -7,7 +7,7 @@
 #include <sys/types.h>
 
 struct strarray {
-	int	    offset;
+	u64	    offset;
 	int	    nr_entries;
 	const char *prefix;
 	const char **entries;
