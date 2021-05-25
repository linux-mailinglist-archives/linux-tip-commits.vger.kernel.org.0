Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C338FDD4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEYJat (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhEYJat (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 05:30:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE62C061756;
        Tue, 25 May 2021 02:29:19 -0700 (PDT)
Date:   Tue, 25 May 2021 09:29:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621934958;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMhi4BfcBkO4X7AHdjy+Sn9Mwk8lxmDdsP5Lxe/p/nE=;
        b=eNwkRgZsidl6XQjbqYFTACQWz6ZpqoZHHMjPYBijOahF0tXI2iDF2+ennG1yweE8o2nezJ
        tRR4Wv98RC0Fn4WQegw8rt4C4RevlrPvO70zcl+X9JaDE7FpVSbAVFJzRw6yNeiRaMWh7D
        Jw4GAwS9QvqVyjsDParh1dg9ieFi5nw728jjU+0IPy3CRdliHyyGE8hh/03oUetXIdPAxF
        Fxz5+Wl3wdoD3a1dXq8+xWIijS3B0ZaOO5heqSVm8aq0HRomE4xWdVn5LhBsibeVnn92yo
        MJsiL5iORkcsD30ZYnyS3k4NZtZQeS3PZEEAmrxLacyhOOlCbVF8OvkfIcLKLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621934958;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMhi4BfcBkO4X7AHdjy+Sn9Mwk8lxmDdsP5Lxe/p/nE=;
        b=r+CNDwCYTqFulYT6FI587Y1qbhWqRawIiL4oOKxxoHxXswkD14YZuEMIXIMOPwGhYGyc1A
        fGqIb1FuqbRGvRDg==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Remove unused vectors defines
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519212154.511983-4-hpa@zytor.com>
References: <20210519212154.511983-4-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162193495749.29796.16612927611286189158.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     f1b7d45d3f8f3e18e190e71cb54d4b1917300d1d
Gitweb:        https://git.kernel.org/tip/f1b7d45d3f8f3e18e190e71cb54d4b1917300d1d
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 19 May 2021 14:21:49 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 May 2021 12:36:44 +02:00

x86/irq: Remove unused vectors defines

UV_BAU_MESSAGE is defined but not used anywhere in the kernel. Presumably
this is a stale vector number that can be reclaimed.

MCE_VECTOR is not an actual vector: #MC is an exception, not an interrupt
vector, and as such is correctly described as X86_TRAP_MC. MCE_VECTOR is
not used anywhere is the kernel.

Note that NMI_VECTOR *is* used; specifically it is the vector number
programmed into the APIC LVT when an NMI interrupt is configured. At
the moment it is always numerically identical to X86_TRAP_NMI, that is
not necessarily going to be the case indefinitely.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20210519212154.511983-4-hpa@zytor.com

---
 arch/x86/include/asm/irq_vectors.h       | 4 ++--
 tools/arch/x86/include/asm/irq_vectors.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 889f8b1..dc71b78 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -26,8 +26,8 @@
  * This file enumerates the exact layout of them:
  */
 
+/* This is used as an interrupt vector when programming the APIC. */
 #define NMI_VECTOR			0x02
-#define MCE_VECTOR			0x12
 
 /*
  * IDT vectors usable for external interrupt sources start at 0x20.
@@ -84,7 +84,7 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-#define UV_BAU_MESSAGE			0xf5
+/* 0xf5 - unused, was UV_BAU_MESSAGE */
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index 889f8b1..dc71b78 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -26,8 +26,8 @@
  * This file enumerates the exact layout of them:
  */
 
+/* This is used as an interrupt vector when programming the APIC. */
 #define NMI_VECTOR			0x02
-#define MCE_VECTOR			0x12
 
 /*
  * IDT vectors usable for external interrupt sources start at 0x20.
@@ -84,7 +84,7 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-#define UV_BAU_MESSAGE			0xf5
+/* 0xf5 - unused, was UV_BAU_MESSAGE */
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
