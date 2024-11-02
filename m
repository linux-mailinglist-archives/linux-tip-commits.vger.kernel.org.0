Return-Path: <linux-tip-commits+bounces-2724-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC59B9F8D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339BB282238
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7418991B;
	Sat,  2 Nov 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ea27lguc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rs1WXm5H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CA166302;
	Sat,  2 Nov 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548217; cv=none; b=SiNCM7HPRsemaIrD1a+xFSn8umfPa/zZjzlbeB+D0x41jv849A8IrVg33cYhuSrGdnc3dlEuLxXa2C8oMht46L882C1Nze1+ZCE1jkQKyHmHj0B1L4Zn84SSpu8k3o96Zdh3VMOq3a6Snv1yhsizRoH5gZYlXw8PLohLIH6XQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548217; c=relaxed/simple;
	bh=1vF3jSafvzuqxksVp8aCZI1s5ifOH+uEW1XVtQJTIrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iJwHGoShs2o+O4172TI3ehFNrJaBEDoHtjv1BnuPt5cdZHeMQwhZfOmxNKcY9YW/6ZbqfAmAn4pe43a3EcimczYkSYHs/WUBEvPVBJ4bkJiM9RM6U+T+P34P6N8jP20HmKHhHEAmSNU44QXqTzenNN9dNhYqOYK2M/yftmvHWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ea27lguc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rs1WXm5H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zmfaCNAyxTxFB4JHomg3ARYmNloSI2RZeWY6EcMVpE=;
	b=ea27lgucFWQlUsC1QA1Z/rapnw43UnMIHDTnEbkt8vc5UqSOHGLZW+Ho8rpf8IzR75EC53
	/H7hxPvIZJHuGr1iKRGhIpQznW5oFgDxftJVCkUSlwfH7FYeBk/D4AedNgr8P3gRvP6Nig
	fmOvY3xyPzH7IqReI3opBCA/IsA8Vi6A/oA1+igZqazHaMGInrWsPGSHCGEExyBmI6we76
	qpPdXWOQrMOXTpFxmWW/mnwM2D7Lby28RFhieED7bxdIvL4mEJqtqcHKoBza1K7wjWwo2z
	LdgknqISSoQUlOXKGQP2l2R56AwI5PMko5fZKTmJYpRCkjud84tin7rE3BkOoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zmfaCNAyxTxFB4JHomg3ARYmNloSI2RZeWY6EcMVpE=;
	b=Rs1WXm5HbZex02JIXs+w1fe8W0DgyqXx3tZ4xcgkATeSpmWJFNMqSPfdeZ5t2wkcZTJhZ9
	ZoyDef8lLj/3DTDg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc: Add kconfig option for the systemcfg page
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-25-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-25-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054821316.3137.7948229817888369712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c22c06b4cc3a7434f36dac9310604be3ebc6f4f9
Gitweb:        https://git.kernel.org/tip/c22c06b4cc3a7434f36dac9310604be3ebc=
6f4f9
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:35 +01:00

powerpc: Add kconfig option for the systemcfg page

The systemcfg page through procfs is only a backwards-compatible
interface for very old applications.
Make it possible to be disabled.

This also creates a convenient config #define to guard any accesses to
the systemcfg page.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-25-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/Kconfig               | 8 ++++++++
 arch/powerpc/kernel/proc_powerpc.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01..5d348e1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1298,6 +1298,14 @@ config MODULES_SIZE
=20
 endmenu
=20
+config PPC64_PROC_SYSTEMCFG
+	def_bool y
+	depends on PPC64 && PROC_FS
+	help
+	  This option enables the presence of /proc/ppc64/systemcfg through
+	  which the systemcfg page can be accessed.
+	  This interface only exists for backwards-compatibility.
+
 if PPC64
 # This value must have zeroes in the bottom 60 bits otherwise lots will break
 config PAGE_OFFSET
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_po=
werpc.c
index 910d208..3bda365 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -14,7 +14,7 @@
 #include <asm/rtas.h>
 #include <linux/uaccess.h>
=20
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
=20
 static loff_t page_map_seek(struct file *file, loff_t off, int whence)
 {
@@ -59,7 +59,7 @@ static int __init proc_ppc64_init(void)
 }
 __initcall(proc_ppc64_init);
=20
-#endif /* CONFIG_PPC64 */
+#endif /* CONFIG_PPC64_PROC_SYSTEMCFG */
=20
 /*
  * Create the ppc64 and ppc64/rtas directories early. This allows us to

