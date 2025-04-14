Return-Path: <linux-tip-commits+bounces-4971-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6FA879FA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD07816DB0F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C025A350;
	Mon, 14 Apr 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JBEkk8Eg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RWUi+rNH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE3259C84;
	Mon, 14 Apr 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618516; cv=none; b=HIkgJGkxmCM5KGwVkP4Mj/JAvQA2zD5W7jOxqE4nWsAAkUtMYepSZ+g7/7hFFa7b1VgIuX8bmw5/ROWKVjHS+PkJTn8FBsMaapY6soqstu7oo4cHCbppgr86ppcF17Fl0pKXycNrp6m5OpgJw5JihgUQAmE6eY3+WV82FKyHIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618516; c=relaxed/simple;
	bh=eQp2O3OSyqSSbrYrUfrMyaiEkqlEhuFn7CnRjsoubTw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vBPhLru0n3d3FvekvjUrn6BJSHzXiEzWICNyfN5rVCYzxfzyVf99tt1zzggslLaCubetdO7G29CWTIqHB8cmBdtKsXHI7K2f6/vPciIZ153/bTuDyevikTjW/VEsLapqXGYMTQ7Bk7onhXmCQ0lhEbdK8hIOvS8BVK6SMFWau7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JBEkk8Eg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RWUi+rNH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 08:15:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744618512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H2UmwpNMbN/f+VrHthvIkTz6huz66qG1tUj6QfpmJ4=;
	b=JBEkk8Eg0Cw0Km1GHq9oh3qMCk8SO5h94ZsAT+0y/5Mp67Dqvlb/6dUSPRHEyc3BQVtSPs
	8TDTUyB/QunimfZ404/sJzw6DPAnEdHEwcbo5a/QK4PfgQGebWffo2Wv6lARPxIPmB2bMn
	wAMC7/ksCGvQYu/DC3Qczvb9caIv/6JF+1cD0NRLXcpiENpnIj7SAwJMf046oSFbUPMKfE
	yIb9CJJsKikgK+NRPEbec88AJdVe6r8fmRgCHvSLUyne/g2ClLg+b0cucTLhldOocLHEMu
	wrw0GliP4JEbG0NrmicIjktyi66v2gwmSWzVBD5dpdjJPzfQuhboIB9yx81qZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744618512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H2UmwpNMbN/f+VrHthvIkTz6huz66qG1tUj6QfpmJ4=;
	b=RWUi+rNHrXxY7ppEfgnG5XsM/Ct7bkU0BwpzE8XUnC3DS+V8+VFbiYLu51G7j3AtRsInVk
	TEvzGfpi4aMxo4Cw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/platform/amd: Move the <asm/amd_hsmp.h> header
 to <asm/amd/hsmp.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Carlos Bilbao <carlos.bilbao@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mario Limonciello <superm1@kernel.org>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413084144.3746608-5-mingo@kernel.org>
References: <20250413084144.3746608-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461851159.31282.10980738237644163882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     d96c78684166bc0e7997d12d845882cb5824eed3
Gitweb:        https://git.kernel.org/tip/d96c78684166bc0e7997d12d845882cb5824eed3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Apr 2025 10:41:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:34:17 +02:00

x86/platform/amd: Move the <asm/amd_hsmp.h> header to <asm/amd/hsmp.h>

Collect AMD specific platform header files in <asm/amd/*.h>.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Carlos Bilbao <carlos.bilbao@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Link: https://lore.kernel.org/r/20250413084144.3746608-5-mingo@kernel.org
---
 MAINTAINERS                          |  2 +-
 arch/x86/include/asm/amd/hsmp.h      | 16 ++++++++++++++++
 arch/x86/include/asm/amd_hsmp.h      | 16 ----------------
 drivers/platform/x86/amd/hsmp/acpi.c |  2 +-
 drivers/platform/x86/amd/hsmp/hsmp.c |  2 +-
 drivers/platform/x86/amd/hsmp/plat.c |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/include/asm/amd/hsmp.h
 delete mode 100644 arch/x86/include/asm/amd_hsmp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 61b9cc0..d4ea6d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1097,7 +1097,7 @@ R:	Carlos Bilbao <carlos.bilbao@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/arch/x86/amd_hsmp.rst
-F:	arch/x86/include/asm/amd_hsmp.h
+F:	arch/x86/include/asm/amd/hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp/
 
diff --git a/arch/x86/include/asm/amd/hsmp.h b/arch/x86/include/asm/amd/hsmp.h
new file mode 100644
index 0000000..03c2ce3
--- /dev/null
+++ b/arch/x86/include/asm/amd/hsmp.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _ASM_X86_AMD_HSMP_H_
+#define _ASM_X86_AMD_HSMP_H_
+
+#include <uapi/asm/amd_hsmp.h>
+
+#if IS_ENABLED(CONFIG_AMD_HSMP)
+int hsmp_send_message(struct hsmp_message *msg);
+#else
+static inline int hsmp_send_message(struct hsmp_message *msg)
+{
+	return -ENODEV;
+}
+#endif
+#endif /*_ASM_X86_AMD_HSMP_H_*/
diff --git a/arch/x86/include/asm/amd_hsmp.h b/arch/x86/include/asm/amd_hsmp.h
deleted file mode 100644
index 03c2ce3..0000000
--- a/arch/x86/include/asm/amd_hsmp.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-
-#ifndef _ASM_X86_AMD_HSMP_H_
-#define _ASM_X86_AMD_HSMP_H_
-
-#include <uapi/asm/amd_hsmp.h>
-
-#if IS_ENABLED(CONFIG_AMD_HSMP)
-int hsmp_send_message(struct hsmp_message *msg);
-#else
-static inline int hsmp_send_message(struct hsmp_message *msg)
-{
-	return -ENODEV;
-}
-#endif
-#endif /*_ASM_X86_AMD_HSMP_H_*/
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index c1eccb3..3c7acb9 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -9,7 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/amd_hsmp.h>
+#include <asm/amd/hsmp.h>
 
 #include <linux/acpi.h>
 #include <linux/device.h>
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
index a3ac09a..e262e8a 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp/hsmp.c
@@ -7,7 +7,7 @@
  * This file provides a device implementation for HSMP interface
  */
 
-#include <asm/amd_hsmp.h>
+#include <asm/amd/hsmp.h>
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index b9782a0..0eb73fc 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -9,7 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/amd_hsmp.h>
+#include <asm/amd/hsmp.h>
 
 #include <linux/build_bug.h>
 #include <linux/device.h>

