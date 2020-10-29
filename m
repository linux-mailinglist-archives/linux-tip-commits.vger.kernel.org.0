Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04BE29EB98
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJ2MQv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgJ2MPp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:45 -0400
Date:   Thu, 29 Oct 2020 12:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74Yk/jNvuIQVaRPqa3YdP+wqTKCVAuvjmT2rVxu5/YE=;
        b=AuSZjaPbXBNTrJ57BQuN+9Qe53b4crIxssh78rQLq3D/lV9d68J8zKxtycZdwWiniO0oTx
        SaNGAyC3kezB/RFVzRnJWAlN3S4uwGwfOMgS0dm/OCINXt2g+qN6f/tIRJ7Up21oWtOk8e
        ISGXWUJnpdCtO1dDoBVDhFbHwHB7j4Jzw0iOmwmHahLFIK6XvjpbuU5F0PTFZIj8c9udHy
        0GsxSn4bCUCQvLo1cz541SrjN8TgS/P51pkak8IlAViYwdLWhd4YHCVQPV8qN4iUFJRH8d
        3BfxTBLSj/b4lES+TOeCRoIhwkT6HYSJ6t3vTc+/EjgyXlFb8CMVcAiz9M/tBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74Yk/jNvuIQVaRPqa3YdP+wqTKCVAuvjmT2rVxu5/YE=;
        b=g9UJVPgWBc+Cii0FjBJaK7bj2alqy7nLF9fjljUqo7piML9vuLD7Wpq/Md8TNrxS0PywbR
        McvtzgaLGaSN06Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] genirq/msi: Allow shadow declarations of msi_msg:: $member
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-12-dwmw2@infradead.org>
References: <20201024213535.443185-12-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374326.397.2480674567407403116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8073c1ac82c12aaf1b475a3ce5328d43b3eaa4ae
Gitweb:        https://git.kernel.org/tip/8073c1ac82c12aaf1b475a3ce5328d43b3eaa4ae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:25 +01:00

genirq/msi: Allow shadow declarations of msi_msg:: $member

Architectures like x86 have their MSI messages in various bits of the data,
address_lo and address_hi field. Composing or decomposing these messages
with bitmasks and shifts is possible, but unreadable gunk.

Allow architectures to provide an architecture specific representation for
each member of msi_msg. Provide empty defaults for each and stick them into
an union.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-12-dwmw2@infradead.org

---
 include/asm-generic/msi.h |  4 +++-
 include/linux/msi.h       | 46 ++++++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index e6795f0..25344de 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+
 #ifndef NUM_MSI_ALLOC_SCRATCHPAD_REGS
 # define NUM_MSI_ALLOC_SCRATCHPAD_REGS	2
 #endif
@@ -30,4 +32,6 @@ typedef struct msi_alloc_info {
 
 #define GENERIC_MSI_DOMAIN_OPS		1
 
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+
 #endif
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6b584cc..360a0a7 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -4,11 +4,50 @@
 
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <asm/msi.h>
+
+/* Dummy shadow structures if an architecture does not define them */
+#ifndef arch_msi_msg_addr_lo
+typedef struct arch_msi_msg_addr_lo {
+	u32	address_lo;
+} __attribute__ ((packed)) arch_msi_msg_addr_lo_t;
+#endif
+
+#ifndef arch_msi_msg_addr_hi
+typedef struct arch_msi_msg_addr_hi {
+	u32	address_hi;
+} __attribute__ ((packed)) arch_msi_msg_addr_hi_t;
+#endif
+
+#ifndef arch_msi_msg_data
+typedef struct arch_msi_msg_data {
+	u32	data;
+} __attribute__ ((packed)) arch_msi_msg_data_t;
+#endif
 
+/**
+ * msi_msg - Representation of a MSI message
+ * @address_lo:		Low 32 bits of msi message address
+ * @arch_addrlo:	Architecture specific shadow of @address_lo
+ * @address_hi:		High 32 bits of msi message address
+ *			(only used when device supports it)
+ * @arch_addrhi:	Architecture specific shadow of @address_hi
+ * @data:		MSI message data (usually 16 bits)
+ * @arch_data:		Architecture specific shadow of @data
+ */
 struct msi_msg {
-	u32	address_lo;	/* low 32 bits of msi message address */
-	u32	address_hi;	/* high 32 bits of msi message address */
-	u32	data;		/* 16 bits of msi message data */
+	union {
+		u32			address_lo;
+		arch_msi_msg_addr_lo_t	arch_addr_lo;
+	};
+	union {
+		u32			address_hi;
+		arch_msi_msg_addr_hi_t	arch_addr_hi;
+	};
+	union {
+		u32			data;
+		arch_msi_msg_data_t	arch_data;
+	};
 };
 
 extern int pci_msi_ignore_mask;
@@ -243,7 +282,6 @@ struct msi_controller {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 
 #include <linux/irqhandler.h>
-#include <asm/msi.h>
 
 struct irq_domain;
 struct irq_domain_ops;
