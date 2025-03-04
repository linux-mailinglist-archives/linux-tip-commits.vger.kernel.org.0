Return-Path: <linux-tip-commits+bounces-3899-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA9A4DA79
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B21616773C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D6202961;
	Tue,  4 Mar 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDYlncXI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxVTQVCG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A48201036;
	Tue,  4 Mar 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083983; cv=none; b=h2PczS3P1xKbifTGyqaTB8SARFuPWUWl7pBXYdN8AOSfyayGEMun883QMbVYm+YbOqW+snfg9kjjYY+6DQLP0s0TLD8IcA+9Tuxic8nvV4OFyL7VhplJfz9FtFdI5fsLVNVIuWr+NLSlhFfd4Ar4hJPEfP0QNOniQJiZVDDTtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083983; c=relaxed/simple;
	bh=8wiJ6CNkWvfsfezUPmZrdEVp7bJt7XnRWsP8mATapc0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kywp6FfJv2ThjI0ij7kvJlUFooBVlQFlQtERMDu3n8++qTs+yhv/cVzN1upGTHK+yMU0dZmUCR1ceDnP4mJ2QK4ZqcgjkFi6Td2rRcni2LGBumoqvHtJWzuv1IopduXJzovHPSOupQLBMDfl0JyXPy6cH48s6tAKX45lCRSdv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDYlncXI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxVTQVCG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nvm8HZuDtBkPz1Uou5ov4b6M64loqI04v+ld9z8e6qc=;
	b=qDYlncXIq2Fg9Hv7MdQD4HdR5MO+ohdgMpvYugYktJ1sADIpYT6g48h0Rl7maiCSQNDRpy
	d0AStg77oRbsFetGvWjQJYjfWNqzZZAEjoTOTHPGPIqMuNI9njN0kLMkHINWn+dltHuXMf
	XxVE8eDFQbAxFukmO+lvBwzICm3lt8vZwk1GfVZuIZ0k6L/dGfdHxhCuF+11vDGyacFlH2
	lvUmGFZ27J71rstCh9HvColFkU/xWpZWmUMqI7tDsXtNhBeMvUFF79OPImlIoO1ReZddY7
	0379jKqOrj8BBn2h1+ofOcw3ugYVJlI1DeJBJyOyjOTZqBJMIHdptJ3ziqO61A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nvm8HZuDtBkPz1Uou5ov4b6M64loqI04v+ld9z8e6qc=;
	b=ZxVTQVCGdTtHmv8l74x7uo5mN9rmD3XT9BWJGm11JJ9xUp1k/pIw0UeQe7IfX/Y7PRgORU
	/5Dje+6UesJkrjBQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Remove unnecessary headers and reorder the rest
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-6-darwi@linutronix.de>
References: <20250304085152.51092-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108398021.14745.15801075088288394260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     dec7fdc0b79c2ae0a537343b17f5ba1c6c47e1ca
Gitweb:        https://git.kernel.org/tip/dec7fdc0b79c2ae0a537343b17f5ba1c6c47e1ca
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:17:33 +01:00

x86/cpu: Remove unnecessary headers and reorder the rest

Remove the headers at intel.c that are no longer required.

Alphabetically reorder what remains since more headers will be included
in further commits.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-6-darwi@linutronix.de
---
 arch/x86/kernel/cpu/intel.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c5d833f..60b58b1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1,40 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/pgtable.h>
 
-#include <linux/string.h>
 #include <linux/bitops.h>
-#include <linux/smp.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
-#include <linux/thread_info.h>
 #include <linux/init.h>
-#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+
+#ifdef CONFIG_X86_64
+#include <linux/topology.h>
+#endif
 
-#include <asm/cpufeature.h>
-#include <asm/msr.h>
 #include <asm/bugs.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
-#include <asm/hwcap2.h>
-#include <asm/elf.h>
-#include <asm/cpu_device_id.h>
-#include <asm/resctrl.h>
+#include <asm/msr.h>
 #include <asm/numa.h>
+#include <asm/resctrl.h>
 #include <asm/thermal.h>
-
-#ifdef CONFIG_X86_64
-#include <linux/topology.h>
-#endif
+#include <asm/uaccess.h>
 
 #include "cpu.h"
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/mpspec.h>
-#include <asm/apic.h>
-#endif
-
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists

