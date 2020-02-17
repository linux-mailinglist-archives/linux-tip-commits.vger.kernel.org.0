Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064D51615BE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2020 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgBQPMZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 17 Feb 2020 10:12:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59953 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgBQPMC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 17 Feb 2020 10:12:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3i3y-0007fp-Pu; Mon, 17 Feb 2020 16:11:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 76CD31C20A8;
        Mon, 17 Feb 2020 16:11:58 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:11:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] MIPS: vdso: Compile high resolution parts conditionally
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124402.714585315@linutronix.de>
References: <20200207124402.714585315@linutronix.de>
MIME-Version: 1.0
Message-ID: <158195231824.13786.8274460203799394407.tip-bot2@tip-bot2>
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

Commit-ID:     25a2a6567829119f5e3e11eb0ce3d8ae985b6019
Gitweb:        https://git.kernel.org/tip/25a2a6567829119f5e3e11eb0ce3d8ae985b6019
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2020 13:38:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 14:40:21 +01:00

MIPS: vdso: Compile high resolution parts conditionally

If neither the R4K nor the GIC timer is enabled in the kernel configuration
then let the core VDSO code drop the high resolution parts at compile time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124402.714585315@linutronix.de


---
 arch/mips/include/asm/vdso/gettimeofday.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index a58687e..a9f846b 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -199,6 +199,13 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 	return cycle_now;
 }
 
+static inline bool mips_vdso_hres_capable(void)
+{
+	return IS_ENABLED(CONFIG_CSRC_R4K) ||
+	       IS_ENABLED(CONFIG_CLKSRC_MIPS_GIC);
+}
+#define __arch_vdso_hres_capable mips_vdso_hres_capable
+
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
 	return get_vdso_data();
