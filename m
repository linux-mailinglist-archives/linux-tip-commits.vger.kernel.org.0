Return-Path: <linux-tip-commits+bounces-3368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA36A36D6E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D18189569C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799D1A5B8B;
	Sat, 15 Feb 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+AmOBm+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZjNCMXzf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395E1A3168;
	Sat, 15 Feb 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617000; cv=none; b=JxT+daEk/73x1KF7yq5PzDC7iAbCksXmEoscDsSd/cnmqijuxJeGLNrlThXhvDzSshtn3c+xkeOjNDQ0zCmjbqeNYWLgRkF5rFqaOOIrqh7nDzM+be4lEGOPv4Z+0ctK9oZjgHDkc+BTsV2HT1tGLMkr59OsQ73ADscdilrg4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617000; c=relaxed/simple;
	bh=iIDOGNcGLoJvc66/45g/yCMkq2atkFudQaSXXdLZzOY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L1lzl4E/6lKp/xS0ayfi1thaVO4pnqFEYD9t/VKko+IGBdo89kCM7UWtY686rFamFGbrzlWnIGo4MEa71UbXu0bf2crNIF4cvcvwh+yQKEIBEnAbasJqyOstmJzd+xlx6DSBNCMZcNj6dYZiD5gVRHF8UBBZ0GgHfOz9HhDeWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+AmOBm+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZjNCMXzf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hM6mQEM2DquiCXn3DFjKV52LFKc/MnW+V8Ac2kU8+M=;
	b=g+AmOBm+3N1NGKcT7JHn63D69n6UkM4Wj0SkK0mpqaCRAG1mMae7GQxiPn7KUeUqCbs1SA
	gtc4dPB8XidK+VmoaWgDOYBwx+8ccpGj5mZjk5SP+DW9kOO4FvTlua58CpkIV3tx2/LQAp
	3F0CzFCGMRv32EDO/fsjCfCa+wO6Enqcep40qXI2A+xjj+Twb/9RfqnNca/mj66oxqeFuT
	7jZEozBcy1PvA1T3B+kmJ6z1YP0OqVTyeDUCtiNtMSNyF/OvHnMG9QpeQX/lGdUOkqJ3rQ
	efPFSPghMvFi3moQZQ8QAL8s9Zjn7TOfafgKRCj4heoZvJzUCM3sHrayGRCjfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hM6mQEM2DquiCXn3DFjKV52LFKc/MnW+V8Ac2kU8+M=;
	b=ZjNCMXzfRPSEHhBmHrB1lUnOtVTPbLL0CC9v7cVyrpTbjX05diOfwYOeAcnh/nntmEfGLc
	VNeJQI8y9rm2bDBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/early_printk: Harden early_serial
Cc: Scott Constable <scott.d.constable@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.919773202@infradead.org>
References: <20250207122546.919773202@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699643.10177.2484228241413795642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     306859de59e59f88662b6b56ff2ce3bbb1e375bb
Gitweb:        https://git.kernel.org/tip/306859de59e59f88662b6b56ff2ce3bbb1e375bb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:07 +01:00

x86/early_printk: Harden early_serial

Scott found that mem32_serial_in() is an ideal speculation gadget, an
indirectly callable function that takes an adddress and offset and
immediately does a load.

Use static_call() to take away the need for indirect calls and
explicitly seal the functions to ensure they're not callable on IBT
enabled parts.

Reported-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.919773202@infradead.org
---
 arch/x86/kernel/early_printk.c | 49 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 44f9370..fc1714b 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -19,6 +19,7 @@
 #include <linux/usb/ehci_def.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <asm/pci_x86.h>
+#include <linux/static_call.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -94,26 +95,28 @@ static unsigned long early_serial_base = 0x3f8;  /* ttyS0 */
 #define DLL             0       /*  Divisor Latch Low         */
 #define DLH             1       /*  Divisor latch High        */
 
-static unsigned int io_serial_in(unsigned long addr, int offset)
+static __noendbr unsigned int io_serial_in(unsigned long addr, int offset)
 {
 	return inb(addr + offset);
 }
+ANNOTATE_NOENDBR_SYM(io_serial_in);
 
