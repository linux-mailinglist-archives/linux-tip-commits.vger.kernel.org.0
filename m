Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEA2B7DA7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 13:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgKRMbZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 07:31:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKRMbW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 07:31:22 -0500
Date:   Wed, 18 Nov 2020 12:31:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605702680;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gY79bn/JOxIN1PIIo0Y3ayMJ2So8MvH5Ka59GLpA/co=;
        b=FTXsgfyjo/AVtuPVr5vg5/leS9Lximb2TMfCOGgipMPktNV25PCTUWFGRrnuGYHCQsdNxW
        WGBZMIj+NdHqP27gmOv2+VzKSMv9wN/i4R5ONEicWkX4vurwqbE1fhSNDhBJDdmFhkMMoL
        4N7kUutNUhNz6lE/9nBRsPn0gv6w+JCBipi7faeIOMCk71RVCCX0Khypa0tRxbdYyqKIVO
        1/GLHNBG91+CdWpQp8DS+/rPlz+/N3N9sdPlInzUY7HC4WG9XdlapDQzYxtR2mZk7bKslv
        Nc57QpjJC4refHhCGwfOyVuASDX/b2uW8uKCoMalEc12UPMhZaDd0wRwstfE8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605702680;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gY79bn/JOxIN1PIIo0Y3ayMJ2So8MvH5Ka59GLpA/co=;
        b=nDKm4xWPlF9IxDHumh5UMOVI0jT5odGYD+8A5q/j/4PdYLELVoAMxLdnWfHdC2Zry3Mdd/
        T7RT6O6zJKqZoMCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/uaccess: Document copy_from_user_nmi()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201117202753.806376613@linutronix.de>
References: <20201117202753.806376613@linutronix.de>
MIME-Version: 1.0
Message-ID: <160570267965.11244.13389205990310912289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     907f8eb8e0eb2b3312b292e67dc4dbc493424747
Gitweb:        https://git.kernel.org/tip/907f8eb8e0eb2b3312b292e67dc4dbc493424747
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 21:23:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 13:19:01 +01:00

x86/uaccess: Document copy_from_user_nmi()

Document the functionality of copy_from_user_nmi() to avoid further
confusion. Fix the typo in the existing comment while at it.

Requested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201117202753.806376613@linutronix.de
---
 arch/x86/lib/usercopy.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index 3f435d7..c3e8a62 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -9,9 +9,23 @@
 
 #include <asm/tlbflush.h>
 
-/*
- * We rely on the nested NMI work to allow atomic faults from the NMI path; the
- * nested NMI paths are careful to preserve CR2.
+/**
+ * copy_from_user_nmi - NMI safe copy from user
+ * @to:		Pointer to the destination buffer
+ * @from:	Pointer to a user space address of the current task
+ * @n:		Number of bytes to copy
+ *
+ * Returns: The number of not copied bytes. 0 is success, i.e. all bytes copied
+ *
+ * Contrary to other copy_from_user() variants this function can be called
+ * from NMI context. Despite the name it is not restricted to be called
+ * from NMI context. It is safe to be called from any other context as
+ * well. It disables pagefaults across the copy which means a fault will
+ * abort the copy.
+ *
+ * For NMI context invocations this relies on the nested NMI work to allow
+ * atomic faults from the NMI path; the nested NMI paths are careful to
+ * preserve CR2.
  */
 unsigned long
 copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
@@ -27,7 +41,7 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 	/*
 	 * Even though this function is typically called from NMI/IRQ context
 	 * disable pagefaults so that its behaviour is consistent even when
-	 * called form other contexts.
+	 * called from other contexts.
 	 */
 	pagefault_disable();
 	ret = __copy_from_user_inatomic(to, from, n);
