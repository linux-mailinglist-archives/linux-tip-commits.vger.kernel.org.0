Return-Path: <linux-tip-commits+bounces-4437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE4BA6EACA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE113A66B5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B831F03DC;
	Tue, 25 Mar 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cLwLOv2g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVtYtpAm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8B481CD;
	Tue, 25 Mar 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888780; cv=none; b=t+u7BAsJt+4BwD33qTvZpbyemhVaAkFpWPwjXjRbYX9vCprYbaou/4OmUoz5/UnMj9MJwCm/UFifELUUEWZqGEI8tQYtRx4zPBJA1ORzoT4xYMWl4gN1G3FdPNd0xDYjZuCFzsnzI17YWwfW7dqHN7ws6+cfqMbEd7XtyF/IGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888780; c=relaxed/simple;
	bh=wp9fNM5mk2ZCc8TFSncqqjqDQjIj9wbm3OFVHroF+JU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fxECYUpQPPi3EywQyCKRnexYlgfPt9CmlT6T2eshrOwIN+wOTS/FWpZk+54S5q5m5/Iiusd4Cu6GXEL5u8heNtzdFtc0fU/A1XvXVD/BA/z1LMNHzteWHe48LSmsLDGYBIhoZPigRTaUc/QljfaB2pSiHtILEYv+ugkCFZE7jWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cLwLOv2g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVtYtpAm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:46:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8nQuRcM8hk2wGH2BdHT4ACYB3UjnDpKCMKrjHUWD64=;
	b=cLwLOv2grco75lEnAsk1y3KKP+UDKihVPAm3vFX7uKMrgiZIBRm0QYrMDqh/wX6f3ObATs
	3y6xIOnVPT09adGnlbdTzQU+WJL81SPwoNBLo9vRzXlyRvXNXxoGleGKHF/tEsn+0ThlBg
	yFGV2EDgEryyj0A6eoMQrt+J7RpX/QnTv0hG/d9RmY5NCUrCiR+PUTjDZWOlNeWfac6dMc
	K0daRsVNBO2QSu2Blt8rj0ETiSwjJjC634zn5YUxAkVwDlyFIH2rlv8hoBrD9Qi64Yfj+f
	BvORJA9AUvXizKnYt0r7D6mR5gq3yn3K61oNyGBtvkhhAJe9Hq3RtZB3qL7sxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8nQuRcM8hk2wGH2BdHT4ACYB3UjnDpKCMKrjHUWD64=;
	b=pVtYtpAmi6hWbD93nyXl1JSixRcNaw1KXws7/Q4syuYUWbinVez5XGDkdIKaM/DeQn76Jh
	uE7SfUlaTukaWcCw==
From: "tip-bot2 for Denis Mukhin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/early_printk: Add support for MMIO-based UARTs
Cc: Denis Mukhin <dmukhin@ford.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250324-earlyprintk-v3-1-aee7421dc469@ford.com>
References: <20250324-earlyprintk-v3-1-aee7421dc469@ford.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288877495.14745.1592572192736640657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3181424aeac2f6596534bf43021a10eae294a9b0
Gitweb:        https://git.kernel.org/tip/3181424aeac2f6596534bf43021a10eae294a9b0
Author:        Denis Mukhin <dmukhin@ford.com>
AuthorDate:    Mon, 24 Mar 2025 17:55:40 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:35:38 +01:00

x86/early_printk: Add support for MMIO-based UARTs

During the bring-up of an x86 board, the kernel was crashing before
reaching the platform's console driver because of a bug in the firmware,
leaving no trace of the boot progress.

The only available method to debug the kernel boot process was via the
platform's MMIO-based UART, as the board lacked an I/O port-based UART,
PCI UART, or functional video output.

Then it turned out that earlyprintk= does not have a knob to configure
the MMIO-mapped UART.

Extend the early printk facility to support platform MMIO-based UARTs
on x86 systems, enabling debugging during the system bring-up phase.

The command line syntax to enable platform MMIO-based UART is:

  earlyprintk=mmio,membase[,{nocfg|baudrate}][,keep]

Note, the change does not integrate MMIO-based UART support to:

  arch/x86/boot/early_serial_console.c

Also, update kernel parameters documentation with the new syntax and
add the missing 'nocfg' setting to the PCI serial cards description.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250324-earlyprintk-v3-1-aee7421dc469@ford.com
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++-
 arch/x86/kernel/early_printk.c                  | 45 +++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 866427d..649261e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1407,14 +1407,21 @@
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
-			earlyprintk=pciserial[,force],bus:device.function[,baudrate]
+			earlyprintk=pciserial[,force],bus:device.function[,{nocfg|baudrate}]
 			earlyprintk=xdbc[xhciController#]
 			earlyprintk=bios
+			earlyprintk=mmio,membase[,{nocfg|baudrate}]
 
 			earlyprintk is useful when the kernel crashes before
 			the normal console is initialized. It is not enabled by
 			default because it has some cosmetic problems.
 
+			Only 32-bit memory addresses are supported for "mmio"
+			and "pciserial" devices.
+
+			Use "nocfg" to skip UART configuration, assume
+			BIOS/firmware has configured UART correctly.
+
 			Append ",keep" to not disable it when the real console
 			takes over.
 
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index fc1714b..611f27e 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -190,7 +190,6 @@ static __init void early_serial_init(char *s)
 	early_serial_hw_init(divisor);
 }
 
-#ifdef CONFIG_PCI
 static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
@@ -208,6 +207,45 @@ static __noendbr unsigned int mem32_serial_in(unsigned long addr, int offset)
 ANNOTATE_NOENDBR_SYM(mem32_serial_in);
 
 /*
+ * early_mmio_serial_init() - Initialize MMIO-based early serial console.
+ * @s: MMIO-based serial specification.
+ */
+static __init void early_mmio_serial_init(char *s)
+{
+	unsigned long baudrate;
+	unsigned long membase;
+	char *e;
+
+	if (*s == ',')
+		s++;
+
+	if (!strncmp(s, "0x", 2)) {
+		/* NB: only 32-bit addresses are supported. */
+		membase = simple_strtoul(s, &e, 16);
+		early_serial_base = (unsigned long)early_ioremap(membase, PAGE_SIZE);
+
+		static_call_update(serial_in, mem32_serial_in);
+		static_call_update(serial_out, mem32_serial_out);
+
+		s += strcspn(s, ",");
+		if (*s == ',')
+			s++;
+	}
+
+	if (!strncmp(s, "nocfg", 5)) {
+		baudrate = 0;
+	} else {
+		baudrate = simple_strtoul(s, &e, 0);
+		if (baudrate == 0 || s == e)
+			baudrate = DEFAULT_BAUD;
+	}
+
+	if (baudrate)
+		early_serial_hw_init(115200 / baudrate);
+}
+
+#ifdef CONFIG_PCI
+/*
  * early_pci_serial_init()
  *
  * This function is invoked when the early_printk param starts with "pciserial"
@@ -351,6 +389,11 @@ static int __init setup_early_printk(char *buf)
 	keep = (strstr(buf, "keep") != NULL);
 
 	while (*buf != '\0') {
+		if (!strncmp(buf, "mmio", 4)) {
+			early_mmio_serial_init(buf + 4);
+			early_console_register(&early_serial_console, keep);
+			buf += 4;
+		}
 		if (!strncmp(buf, "serial", 6)) {
 			buf += 6;
 			early_serial_init(buf);

