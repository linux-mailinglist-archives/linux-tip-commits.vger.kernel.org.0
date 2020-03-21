Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10FA18E1F7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Mar 2020 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCUOe0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 21 Mar 2020 10:34:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgCUOdi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 21 Mar 2020 10:33:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFfBu-0004AV-Ao; Sat, 21 Mar 2020 15:33:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EFDF1C22DA;
        Sat, 21 Mar 2020 15:33:31 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:33:30 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] mips: Introduce asm/vdso/clocksource.h
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paulburton@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320145351.32292-8-vincenzo.frascino@arm.com>
References: <20200320145351.32292-8-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158480121095.28353.14019997278600648111.tip-bot2@tip-bot2>
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

Commit-ID:     17e46656a82fc4645324043241b3294f6db9a6ce
Gitweb:        https://git.kernel.org/tip/17e46656a82fc4645324043241b3294f6db9a6ce
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 20 Mar 2020 14:53:32 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:23:55 +01:00

mips: Introduce asm/vdso/clocksource.h

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Introduce asm/vdso/clocksource.h to contain all the arm64 specific
functions that are suitable for vDSO inclusion.

This header will be required by a future patch that will generalize
vdso/clocksource.h.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Burton <paulburton@kernel.org>
Link: https://lkml.kernel.org/r/20200320145351.32292-8-vincenzo.frascino@arm.com

---
 arch/mips/include/asm/clocksource.h      |  4 +---
 arch/mips/include/asm/vdso/clocksource.h |  9 +++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso/clocksource.h

diff --git a/arch/mips/include/asm/clocksource.h b/arch/mips/include/asm/clocksource.h
index de659ca..2f1ebbe 100644
--- a/arch/mips/include/asm/clocksource.h
+++ b/arch/mips/include/asm/clocksource.h
@@ -6,8 +6,6 @@
 #ifndef __ASM_CLOCKSOURCE_H
 #define __ASM_CLOCKSOURCE_H
 
-#define VDSO_ARCH_CLOCKMODES	\
-	VDSO_CLOCKMODE_R4K,	\
-	VDSO_CLOCKMODE_GIC
+#include <asm/vdso/clocksource.h>
 
 #endif /* __ASM_CLOCKSOURCE_H */
diff --git a/arch/mips/include/asm/vdso/clocksource.h b/arch/mips/include/asm/vdso/clocksource.h
new file mode 100644
index 0000000..510e167
--- /dev/null
+++ b/arch/mips/include/asm/vdso/clocksource.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_VDSOCLOCKSOURCE_H
+#define __ASM_VDSOCLOCKSOURCE_H
+
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_R4K,	\
+	VDSO_CLOCKMODE_GIC
+
+#endif /* __ASM_VDSOCLOCKSOURCE_H */
