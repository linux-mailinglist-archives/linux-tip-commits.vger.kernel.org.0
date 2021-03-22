Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBDB345109
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 21:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhCVUnG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhCVUmz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 16:42:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD8C061574;
        Mon, 22 Mar 2021 13:42:55 -0700 (PDT)
Date:   Mon, 22 Mar 2021 20:42:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616445773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eL4EtL6oLowecQeGgdWbHbb9Yixcka2Vw8j1Ug2l4iQ=;
        b=GePeupATapkK/WmGytwXtu+ZF3jc9VCFZcVztW8JqSBKEHfcRaYoJl2GKEt3UsPFqgFBPn
        uIl+zUKd6rw1Y/tTKgE5i+GUTqGS+1crAjIKrzhUgAL9l3Jm/iBUOZdrbMxz/pO86wOsy3
        VFdtnrk+TGQ5YVikXlaKWy2EQNS1eS0pjUpuR82xzFA4+5RldyBA3v0/FXkRrFOMnNloy6
        5b4+9oI77ZAeqUJoZbfbLjjY7J2sr1TRTHBcFgAmy+HW9YKijC8HKMnCVXsym07zYlaxWE
        N97wIsKVmY3ICP+lTzSd++F0CNURjSb7XjJc4etGIEO+VapyGi/UPM6HYxcYYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616445773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eL4EtL6oLowecQeGgdWbHbb9Yixcka2Vw8j1Ug2l4iQ=;
        b=p0H2hULJTQHKKtl5Si1WANMA0zKNwWwu7UdoEiE0K4/FIqhWsCsdFqaDfnadcj8/JAzLMp
        pTWyWxa/fK9uPPBQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Fix wr/rdmsr_safe_regs_on_cpu() prototypes
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210322164541.912261-1-arnd@kernel.org>
References: <20210322164541.912261-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161644577189.398.4382487536270962603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     396a66aa1172ef2b78c21651f59b40b87b2e5e1e
Gitweb:        https://git.kernel.org/tip/396a66aa1172ef2b78c21651f59b40b87b2=
e5e1e
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 Mar 2021 17:45:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 21:37:03 +01:00

x86/msr: Fix wr/rdmsr_safe_regs_on_cpu() prototypes

gcc-11 warns about mismatched prototypes here:

  arch/x86/lib/msr-smp.c:255:51: error: argument 2 of type =E2=80=98u32 *=E2=
=80=99 {aka =E2=80=98unsigned int *=E2=80=99} declared as a pointer [-Werror=
=3Darray-parameter=3D]
    255 | int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
        |                                              ~~~~~^~~~
  arch/x86/include/asm/msr.h:347:50: note: previously declared as an array =
=E2=80=98u32[8]=E2=80=99 {aka =E2=80=98unsigned int[8]=E2=80=99}

GCC is right here - fix up the types.

[ mingo: Twiddled the changelog. ]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210322164541.912261-1-arnd@kernel.org
---
 arch/x86/lib/msr-smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 75a0915..40bbe56 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -252,7 +252,7 @@ static void __wrmsr_safe_regs_on_cpu(void *info)
 	rv->err =3D wrmsr_safe_regs(rv->regs);
 }
=20
-int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
+int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	int err;
 	struct msr_regs_info rv;
@@ -265,7 +265,7 @@ int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
 }
 EXPORT_SYMBOL(rdmsr_safe_regs_on_cpu);
=20
-int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
+int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	int err;
 	struct msr_regs_info rv;
