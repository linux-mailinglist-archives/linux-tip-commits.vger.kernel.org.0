Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759711F9029
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jun 2020 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFOHmO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOHmN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 03:42:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEADC061A0E;
        Mon, 15 Jun 2020 00:42:13 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkjkv-0003IX-2c; Mon, 15 Jun 2020 09:42:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A70B41C00ED;
        Mon, 15 Jun 2020 09:42:08 +0200 (CEST)
Date:   Mon, 15 Jun 2020 07:42:08 -0000
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix memory bandwidth counter width for AMD
Cc:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159129975546.62538.5656031125604254041.stgit@naples-babu.amd.com>
References: <159129975546.62538.5656031125604254041.stgit@naples-babu.amd.com>
MIME-Version: 1.0
Message-ID: <159220692843.16989.9350605607122935266.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2c18bd525c47f882f033b0a813ecd09c93e1ecdf
Gitweb:        https://git.kernel.org/tip/2c18bd525c47f882f033b0a813ecd09c93e1ecdf
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Thu, 04 Jun 2020 14:45:16 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Jun 2020 09:35:38 +02:00

x86/resctrl: Fix memory bandwidth counter width for AMD

Memory bandwidth is calculated reading the monitoring counter
at two intervals and calculating the delta. It is the software’s
responsibility to read the count often enough to avoid having
the count roll over _twice_ between reads.

The current code hardcodes the bandwidth monitoring counter's width
to 24 bits for AMD. This is due to default base counter width which
is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
to adjust the counter width. But, the AMD hardware supports much
wider bandwidth counter with the default width of 44 bits.

Kernel reads these monitoring counters every 1 second and adjusts the
counter value for overflow. With 24 bits and scale value of 64 for AMD,
it can only measure up to 1GB/s without overflowing. For the rates
above 1GB/s this will fail to measure the bandwidth.

Fix the issue setting the default width to 44 bits by adjusting the
offset.

AMD future products will implement CPUID 0xF.[ECX=1]:EAX.

 [ bp: Let the line stick out and drop {}-brackets around a single
   statement. ]

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/159129975546.62538.5656031125604254041.stgit@naples-babu.amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12f967c..6a9df71 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -981,10 +981,10 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 
 		c->x86_cache_max_rmid  = ecx;
 		c->x86_cache_occ_scale = ebx;
-		if (c->x86_vendor == X86_VENDOR_INTEL)
-			c->x86_cache_mbm_width_offset = eax & 0xff;
-		else
-			c->x86_cache_mbm_width_offset = -1;
+		c->x86_cache_mbm_width_offset = eax & 0xff;
+
+		if (c->x86_vendor == X86_VENDOR_AMD && !c->x86_cache_mbm_width_offset)
+			c->x86_cache_mbm_width_offset = MBM_CNTR_WIDTH_OFFSET_AMD;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f20a47d..5ffa322 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -37,6 +37,7 @@
 #define MBA_IS_LINEAR			0x4
 #define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
+#define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
