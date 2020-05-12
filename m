Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9891CF73D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 May 2020 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgELOg7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 May 2020 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELOg6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 May 2020 10:36:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681CC061A0C;
        Tue, 12 May 2020 07:36:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1e-0005lp-Ik; Tue, 12 May 2020 16:36:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3224F1C02FC;
        Tue, 12 May 2020 16:36:54 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:54 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Rework data_race() so that it can be used
 by READ_ONCE()
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-17-will@kernel.org>
References: <20200511204150.27858-17-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421408.390.18401287637902669182.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     88f1be32068d4323aa31236452352d6019a03ccc
Gitweb:        https://git.kernel.org/tip/88f1be32068d4323aa31236452352d6019a03ccc
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:17 +02:00

kcsan: Rework data_race() so that it can be used by READ_ONCE()

Rework the data_race() macro so that it:

  - Accepts expressions which evaluate to a 'const' type
  - Attempts to discard volatile qualifiers from scalar types, avoiding
    pointless stack spills
  - Uses __kcsan_{disable,enable}_current(), allowing its use from code
    that is built independently from the kernel, such as the vDSO

This will allow for its use by {READ,WRITE}_ONCE() in a subsequent patch.
At the same time, fix-up some weird whitespace issues.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200511204150.27858-17-will@kernel.org

---
 include/linux/compiler.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 548294e..cb2e3b3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -314,14 +314,15 @@ unsigned long read_word_at_a_time(const void *addr)
  * This macro *does not* affect normal code generation, but is a hint
  * to tooling that data races here are to be ignored.
  */
-#define data_race(expr)                                                        \
-	({                                                                     \
-		typeof(({ expr; })) __val;                                     \
-		kcsan_disable_current();                                       \
-		__val = ({ expr; });                                           \
-		kcsan_enable_current();                                        \
-		__val;                                                         \
-	})
+#define data_race(expr)							\
+({									\
+	__kcsan_disable_current();					\
+	({								\
+		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
+		__kcsan_enable_current();				\
+		__v;							\
+	});								\
+})
 
 #endif /* __KERNEL__ */
 
