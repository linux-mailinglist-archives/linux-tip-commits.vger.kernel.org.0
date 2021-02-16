Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3AA31C828
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Feb 2021 10:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBPJfW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Feb 2021 04:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBPJfV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Feb 2021 04:35:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C4C061574;
        Tue, 16 Feb 2021 01:34:41 -0800 (PST)
Date:   Tue, 16 Feb 2021 09:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613468079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qEKtAayEr8Y1QiesiNhk/bLBhnWzLsjGwJWi+vtocuI=;
        b=sLXqXXzu+q53gjVXBENnHxAwlgcO2jLQYRYEX5ygRBMZMD/Hze7T0ftrZKeGqkiiXZO0+h
        OrKJKJ0zcQJfbXzI/6I1yQS9oqebB5Z4hq9eIiBMiUYXW3gSOK6kexJ6SQqrwSF1ihPO99
        zrHmMGkdIVOHlCYHf4/h8gQyv5uJkBnjwQDLcrfarmYyOBu+/Bj7c5g2uv8Sy2ooAnZVuX
        ah/fwDrdrK2Xsetlfli8oPtVLUQRIgbiGHCjYyOSRlRl2O7aAsu6MVYPgzxzNiFKTjU5bT
        JauhAhmsTGf+fgjJYC4ijOd8UqOVLnXLoOG61FEy6lIqn8B2OrgoRtQ3jN6Jeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613468079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qEKtAayEr8Y1QiesiNhk/bLBhnWzLsjGwJWi+vtocuI=;
        b=Jgf48xJNaBRIvAurgKxW4zF18Cc115Cdp8pZ1nLvl4NnN0FHk5SpblZ4L+w6H+uAZdVbCS
        L6/vBlAI6WsbQ9DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] um: Enforce the usage of asm-generic/softirq_stack.h
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161346807864.20312.12484247851663762729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3aac798a917be3b8f2f647b834bb06bf2f8df4f1
Gitweb:        https://git.kernel.org/tip/3aac798a917be3b8f2f647b834bb06bf2f8df4f1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 16 Feb 2021 10:23:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 16 Feb 2021 10:23:14 +01:00

um: Enforce the usage of asm-generic/softirq_stack.h

The recent rework of the X86 irq stack switching mechanism broke UM as UM
pulls in the X86 specific variant of softirq_stack.h.

Enforce the usage of the asm-generic variant.

Fixes: 72f40a2823d6 ("x86/softirq/64: Inline do_softirq_own_stack()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1c63b26..18f8645 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += param.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += softirq_stack.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
