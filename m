Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2552A1A986C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Apr 2020 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408402AbgDOJUo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Apr 2020 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408392AbgDOJUl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Apr 2020 05:20:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA989C061A0C;
        Wed, 15 Apr 2020 02:20:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeDf-0005Hv-04; Wed, 15 Apr 2020 11:20:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CB441C0081;
        Wed, 15 Apr 2020 11:20:30 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:20:30 -0000
From:   "tip-bot2 for Jason Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/umip: Make umip_insns static
Cc:     Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200413082213.22934-1-yanaijie@huawei.com>
References: <20200413082213.22934-1-yanaijie@huawei.com>
MIME-Version: 1.0
Message-ID: <158694243002.28353.9318430528577109181.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b0e387c3ec0170b429f15c53b6183fe1c691403b
Gitweb:        https://git.kernel.org/tip/b0e387c3ec0170b429f15c53b6183fe1c691403b
Author:        Jason Yan <yanaijie@huawei.com>
AuthorDate:    Mon, 13 Apr 2020 16:22:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Apr 2020 11:13:12 +02:00

x86/umip: Make umip_insns static

Fix the following sparse warning:
  arch/x86/kernel/umip.c:84:12: warning: symbol 'umip_insns' was not declared.
  Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lkml.kernel.org/r/20200413082213.22934-1-yanaijie@huawei.com

---
 arch/x86/kernel/umip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 4d732a4..8d5cbe1 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -81,7 +81,7 @@
 #define	UMIP_INST_SLDT  3       /* 0F 00 /0 */
 #define	UMIP_INST_STR   4       /* 0F 00 /1 */
 
-const char * const umip_insns[5] = {
+static const char * const umip_insns[5] = {
 	[UMIP_INST_SGDT] = "SGDT",
 	[UMIP_INST_SIDT] = "SIDT",
 	[UMIP_INST_SMSW] = "SMSW",
