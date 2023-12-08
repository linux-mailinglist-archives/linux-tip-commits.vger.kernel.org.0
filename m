Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4C780AC95
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAAC2815E3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE17481A0;
	Fri,  8 Dec 2023 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FRlEOOu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tBNGpYZ"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549910E0;
	Fri,  8 Dec 2023 11:01:05 -0800 (PST)
Date: Fri, 08 Dec 2023 19:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702062063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e0J+xS1mZ0HHT3NUtIj/bIdGlok1FYUU5yuG+3+ws1Y=;
	b=2FRlEOOua6dxLXIWPL2BsQyRzNLgEiDIs0o9g6S6VwVZ5SYUrHdnU751aMAwPyjE6jko0N
	5TlI8H2LnQK88Fk5K7e5q3dP2i8oWZULat7Tn+zbsCk0ZMcd9xeIzxQux0M5FeP/UYbtRt
	XfCcSkpHd4YofnKWxcG95UTxv+4AOCu/B/WxKZgH/qpofqDsBoOXrffJvlWGFrp9wVhx99
	Sh9Hna7UoYQyGPHPdSqUnB8Adnu2y7YMXalCEth7Z0YEpOeUl6Ygh6+LeCDwFPR6D9Y/e2
	u/O0FYTZ4cn0+dW4Crt7rKLL2L2ag59k0k416J+o1y0Z50B2JuxpijJOwLURVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702062063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e0J+xS1mZ0HHT3NUtIj/bIdGlok1FYUU5yuG+3+ws1Y=;
	b=1tBNGpYZOfQeB3He5ncNiW468Fdaj/DB1IuvnBex6JRBIaPSoV4u8T0qCWfq5EGLZPrUxr
	WF2ldbPpFomeAJDg==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/tdx] x86/virt/tdx: Disable TDX host support when kexec is enabled
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170206206183.398.10384727190560172183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     1363d55c108dfb6280f55a7f5b149017879fe23b
Gitweb:        https://git.kernel.org/tip/1363d55c108dfb6280f55a7f5b149017879fe23b
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:17:32 -08:00

x86/virt/tdx: Disable TDX host support when kexec is enabled

TDX host support currently lacks the ability to handle kexec.  Disable TDX
when kexec is enabled.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-20-dave.hansen%40intel.com
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e255d8a..01cdb16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1973,6 +1973,7 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
+	depends on !KEXEC_CORE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX

