Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246471399BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2020 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAMTJ4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Jan 2020 14:09:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40011 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgAMTJ4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55z-0001Dh-JN; Mon, 13 Jan 2020 20:09:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 351E01C18F4;
        Mon, 13 Jan 2020 20:09:34 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:34 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm64: compat: vdso: Expose BUILD_VDSO32
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-2-vincenzo.frascino@arm.com>
References: <20190830135902.20861-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157894257404.19145.1701846128821842403.tip-bot2@tip-bot2>
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

Commit-ID:     4845c25326cf1db48e010a0fb162da4dfb07665a
Gitweb:        https://git.kernel.org/tip/4845c25326cf1db48e010a0fb162da4dfb07665a
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:58:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Jan 2020 21:14:04 +01:00

arm64: compat: vdso: Expose BUILD_VDSO32

clock_gettime32 and clock_getres_time32 should be compiled only with the
32 bit vdso library.

Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
indication to the generic library to include these symbols.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20190830135902.20861-2-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index c50ee1b..fe7afe0 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -17,6 +17,7 @@
 #define VDSO_HAS_CLOCK_GETRES		1
 
 #define VDSO_HAS_32BIT_FALLBACK		1
+#define BUILD_VDSO32			1
 
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
