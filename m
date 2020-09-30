Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4B27E423
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgI3Ito (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 04:49:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgI3Itn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 04:49:43 -0400
Date:   Wed, 30 Sep 2020 08:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601455782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbvalvKA9ZIHtrktA2tmAl+rf92frhbBnwEuI+26Dvk=;
        b=mo4vZinVyp888xMXSVEclttoYr2QKzVEJ0FsmJP3ZO6lhlH7dGqCvbyiGuPtBo6TXYZq7h
        NDOirfGJYoBmzoRCcJOb6CGuadxOyNqsIdd8J/6An4/+JZ07E3LGQc27xvM51J0R+/27g7
        pEV/H5SEuGMRtkl837/FiPEvtMn1u9dtoioEruRO99tIU160uuKsMZDeKYsulNIVfSBWzj
        yS5DEVGVC4xqOgMLDoZBgMsxfha65NDWXO/wiMoczfVjwklF1YMNFo+IJMZSLOydfLUH2o
        SEex1E3O90XrPRtyUIuEpTRI12ffdXJoNiaLamSTIiv/WHqz7h/wfn9lbG/jiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601455782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbvalvKA9ZIHtrktA2tmAl+rf92frhbBnwEuI+26Dvk=;
        b=RofG/ub5Pk37XuaIKOtFMJ38uUD2OscpYuBV2K845TzE/Wwz+nxb2yY+ydLYLvZxZ2cqdj
        crhFMEXPd9wI33Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mce: Use idtentry_nmi_enter/exit()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87mu17ism2.fsf@nanos.tec.linutronix.de>
References: <87mu17ism2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160145578095.7002.16637144000710644354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bc21a291fc11bbd60868c45b9f5a79ceed97fd4e
Gitweb:        https://git.kernel.org/tip/bc21a291fc11bbd60868c45b9f5a79ceed97fd4e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 30 Sep 2020 10:19:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Sep 2020 10:41:56 +02:00

x86/mce: Use idtentry_nmi_enter/exit()

The recent fix for NMI vs. IRQ state tracking missed to apply the cure
to the MCE handler.

Fixes: ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/87mu17ism2.fsf@nanos.tec.linutronix.de
---
 arch/x86/kernel/cpu/mce/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78b..fc4f8c0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1904,6 +1904,8 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	bool irq_state;
+
 	WARN_ON_ONCE(user_mode(regs));
 
 	/*
@@ -1914,7 +1916,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	    mce_check_crashing_cpu())
 		return;
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -1925,7 +1927,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
