Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5390029EBA4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgJ2MRO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgJ2MPl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:41 -0400
Date:   Thu, 29 Oct 2020 12:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hc40ispx/wst4VTMuXZa/8Owd/IfnjskH5xNMVoRWRk=;
        b=UBbN08KOKwG5qGtC7V/ZkPAZHbzNhLM7lh8CVa/T82Nre57rp0QocM0NL8rvm1Yz9SyIxi
        llMh0gRo3GhOvSa6r1pTkg6rI340hsZKjwMScQ5pIXNKbFRyIBzxe1KLs0NhRhl1k3r8bA
        FEell1bA61AhE4fkfDWpyHMfAHAY/I42OqVd6W++X7qzPwshCfhV9y6349e+V6jaiMVTuR
        lvaLOCdJWoChZg0zRj2298gUhoXdu+N+jR3GI0jb0uwRGkq4DJy6SVILZX1t3z66M0nGvR
        //Zu9ZQE2h6sq0Wx4y7s/csL+3ia2qpUcMVYp4q7GLpzmvD/3z3qLcW5NOK61g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hc40ispx/wst4VTMuXZa/8Owd/IfnjskH5xNMVoRWRk=;
        b=qUAbEMsR2xjrpEbhDQVVpXNIQ67ZcYJY8cZKpIN4mdl2bs8bYT3QYzQnnbR/rbxvEiL/dZ
        FkxHWMs4FqldRGAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/msi: Remove msidef.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-19-dwmw2@infradead.org>
References: <20201024213535.443185-19-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373876.397.9177258571780664807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     0c1883c1eb9dfa3c72af6e00425eeb1eb171a03e
Gitweb:        https://git.kernel.org/tip/0c1883c1eb9dfa3c72af6e00425eeb1eb171a03e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00

x86/msi: Remove msidef.h

Nothing uses the macro maze anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-19-dwmw2@infradead.org

---
 arch/x86/include/asm/msidef.h | 57 +----------------------------------
 1 file changed, 57 deletions(-)
 delete mode 100644 arch/x86/include/asm/msidef.h

diff --git a/arch/x86/include/asm/msidef.h b/arch/x86/include/asm/msidef.h
deleted file mode 100644
index ee2f8cc..0000000
--- a/arch/x86/include/asm/msidef.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MSIDEF_H
-#define _ASM_X86_MSIDEF_H
-
-/*
- * Constants for Intel APIC based MSI messages.
- */
-
-/*
- * Shifts for MSI data
- */
-
-#define MSI_DATA_VECTOR_SHIFT		0
-#define  MSI_DATA_VECTOR_MASK		0x000000ff
-#define	 MSI_DATA_VECTOR(v)		(((v) << MSI_DATA_VECTOR_SHIFT) & \
-					 MSI_DATA_VECTOR_MASK)
-
-#define MSI_DATA_DELIVERY_MODE_SHIFT	8
-#define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
-#define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
-
-#define MSI_DATA_LEVEL_SHIFT		14
-#define	 MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
-#define	 MSI_DATA_LEVEL_ASSERT		(1 << MSI_DATA_LEVEL_SHIFT)
-
-#define MSI_DATA_TRIGGER_SHIFT		15
-#define  MSI_DATA_TRIGGER_EDGE		(0 << MSI_DATA_TRIGGER_SHIFT)
-#define  MSI_DATA_TRIGGER_LEVEL		(1 << MSI_DATA_TRIGGER_SHIFT)
-
-/*
- * Shift/mask fields for msi address
- */
-
-#define MSI_ADDR_BASE_HI		0
-#define MSI_ADDR_BASE_LO		0xfee00000
-
-#define MSI_ADDR_DEST_MODE_SHIFT	2
-#define  MSI_ADDR_DEST_MODE_PHYSICAL	(0 << MSI_ADDR_DEST_MODE_SHIFT)
-#define	 MSI_ADDR_DEST_MODE_LOGICAL	(1 << MSI_ADDR_DEST_MODE_SHIFT)
-
-#define MSI_ADDR_REDIRECTION_SHIFT	3
-#define  MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
-					/* dedicated cpu */
-#define  MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
-					/* lowest priority */
-
-#define MSI_ADDR_DEST_ID_SHIFT		12
-#define	 MSI_ADDR_DEST_ID_MASK		0x00ffff0
-#define  MSI_ADDR_DEST_ID(dest)		(((dest) << MSI_ADDR_DEST_ID_SHIFT) & \
-					 MSI_ADDR_DEST_ID_MASK)
-#define MSI_ADDR_EXT_DEST_ID(dest)	((dest) & 0xffffff00)
-
-#define MSI_ADDR_IR_EXT_INT		(1 << 4)
-#define MSI_ADDR_IR_SHV			(1 << 3)
-#define MSI_ADDR_IR_INDEX1(index)	((index & 0x8000) >> 13)
-#define MSI_ADDR_IR_INDEX2(index)	((index & 0x7fff) << 5)
-#endif /* _ASM_X86_MSIDEF_H */
