Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300B7264261
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgIJJg5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 05:36:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgIJJWU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:20 -0400
Date:   Thu, 10 Sep 2020 09:22:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLZVk4wwmDK99pv2MFEB0N0/z+YYV00n6FSRFFtgyps=;
        b=L11mjZoXBQHjrK/7txrrHQnYdoKHzbGt+oIrxwGqVU75oPcBiogid1VQUK3auQ5eLaE2VE
        DOH7uk72zUtZaK8Z8jq0RF3TCgAzZwjIVewkZ/nB2aynQFjI1hjrX80qG/SMmqRH4/zoKw
        ZoaGrD3sQA9nPVfer6quhKqAomxxIzo/jP1+oq3rSOMSGGGRM+tSN+YLQ97FmpaI/p0W2a
        DjesiOp3b5PUF3ZpL+k1LyYuYSsWAscNm8lQvnFMJdeNTw4g1w4/RSAsW6O/TjdTT8oY2J
        v+2xvy/E9XxzBfh/a7ZKWWQEXxHMFnjxHlGqXXP5BWQaNlBUCnkszdreEl8wHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLZVk4wwmDK99pv2MFEB0N0/z+YYV00n6FSRFFtgyps=;
        b=RnnE/Yh3qB3BYYu4KvKAE8+/Qo1uYBjEeCoxB6FIRpJpo/b5S7rzNiTZptbwIUQ7ggMdc4
        +aChz+ojobkTqpCg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/idt: Make IDT init functions static inlines
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-35-joro@8bytes.org>
References: <20200907131613.12703-35-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973819.20229.11540788227149046823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     097ee5b778b8970e1c2ed3ca1631b297d90acd61
Gitweb:        https://git.kernel.org/tip/097ee5b778b8970e1c2ed3ca1631b297d90acd61
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 22:44:43 +02:00

x86/idt: Make IDT init functions static inlines

Move these two functions from kernel/idt.c to include/asm/desc.h:

	* init_idt_data()
	* idt_init_desc()

These functions are needed to setup IDT entries very early and need to
be called from head64.c. To be usable this early, these functions need
to be compiled without instrumentation and the stack-protector feature.

These features need to be kept enabled for kernel/idt.c, so head64.c
must use its own versions.

 [ bp: Take Kees' suggested patch title and add his Rev-by. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-35-joro@8bytes.org
---
 arch/x86/include/asm/desc.h      | 27 +++++++++++++++++++++++++-
 arch/x86/include/asm/desc_defs.h |  7 ++++++-
 arch/x86/kernel/idt.c            | 34 +-------------------------------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 1ced11d..476082a 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -383,6 +383,33 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 
 void alloc_intr_gate(unsigned int n, const void *addr);
 
+static inline void init_idt_data(struct idt_data *data, unsigned int n,
+				 const void *addr)
+{
+	BUG_ON(n > 0xFF);
+
+	memset(data, 0, sizeof(*data));
+	data->vector	= n;
+	data->addr	= addr;
+	data->segment	= __KERNEL_CS;
+	data->bits.type	= GATE_INTERRUPT;
+	data->bits.p	= 1;
+}
+
+static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
+{
+	unsigned long addr = (unsigned long) d->addr;
+
+	gate->offset_low	= (u16) addr;
+	gate->segment		= (u16) d->segment;
+	gate->bits		= d->bits;
+	gate->offset_middle	= (u16) (addr >> 16);
+#ifdef CONFIG_X86_64
+	gate->offset_high	= (u32) (addr >> 32);
+	gate->reserved		= 0;
+#endif
+}
+
 extern unsigned long system_vectors[];
 
 extern void load_current_idt(void);
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 5621fb3..f7e7099 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -74,6 +74,13 @@ struct idt_bits {
 			p	: 1;
 } __attribute__((packed));
 
+struct idt_data {
+	unsigned int	vector;
+	unsigned int	segment;
+	struct idt_bits	bits;
+	const void	*addr;
+};
+
 struct gate_struct {
 	u16		offset_low;
 	u16		segment;
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 53946c1..4bb4e3d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -11,13 +11,6 @@
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
 
-struct idt_data {
-	unsigned int	vector;
-	unsigned int	segment;
-	struct idt_bits	bits;
-	const void	*addr;
-};
-
 #define DPL0		0x0
 #define DPL3		0x3
 
@@ -178,20 +171,6 @@ bool idt_is_f00f_address(unsigned long address)
 }
 #endif
 
-static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
-{
-	unsigned long addr = (unsigned long) d->addr;
-
-	gate->offset_low	= (u16) addr;
-	gate->segment		= (u16) d->segment;
-	gate->bits		= d->bits;
-	gate->offset_middle	= (u16) (addr >> 16);
-#ifdef CONFIG_X86_64
-	gate->offset_high	= (u32) (addr >> 32);
-	gate->reserved		= 0;
-#endif
-}
-
 static __init void
 idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sys)
 {
@@ -205,19 +184,6 @@ idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sy
 	}
 }
 
-static void init_idt_data(struct idt_data *data, unsigned int n,
-			  const void *addr)
-{
-	BUG_ON(n > 0xFF);
-
-	memset(data, 0, sizeof(*data));
-	data->vector	= n;
-	data->addr	= addr;
-	data->segment	= __KERNEL_CS;
-	data->bits.type	= GATE_INTERRUPT;
-	data->bits.p	= 1;
-}
-
 static __init void set_intr_gate(unsigned int n, const void *addr)
 {
 	struct idt_data data;
