Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85B91399AB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2020 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAMTJx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Jan 2020 14:09:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAMTJw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55v-0001BE-Ra; Mon, 13 Jan 2020 20:09:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 014A71C18F0;
        Mon, 13 Jan 2020 20:09:33 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:32 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@mips.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-8-vincenzo.frascino@arm.com>
References: <20190830135902.20861-8-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157894257280.19145.7630717597049574259.tip-bot2@tip-bot2>
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

Commit-ID:     7bcf78b6e6891821983bd168380de1df43d42347
Gitweb:        https://git.kernel.org/tip/7bcf78b6e6891821983bd168380de1df43d42347
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:59:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Jan 2020 21:14:06 +01:00

mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

VDSO_HAS_32BIT_FALLBACK has been removed from the core since
the architectures that support the generic vDSO library have
been converted to support the 32 bit fallbacks.

Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul Burton <paul.burton@mips.com>
Link: https://lore.kernel.org/r/20190830135902.20861-8-vincenzo.frascino@arm.com

---
 arch/mips/include/asm/vdso/gettimeofday.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index 0ae9b4c..a58687e 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -96,8 +96,6 @@ static __always_inline int clock_getres_fallback(
 
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 
-#define VDSO_HAS_32BIT_FALLBACK	1
-
 static __always_inline long clock_gettime32_fallback(
 					clockid_t _clkid,
 					struct old_timespec32 *_ts)
