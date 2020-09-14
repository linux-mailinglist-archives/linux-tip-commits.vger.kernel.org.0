Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CD26936F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgINRcl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgINRcf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:32:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3CEC061788;
        Mon, 14 Sep 2020 10:32:34 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:32:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600104752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/zbi27KS6L46FLE6w6zqt0MkkEXTH5NZ8ZU0C79NAc=;
        b=JUJDZwWSiYRMcrj+V9ysGB/yuMLNZj6G3OoxEKfgSC3TWP8tkXQ2p+0doTQYjK1VzNyWHM
        YIU95uq6SmfaXzcUa8FhvLZHdJtR3ZzXSbgL2NJJ1/V64Pehcb9HEpLm9yiea4jBP+9AZq
        gXF/AkwO32oHG5OeqryPnr1LB0J274qvjKDQCiv42dveO+QTjhN4tl/rldYo5Yv1Powt6k
        RbAapeRaIrGki+hkPFSaSOCoPpSO98S1pCayj1Oj+vFo647Q38L4PLtVe2hDMCXoXIr5BX
        +ywqrr1DbuneW+BH7W9mMC746cCIsLRl/j5jNIN/dSxfJm7lUg9l5WuwJt7Zvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600104752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/zbi27KS6L46FLE6w6zqt0MkkEXTH5NZ8ZU0C79NAc=;
        b=AVP01KZgt3b8cXe3PqAMuQxFBIUeXHAMH4XhilM88Lq0qglasCnf8FzAAPiow4mmlBcRlk
        rNU2mxUHxiUqDJAw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Stop mce_reign() from re-computing severity
 for every CPU
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908175519.14223-2-tony.luck@intel.com>
References: <20200908175519.14223-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160010475181.15536.9012382774103702534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     13c877f4b48b943105ad9e13ba2c7a093fb694e8
Gitweb:        https://git.kernel.org/tip/13c877f4b48b943105ad9e13ba2c7a093fb694e8
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 08 Sep 2020 10:55:12 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 14 Sep 2020 19:25:23 +02:00

x86/mce: Stop mce_reign() from re-computing severity for every CPU

Back in commit:

  20d51a426fe9 ("x86/mce: Reuse one of the u16 padding fields in 'struct mce'")

a field was added to "struct mce" to save the computed error severity.

Make use of this in mce_reign() to avoid re-computing the severity
for every CPU.

In the case where the machine panics, one call to mce_severity() is
still needed in order to provide the correct message giving the reason
for the panic.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200908175519.14223-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a697bae..5b1d5f3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -920,7 +920,6 @@ static void mce_reign(void)
 	struct mce *m = NULL;
 	int global_worst = 0;
 	char *msg = NULL;
-	char *nmsg = NULL;
 
 	/*
 	 * This CPU is the Monarch and the other CPUs have run
@@ -928,12 +927,10 @@ static void mce_reign(void)
 	 * Grade the severity of the errors of all the CPUs.
 	 */
 	for_each_possible_cpu(cpu) {
-		int severity = mce_severity(&per_cpu(mces_seen, cpu),
-					    mca_cfg.tolerant,
-					    &nmsg, true);
-		if (severity > global_worst) {
-			msg = nmsg;
-			global_worst = severity;
+		struct mce *mtmp = &per_cpu(mces_seen, cpu);
+
+		if (mtmp->severity > global_worst) {
+			global_worst = mtmp->severity;
 			m = &per_cpu(mces_seen, cpu);
 		}
 	}
@@ -943,8 +940,11 @@ static void mce_reign(void)
 	 * This dumps all the mces in the log buffer and stops the
 	 * other CPUs.
 	 */
-	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
+	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+		/* call mce_severity() to get "msg" for panic */
+		mce_severity(m, mca_cfg.tolerant, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
+	}
 
 	/*
 	 * For UC somewhere we let the CPU who detects it handle it.
