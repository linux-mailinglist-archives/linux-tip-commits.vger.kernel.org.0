Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9711A9734
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Apr 2020 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894925AbgDOIoz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Apr 2020 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894478AbgDOIow (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Apr 2020 04:44:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1DC061A0C;
        Wed, 15 Apr 2020 01:44:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOdf5-0004TV-5w; Wed, 15 Apr 2020 10:44:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AF5341C0081;
        Wed, 15 Apr 2020 10:44:46 +0200 (CEST)
Date:   Wed, 15 Apr 2020 08:44:46 -0000
From:   "tip-bot2 for Peter Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Xu <peterx@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403223517.406353-1-peterx@redhat.com>
References: <20200403223517.406353-1-peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <158694028618.28353.15868701141277994151.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3662daf023500dc084fa3b96f68a6f46179ddc73
Gitweb:        https://git.kernel.org/tip/3662daf023500dc084fa3b96f68a6f46179ddc73
Author:        Peter Xu <peterx@redhat.com>
AuthorDate:    Fri, 03 Apr 2020 18:35:17 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Apr 2020 10:38:26 +02:00

sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters

The "isolcpus=" parameter allows sub-parameters before the cpulist is
specified, and if the parser detects an unknown sub-parameters the whole
parameter will be ignored.

This design is incompatible with itself when new sub-parameters are added.
An older kernel will not recognize the new sub-parameter and will
invalidate the whole parameter so the CPU isolation will not take
effect. It emits a warning:

    isolcpus: Error, unknown flag

The better and compatible way is to allow "isolcpus=" to skip unknown
sub-parameters, so that even if new sub-parameters are added an older
kernel will still be able to behave as usual even if with the new
sub-parameter specified on the command line.

Ideally this should have been there when the first sub-parameter for
"isolcpus=" was introduced.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200403223517.406353-1-peterx@redhat.com

---
 kernel/sched/isolation.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 008d6ac..808244f 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -149,6 +149,9 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	bool illegal = false;
+	char *par;
+	int len;
 
 	while (isalpha(*str)) {
 		if (!strncmp(str, "nohz,", 5)) {
@@ -169,8 +172,22 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
-		pr_warn("isolcpus: Error, unknown flag\n");
-		return 0;
+		/*
+		 * Skip unknown sub-parameter and validate that it is not
+		 * containing an invalid character.
+		 */
+		for (par = str, len = 0; *str && *str != ','; str++, len++) {
+			if (!isalpha(*str) && *str != '_')
+				illegal = true;
+		}
+
+		if (illegal) {
+			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
+			return 0;
+		}
+
+		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
+		str++;
 	}
 
 	/* Default behaviour for isolcpus without flags */
