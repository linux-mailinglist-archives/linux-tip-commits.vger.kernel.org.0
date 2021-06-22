Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE843B0397
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFVMF5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:05:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhFVMFz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:55 -0400
Date:   Tue, 22 Jun 2021 12:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624363419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kWYD3IRubvAUvj/yiT2+OksqbrHAVVXoK/Zd7lYsOI=;
        b=lvSG93i0YUONCJ0GYwnIo/snYcb/mK54OcXB+49nJYDxOMwWhlEAS0LHhakSLZdXwDmiwc
        CAORsgnZ8Pv5rL3MmT7qVJ+/uIDDZOwNJbWer26c+KDED50qz/tqJaIeuFlbr0Lu89K6UI
        XfaZ6inWw1A0HfJK5J8Dw0+pQBZDvXhId0C2XqMxS1U7a4fItKn13GkwonXthcuEysJaW6
        ig24Beq3OMxWG6r4UpL6L5T3ZbGGriaHpV7LcBOysWadIR0Ef4tlTSETKJEXvDIER3dsL8
        WT5wzJd/FD35yKCmdKtdoc55mgJPMbvTIIEWfO93x8+Qvmr1Of4Xp0jkP+BW2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624363419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kWYD3IRubvAUvj/yiT2+OksqbrHAVVXoK/Zd7lYsOI=;
        b=OB9ZPmGZfCLUNnCrR/tebcN0YWlcKOCbIdiuuWok/3Muhs9CSNDtErbhemk6/Xhi2xxIig
        QZ277Vk8qb8QUUDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/xen: Fix noinstr fail in exc_xen_unknown_trap()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210621120120.606560778@infradead.org>
References: <20210621120120.606560778@infradead.org>
MIME-Version: 1.0
Message-ID: <162436341858.395.18191923048463277858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     4c9c26f1e67648f41f28f8c997c5c9467a3dbbe4
Gitweb:        https://git.kernel.org/tip/4c9c26f1e67648f41f28f8c997c5c9467a3dbbe4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Jun 2021 13:12:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 13:56:42 +02:00

x86/xen: Fix noinstr fail in exc_xen_unknown_trap()

Fix:

  vmlinux.o: warning: objtool: exc_xen_unknown_trap()+0x7: call to printk() leaves .noinstr.text section

Fixes: 2e92493637a0 ("x86/xen: avoid warning in Xen pv guest with CONFIG_AMD_MEM_ENCRYPT enabled")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210621120120.606560778@infradead.org
---
 arch/x86/xen/enlighten_pv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index e87699a..0314942 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -592,8 +592,10 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
 DEFINE_IDTENTRY_RAW(exc_xen_unknown_trap)
 {
 	/* This should never happen and there is no way to handle it. */
+	instrumentation_begin();
 	pr_err("Unknown trap in Xen PV mode.");
 	BUG();
+	instrumentation_end();
 }
 
 #ifdef CONFIG_X86_MCE
