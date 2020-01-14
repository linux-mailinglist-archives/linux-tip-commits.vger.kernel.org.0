Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6989E13AA26
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 14:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgANNDc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 08:03:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgANNCi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLq6-0004p9-R6; Tue, 14 Jan 2020 14:02:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBC831C0820;
        Tue, 14 Jan 2020 14:02:22 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:22 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-9-vincenzo.frascino@arm.com>
References: <20190830135902.20861-9-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157900694266.396.5889366639998860104.tip-bot2@tip-bot2>
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

Commit-ID:     0b5c12332db5b71c6db0c102b3e6acc7c7c6a54d
Gitweb:        https://git.kernel.org/tip/0b5c12332db5b71c6db0c102b3e6acc7c7c6a54d
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:59:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:46 +01:00

x86/vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

VDSO_HAS_32BIT_FALLBACK has been removed from the core since
the architectures that support the generic vDSO library have
been converted to support the 32 bit fallbacks.

Remove unused VDSO_HAS_32BIT_FALLBACK from x86 vdso.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20190830135902.20861-9-vincenzo.frascino@arm.com


---
 arch/x86/include/asm/vdso/gettimeofday.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index e9ee139..52c3bcd 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -96,8 +96,6 @@ long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 
 #else
 
-#define VDSO_HAS_32BIT_FALLBACK	1
-
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
