Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852FB13AA22
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 14:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgANNDT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 08:03:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgANNCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLq9-0004oT-5i; Tue, 14 Jan 2020 14:02:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D7311C0853;
        Tue, 14 Jan 2020 14:02:22 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:22 -0000
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Let do_coarse() return 0 to simplify the
 callsite
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C21e8afa38c02ca8672c2690307383507fe63b454=2E15771?=
 =?utf-8?q?11367=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
References: =?utf-8?q?=3C21e8afa38c02ca8672c2690307383507fe63b454=2E157711?=
 =?utf-8?q?1367=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <157900694240.396.11786627585944485091.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8463cf80529d0fd80b84cd5ab8b9b952b01c7eb9
Gitweb:        https://git.kernel.org/tip/8463cf80529d0fd80b84cd5ab8b9b952b01c7eb9
Author:        Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate:    Mon, 23 Dec 2019 14:31:07 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:46 +01:00

lib/vdso: Let do_coarse() return 0 to simplify the callsite

do_coarse() is similar to do_hres() except that it never fails.

Change its type to int instead of void and let it always return success (0)
to simplify the call site.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/21e8afa38c02ca8672c2690307383507fe63b454.1577111367.git.christophe.leroy@c-s.fr


---
 lib/vdso/gettimeofday.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index b676a98..5a5ec89 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -68,7 +68,7 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static void do_coarse(const struct vdso_data *vd, clockid_t clk,
+static int do_coarse(const struct vdso_data *vd, clockid_t clk,
 		      struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -79,6 +79,8 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	return 0;
 }
 
 static __maybe_unused int
@@ -96,14 +98,13 @@ __cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 	 * clocks are handled in the VDSO directly.
 	 */
 	msk = 1U << clock;
-	if (likely(msk & VDSO_HRES)) {
+	if (likely(msk & VDSO_HRES))
 		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
-	} else if (msk & VDSO_COARSE) {
-		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
-		return 0;
-	} else if (msk & VDSO_RAW) {
+	else if (msk & VDSO_COARSE)
+		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+	else if (msk & VDSO_RAW)
 		return do_hres(&vd[CS_RAW], clock, ts);
-	}
+
 	return -1;
 }
 