-static void io_serial_out(unsigned long addr, int offset, int value)
+static __noendbr void io_serial_out(unsigned long addr, int offset, int value)
 {
 	outb(value, addr + offset);
 }
+ANNOTATE_NOENDBR_SYM(io_serial_out);
 
-static unsigned int (*serial_in)(unsigned long addr, int offset) = io_serial_in;
-static void (*serial_out)(unsigned long addr, int offset, int value) = io_serial_out;
+DEFINE_STATIC_CALL(serial_in, io_serial_in);
+DEFINE_STATIC_CALL(serial_out, io_serial_out);
 
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((serial_in(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
+	while ((static_call(serial_in)(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
-	serial_out(early_serial_base, TXR, ch);
+	static_call(serial_out)(early_serial_base, TXR, ch);
 	return timeout ? 0 : -1;
 }
 
@@ -131,16 +134,16 @@ static __init void early_serial_hw_init(unsigned divisor)
 {
 	unsigned char c;
 
-	serial_out(early_serial_base, LCR, 0x3);	/* 8n1 */
-	serial_out(early_serial_base, IER, 0);	/* no interrupt */
-	serial_out(early_serial_base, FCR, 0);	/* no fifo */
-	serial_out(early_serial_base, MCR, 0x3);	/* DTR + RTS */
+	static_call(serial_out)(early_serial_base, LCR, 0x3);	/* 8n1 */
+	static_call(serial_out)(early_serial_base, IER, 0);	/* no interrupt */
+	static_call(serial_out)(early_serial_base, FCR, 0);	/* no fifo */
+	static_call(serial_out)(early_serial_base, MCR, 0x3);	/* DTR + RTS */
 
-	c = serial_in(early_serial_base, LCR);
-	serial_out(early_serial_base, LCR, c | DLAB);
-	serial_out(early_serial_base, DLL, divisor & 0xff);
-	serial_out(early_serial_base, DLH, (divisor >> 8) & 0xff);
-	serial_out(early_serial_base, LCR, c & ~DLAB);
+	c = static_call(serial_in)(early_serial_base, LCR);
+	static_call(serial_out)(early_serial_base, LCR, c | DLAB);
+	static_call(serial_out)(early_serial_base, DLL, divisor & 0xff);
+	static_call(serial_out)(early_serial_base, DLH, (divisor >> 8) & 0xff);
+	static_call(serial_out)(early_serial_base, LCR, c & ~DLAB);
 }
 
 #define DEFAULT_BAUD 9600
@@ -183,28 +186,26 @@ static __init void early_serial_init(char *s)
 	/* Convert from baud to divisor value */
 	divisor = 115200 / baud;
 
-	/* These will always be IO based ports */
-	serial_in = io_serial_in;
-	serial_out = io_serial_out;
-
 	/* Set up the HW */
 	early_serial_hw_init(divisor);
 }
 
 #ifdef CONFIG_PCI
-static void mem32_serial_out(unsigned long addr, int offset, int value)
+static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
 	/* shift implied by pointer type */
 	writel(value, vaddr + offset);
 }
+ANNOTATE_NOENDBR_SYM(mem32_serial_out);
 
-static unsigned int mem32_serial_in(unsigned long addr, int offset)
+static __noendbr unsigned int mem32_serial_in(unsigned long addr, int offset)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
 	/* shift implied by pointer type */
 	return readl(vaddr + offset);
 }
+ANNOTATE_NOENDBR_SYM(mem32_serial_in);
 
 /*
  * early_pci_serial_init()
@@ -278,15 +279,13 @@ static __init void early_pci_serial_init(char *s)
 	 */
 	if ((bar0 & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
 		/* it is IO mapped */
-		serial_in = io_serial_in;
-		serial_out = io_serial_out;
 		early_serial_base = bar0 & PCI_BASE_ADDRESS_IO_MASK;
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_IO);
 	} else {
 		/* It is memory mapped - assume 32-bit alignment */
-		serial_in = mem32_serial_in;
-		serial_out = mem32_serial_out;
+		static_call_update(serial_in, mem32_serial_in);
+		static_call_update(serial_out, mem32_serial_out);
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);

