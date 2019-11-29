Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5710D4B8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2019 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfK2LX5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Nov 2019 06:23:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48628 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LX4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Nov 2019 06:23:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaeND-0004KA-RM; Fri, 29 Nov 2019 12:23:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 87C831C211B;
        Fri, 29 Nov 2019 12:23:43 +0100 (CET)
Date:   Fri, 29 Nov 2019 11:23:43 -0000
From:   "tip-bot2 for Kai-Heng Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] x86/intel: Disable HPET on Intel Coffee Lake H platforms
Cc:     "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        feng.tang@intel.com, harry.pan@intel.com, hpa@zytor.com,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191129062303.18982-1-kai.heng.feng@canonical.com>
References: <20191129062303.18982-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Message-ID: <157502662346.21853.2020803002455006858.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f8edbde885bbcab6a2b4a1b5ca614e6ccb807577
Gitweb:        https://git.kernel.org/tip/f8edbde885bbcab6a2b4a1b5ca614e6ccb807577
Author:        Kai-Heng Feng <kai.heng.feng@canonical.com>
AuthorDate:    Fri, 29 Nov 2019 14:23:02 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Nov 2019 12:17:58 +01:00

x86/intel: Disable HPET on Intel Coffee Lake H platforms

Coffee Lake H SoC has similar behavior as Coffee Lake, skewed HPET timer
once the SoCs entered PC10.

So let's disable HPET on CFL-H platforms.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: feng.tang@intel.com
Cc: harry.pan@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20191129062303.18982-1-kai.heng.feng@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/early-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 4cba91e..606711f 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -710,6 +710,8 @@ static struct chipset early_qrk[] __initdata = {
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x3e20,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
