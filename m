Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2756B40C8D7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhIOPvY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhIOPvH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55879C061788;
        Wed, 15 Sep 2021 08:49:37 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPaA+Ndvy3nR/aO6o4F+ZJvESzHNmQ6WCZp0KN02hpU=;
        b=X7edgKnhMkYgH2IjvccGV9tybfPvu2q+hKGOZHfmVGRTVAX9KFwDrZd66hpSsOzI1FjO8K
        pxp4e7l5GbZuv2JHEPWAfqQGuZl0uzrdGe59/2onyfFgsZHYWdb8CET/i7rPx4sZnBVoOr
        NduhLC2WlJIsUn0mO9RkvTln/gUuzGS9oXC3oCZkipImolNxelDrJn6lCxXtjOY1xcrbSa
        Os1bCI4Ig67Y/ISQowx1LRN1B5o3EHiBZ+uZINA5m2hgN9x5KIE4Cbkvf8jqEhf3hjO4fg
        B5ukFgtDZRG3fJNO+DPiT7pfsNSXX2VK/hhEMG+83aiJE/F5qYPJc6Gb3yFMQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPaA+Ndvy3nR/aO6o4F+ZJvESzHNmQ6WCZp0KN02hpU=;
        b=tnXBNOFJpMGDN2k4oj6Z7Q/zyfFFLLwsZwH0TYm00GYLv7LMcGoajV+gYEefnHlm9J6RrG
        CRiUMxm4pDJUIBAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Move hypercall_page to top of the file
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210820193107.omvshmsqbpxufzkc@treble>
References: <20210820193107.omvshmsqbpxufzkc@treble>
MIME-Version: 1.0
Message-ID: <163172097511.25758.14115197643418967000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b7b205c3a0bc2b51f83cb793178ccbc12addf275
Gitweb:        https://git.kernel.org/tip/b7b205c3a0bc2b51f83cb793178ccbc12addf275
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 20 Aug 2021 12:31:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:44 +02:00

x86/xen: Move hypercall_page to top of the file

Because hypercall_page is page-aligned, the assembler inexplicably adds
an unreachable jump from after the end of the previous code to the
beginning of hypercall_page.

That confuses objtool, understandably.  It also creates significant text
fragmentation.  As a result, much of the object file is wasted text
(nops).

Move hypercall_page to the beginning of the file to both prevent the
text fragmentation and avoid the dead jump instruction.

$ size /tmp/head_64.before.o /tmp/head_64.after.o
   text	   data	    bss	    dec	    hex	filename
  10924	 307252	   4096	 322272	  4eae0	/tmp/head_64.before.o
   6823	 307252	   4096	 318171	  4dadb	/tmp/head_64.after.o

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20210820193107.omvshmsqbpxufzkc@treble
---
 arch/x86/xen/xen-head.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index cb6538a..488944d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -20,6 +20,23 @@
 #include <xen/interface/xen-mca.h>
 #include <asm/xen/interface.h>
 
+.pushsection .text
+	.balign PAGE_SIZE
+SYM_CODE_START(hypercall_page)
+	.rept (PAGE_SIZE / 32)
+		UNWIND_HINT_FUNC
+		.skip 31, 0x90
+		ret
+	.endr
+
+#define HYPERCALL(n) \
+	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
+	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
+#include <asm/xen-hypercalls.h>
+#undef HYPERCALL
+SYM_CODE_END(hypercall_page)
+.popsection
+
 #ifdef CONFIG_XEN_PV
 	__INIT
 SYM_CODE_START(startup_xen)
@@ -64,23 +81,6 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #endif
 #endif
 
-.pushsection .text
-	.balign PAGE_SIZE
-SYM_CODE_START(hypercall_page)
-	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		ret
-	.endr
-
-#define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
-	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
-#include <asm/xen-hypercalls.h>
-#undef HYPERCALL
-SYM_CODE_END(hypercall_page)
-.popsection
-
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
