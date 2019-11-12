Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2CF8E19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfKLLTb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:19:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfKLLSc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBg-0000fn-7P; Tue, 12 Nov 2019 12:18:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C963C1C05CD;
        Tue, 12 Nov 2019 12:18:13 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:13 -0000
From:   "tip-bot2 for Igor Lubashev" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf kvm: Use evlist layer api when possible
Cc:     Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571795693-23558-4-git-send-email-ilubashe@akamai.com>
References: <1571795693-23558-4-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Message-ID: <157355749345.29376.8660203426926179711.tip-bot2@tip-bot2>
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

Commit-ID:     4bfbcf3ee1cce3c2ea9870287fc34d3391d5a9b0
Gitweb:        https://git.kernel.org/tip/4bfbcf3ee1cce3c2ea9870287fc34d3391d5a9b0
Author:        Igor Lubashev <ilubashe@akamai.com>
AuthorDate:    Tue, 22 Oct 2019 21:54:53 -04:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf kvm: Use evlist layer api when possible

No need for layer violations when a proper evlist api is available.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1571795693-23558-4-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 858da89..577af4f 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -998,7 +998,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 			done = perf_kvm__handle_stdin();
 
 		if (!rc && !done)
-			err = fdarray__poll(fda, 100);
+			err = evlist__poll(kvm->evlist, 100);
 	}
 
 	evlist__disable(kvm->evlist);
