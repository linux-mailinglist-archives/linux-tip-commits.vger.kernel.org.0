Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C53365473
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhDTIrE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 04:47:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhDTIrE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 04:47:04 -0400
Date:   Tue, 20 Apr 2021 08:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618908392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rNMlNn8l38zOXAdcT8PCfDh+L6pu0IlKcPuXK695WXs=;
        b=QLW9Q12SX49yzXFtk0aPocwRECY/wdrLN1rXgWD9XUsJE71nBBC1QMvHa80BmKoJB4uu85
        FxIQFH3OLfEIUPNrRDKqVU8q4VWHduhWhFyA4rG803z63HV3tW2wS6a8MgdCsDZGkMedAY
        I9blWhkvBC9Xw6z0l/yknQMeh4PA257mOxH8ZQltWrnDuzW3zo78/f7eOpYmgCfJod4F7g
        BuE0PcULZ47HU/TBqPVnByoZUgDJchHcA7Ac0V3lmIO+cjPopjyXexP6Zgd9bsPeli2WIh
        0AowNrDzQtb9CPzwthvedrvYwSQpwNZVhZqWa3sxeyj+0WSOiZ7J08oDarJYEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618908392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rNMlNn8l38zOXAdcT8PCfDh+L6pu0IlKcPuXK695WXs=;
        b=VgXZWKgo62o2fksAPXRLgS7IfaC9ZNo1OSzrHPGDYYLdkEV1XzHZZwEPZu76VC4g4Er9AD
        jb8sS17K7DI5gbDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove dead !CONFIG_KEXEC_CORE code
Cc:     Ingo Molnar <mingo@kernel.org>, Mike Travis <travis@sgi.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161890839197.29796.11895612342137969133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     27743f01e391ee1d80e3be2a09237507b965f91b
Gitweb:        https://git.kernel.org/tip/27743f01e391ee1d80e3be2a09237507b965f91b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 20 Apr 2021 10:03:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 20 Apr 2021 10:08:34 +02:00

x86/platform/uv: Remove dead !CONFIG_KEXEC_CORE code

The !CONFIG_KEXEC_CORE code in arch/x86/platform/uv/uv_nmi.c was unused, untested
and didn't even build for 7 years. Since we fixed this by requiring X86_UV to
depend on CONFIG_KEXEC_CORE, remove the (now) dead code.

Also move the uv_nmi_kexec_failed definition back up to where the other file-scope
global variables are defined.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mike Travis <travis@sgi.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/platform/uv/uv_nmi.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index f83810f..1556108 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -92,6 +92,8 @@ static atomic_t uv_nmi_cpus_in_nmi = ATOMIC_INIT(-1);
 static atomic_t uv_nmi_slave_continue;
 static cpumask_var_t uv_nmi_cpu_mask;
 
+static atomic_t uv_nmi_kexec_failed;
+
 /* Values for uv_nmi_slave_continue */
 #define SLAVE_CLEAR	0
 #define SLAVE_CONTINUE	1
@@ -835,8 +837,6 @@ static void uv_nmi_touch_watchdogs(void)
 	touch_nmi_watchdog();
 }
 
-#if defined(CONFIG_KEXEC_CORE)
-static atomic_t uv_nmi_kexec_failed;
 static void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
 {
 	/* Check if kdump kernel loaded for both main and secondary CPUs */
@@ -867,15 +867,6 @@ static void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
 	}
 }
 
-#else /* !CONFIG_KEXEC_CORE */
-static inline void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
-{
-	if (main)
-		pr_err("UV: NMI kdump: KEXEC not supported in this kernel\n");
-	atomic_set(&uv_nmi_kexec_failed, 1);
-}
-#endif /* !CONFIG_KEXEC_CORE */
-
 #ifdef CONFIG_KGDB
 #ifdef CONFIG_KGDB_KDB
 static inline int uv_nmi_kdb_reason(void)
