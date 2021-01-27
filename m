Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF830641A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbhA0Tcv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:32:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbhA0TcR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:32:17 -0500
Date:   Wed, 27 Jan 2021 19:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWd9zuAKnbFdypCI+AMFWb/xOlm+1GwlYKXpziv/GsE=;
        b=hAHhUcvTB1/LQakNOuKdwbiV1e4occ20MEPp0ol+89XamcR0VMR0vaAk8Ixz75sCmmc0HG
        VvdjfOWKJtftobtCEWVsE2SgP+zZIUR1KrkFDzSua9o2SixLyEzKkPY5WaOxJ4CgEH6lMY
        zp4PRdAGKgG48Z6lEgZLXA7p1LrQyXNPCYB/6GFIP9a/4E/S+lwHIgoKpIXnTgQJHtvqu3
        z9W+xKiSxw/mGpvqm1ZkFrpoDN0e6kp3ReQ1z2I1qCh78UtP52FnM4Rl+QIyE8107hfPUc
        kW3aOBpnJJJDkKVbdOrHuJ9rU62dclcrRJsqH+6uohFmsw3wAtltEcYraX1wMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWd9zuAKnbFdypCI+AMFWb/xOlm+1GwlYKXpziv/GsE=;
        b=cdZzZjK0+2kOfepF4lCvv17jAGIVXtZ1gYHPDnEZhpfy8qEo1AtW7vW5p7b79nVsv7aNWD
        9RkGpEqqEomWHQAw==
From:   "tip-bot2 for Misono Tomohiro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/MSR: Filter MSR writes through X86_IOC_WRMSR_REGS
 ioctl too
Cc:     Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127122456.13939-1-misono.tomohiro@jp.fujitsu.com>
References: <20210127122456.13939-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
Message-ID: <161177589483.23325.9744949016620095034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     02a16aa13574c8526beadfc9ae8cc9b66315fa2d
Gitweb:        https://git.kernel.org/tip/02a16aa13574c8526beadfc9ae8cc9b66315fa2d
Author:        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
AuthorDate:    Wed, 27 Jan 2021 21:24:56 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Jan 2021 19:06:47 +01:00

x86/MSR: Filter MSR writes through X86_IOC_WRMSR_REGS ioctl too

Commit

  a7e1f67ed29f ("x86/msr: Filter MSR writes")

introduced a module parameter to disable writing to the MSR device file
and tainted the kernel upon writing. As MSR registers can be written by
the X86_IOC_WRMSR_REGS ioctl too, the same filtering and tainting should
be applied to the ioctl as well.

 [ bp: Massage commit message and space out statements. ]

Fixes: a7e1f67ed29f ("x86/msr: Filter MSR writes")
Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210127122456.13939-1-misono.tomohiro@jp.fujitsu.com
---
 arch/x86/kernel/msr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 8a67d1f..ed8ac6b 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -182,6 +182,13 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 		err = security_locked_down(LOCKDOWN_MSR);
 		if (err)
 			break;
+
+		err = filter_write(regs[1]);
+		if (err)
+			return err;
+
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
