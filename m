Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C135813AA2B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgANNDn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 08:03:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgANNCg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:36 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLq4-0004nl-S4; Tue, 14 Jan 2020 14:02:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F1EAE1C081A;
        Tue, 14 Jan 2020 14:02:21 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:21 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Add unlikely() hint into vdso_read_begin()
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-2-dima@arista.com>
References: <20191112012724.250792-2-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900694182.396.7317245698393381452.tip-bot2@tip-bot2>
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

Commit-ID:     0898a16a362d436464b34fa644d0d46efc81df92
Gitweb:        https://git.kernel.org/tip/0898a16a362d436464b34fa644d0d46efc81df92
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:26:50 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:47 +01:00

lib/vdso: Add unlikely() hint into vdso_read_begin()

Place the branch with no concurrent write before the contended case.

Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
(more clock_gettime() cycles - the better):
        | before    | after
-----------------------------------
        | 150252214 | 153242367
        | 150301112 | 153324800
        | 150392773 | 153125401
        | 150373957 | 153399355
        | 150303157 | 153489417
        | 150365237 | 153494270
-----------------------------------
avg     | 150331408 | 153345935
diff %  | 2	    | 0
-----------------------------------
stdev % | 0.3	    | 0.1

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20191112012724.250792-2-dima@arista.com


---
 include/vdso/helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 01641db..9a2af9f 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -10,7 +10,7 @@ static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
 
-	while ((seq = READ_ONCE(vd->seq)) & 1)
+	while (unlikely((seq = READ_ONCE(vd->seq)) & 1))
 		cpu_relax();
 
 	smp_rmb();
