Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35A113FA95
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2020 21:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgAPU26 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Jan 2020 15:28:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbgAPU25 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Jan 2020 15:28:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isBl4-0000hQ-Td; Thu, 16 Jan 2020 21:28:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8222E1C0E63;
        Thu, 16 Jan 2020 21:28:50 +0100 (CET)
Date:   Thu, 16 Jan 2020 20:28:50 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] MIPS: vdso: Define BUILD_VDSO32 when building a
 32bit kernel
Cc:     kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paulburton@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87d0bjfaqa.fsf@nanos.tec.linutronix.de>
References: <87d0bjfaqa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <157920653035.396.8439666878206686065.tip-bot2@tip-bot2>
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

Commit-ID:     99570c3da96a0f7aa11c6ad4981776f3adabf3b5
Gitweb:        https://git.kernel.org/tip/99570c3da96a0f7aa11c6ad4981776f3adabf3b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 16 Jan 2020 20:43:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2020 21:24:25 +01:00

MIPS: vdso: Define BUILD_VDSO32 when building a 32bit kernel

The confinement of the 32bit specific VDSO functions missed to define
BUILD_VDSO32 when building a 32bit MIPS kernel:

arch/mips/vdso/vgettimeofday.c: In function __vdso_clock_gettime:
arch/mips/vdso/vgettimeofday.c:17:9: error: implicit declaration of function __cvdso_clock_gettime32

arch/mips/vdso/vgettimeofday.c: In function __vdso_clock_getres:
arch/mips/vdso/vgettimeofday.c:39:9: error: implicit declaration of function __cvdso_clock_getres_time32

Force the define for 32bit builds in the VDSO Makefile.

Fixes: bf279849ad59 ("lib/vdso: Build 32 bit specific functions in the right context")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul Burton <paulburton@kernel.org>
Link: https://lore.kernel.org/r/87d0bjfaqa.fsf@nanos.tec.linutronix.de

---
 arch/mips/vdso/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index e059389..b2a2e03 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -18,6 +18,10 @@ ccflags-vdso := \
 	$(filter -mno-loongson-%,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
 
+ifndef CONFIG_64BIT
+ccflags-vdso += -DBUILD_VDSO32
+endif
+
 ifdef CONFIG_CC_IS_CLANG
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
