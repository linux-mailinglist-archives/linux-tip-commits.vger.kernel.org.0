Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1D3EA195
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 11:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhHLJJD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhHLJJC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 05:09:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4850C061765;
        Thu, 12 Aug 2021 02:08:37 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:08:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628759314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3eKGxrKPBp9ybTNWh9cI4JTd+/8+M2A56aoqQy1uvg=;
        b=YyPjKSzbD9IXR20Ski5DFsMY9GRCcY1Rq6f6FrkEw5mXdJSw/BrwesuxIfQ02owQnU7v71
        p7rV4Fv/BZzKlYTyTek4AFqDb7wX3r64hsR+Upf7PHmzCf5G0wfgtntj5h/gMQaJnElh6K
        EdGAmHiqitXESrxVeYkqzrKyf/WEReWTjmjab3+1H0priSlGmxN7dWPhB/I4kn15z+9qD4
        BxtRuJukFnow4kexQeteuQpo/InDFhrvi3J0bRwux9UwXxINQagC9ys+U/6KHaamQgI2qf
        kdg+DLmOsKO/3g+1ItSj92OwFNWav8LWKr10OAtqbtylzNfa5UOQ9Q0tWm3aiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628759314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3eKGxrKPBp9ybTNWh9cI4JTd+/8+M2A56aoqQy1uvg=;
        b=68JQSXOCz47BR4Ruu29zLkPbAP5nGIBo97B76VmA/NsRJRG4ksSaVpAkiyuE19fVxZVZb6
        n/6Fs3VxQa9HehCw==
From:   "tip-bot2 for Baokun Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/power: Fix kernel-doc warnings in cpu.c
Cc:     Baokun Li <libaokun1@huawei.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210618022421.1595596-1-libaokun1@huawei.com>
References: <20210618022421.1595596-1-libaokun1@huawei.com>
MIME-Version: 1.0
Message-ID: <162875931350.395.2875981524074684728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     afc880cbb294026c2a43501cad26c21720f7078f
Gitweb:        https://git.kernel.org/tip/afc880cbb294026c2a43501cad26c21720f7078f
Author:        Baokun Li <libaokun1@huawei.com>
AuthorDate:    Fri, 18 Jun 2021 10:24:21 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 12 Aug 2021 10:15:40 +02:00

x86/power: Fix kernel-doc warnings in cpu.c

Fixes the following kernel-doc warnings:

 arch/x86/power/cpu.c:76: warning: Function parameter or
  member 'ctxt' not described in '__save_processor_state'
 arch/x86/power/cpu.c:192: warning: Function parameter or
  member 'ctxt' not described in '__restore_processor_state'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210618022421.1595596-1-libaokun1@huawei.com
---
 arch/x86/power/cpu.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 3a070e7..6665f88 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -58,19 +58,20 @@ static void msr_restore_context(struct saved_context *ctxt)
 }
 
 /**
- *	__save_processor_state - save CPU registers before creating a
- *		hibernation image and before restoring the memory state from it
- *	@ctxt - structure to store the registers contents in
+ * __save_processor_state() - Save CPU registers before creating a
+ *                             hibernation image and before restoring
+ *                             the memory state from it
+ * @ctxt: Structure to store the registers contents in.
  *
- *	NOTE: If there is a CPU register the modification of which by the
- *	boot kernel (ie. the kernel used for loading the hibernation image)
- *	might affect the operations of the restored target kernel (ie. the one
- *	saved in the hibernation image), then its contents must be saved by this
- *	function.  In other words, if kernel A is hibernated and different
- *	kernel B is used for loading the hibernation image into memory, the
- *	kernel A's __save_processor_state() function must save all registers
- *	needed by kernel A, so that it can operate correctly after the resume
- *	regardless of what kernel B does in the meantime.
+ * NOTE: If there is a CPU register the modification of which by the
+ * boot kernel (ie. the kernel used for loading the hibernation image)
+ * might affect the operations of the restored target kernel (ie. the one
+ * saved in the hibernation image), then its contents must be saved by this
+ * function.  In other words, if kernel A is hibernated and different
+ * kernel B is used for loading the hibernation image into memory, the
+ * kernel A's __save_processor_state() function must save all registers
+ * needed by kernel A, so that it can operate correctly after the resume
+ * regardless of what kernel B does in the meantime.
  */
 static void __save_processor_state(struct saved_context *ctxt)
 {
@@ -181,9 +182,9 @@ static void fix_processor_context(void)
 }
 
 /**
- * __restore_processor_state - restore the contents of CPU registers saved
- *                             by __save_processor_state()
- * @ctxt - structure to load the registers contents from
+ * __restore_processor_state() - Restore the contents of CPU registers saved
+ *                               by __save_processor_state()
+ * @ctxt: Structure to load the registers contents from.
  *
  * The asm code that gets us here will have restored a usable GDT, although
  * it will be pointing to the wrong alias.
