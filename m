Return-Path: <linux-tip-commits+bounces-7665-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4651CBB7F6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E45530010DA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30529D27A;
	Sun, 14 Dec 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qn+RaGSb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjpnwQxC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B92772D;
	Sun, 14 Dec 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701442; cv=none; b=pEpZWIe4hdQUZzMDihTttXm0lyR7CHQuBrAN0uWmzhrrQvAkyXp+0fhXhncx/ku1xqRo4zyBhDwg0lq9WozM5ig258KcCDTUhlnOsuTASW2Vj/0PoENmkk2vpVzkzHTxZxUwKIUxqZ2gL/gXc+JMff+Aj55DoBGNyJf6Py8P0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701442; c=relaxed/simple;
	bh=qZHH7+EXzbhBh6ObGZ+SfHn/p5J6koj0tnVCjkA3MkQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QdL3UJSBqdJqvM3TG39o1PmL/eYqFcJPJ4rRgfO56ZpYaiw9qpH9RsIe52DJc2666wszqGFJix5l0hTMyBT15x9rMAUgh7Yq9Mbgma7jalrlXulA298ZcgXUD2Mn+QKfDwJ9+eL6pqzyQ5WFP+y07Ysw7XZjl0O6ZwmAU50BVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qn+RaGSb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjpnwQxC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcF84LKqTRVAh7FtGuAc2xkqz8erKdW5usziD/drwKg=;
	b=qn+RaGSbd14E85/D6PRnQA+QF5reZ8vrY1JwwN+CA4/t4WfKftyyxy6PK/zotYebeX7ImB
	5TQCc7RXfFXBGRFT0dANFFlyojZ3jcd7Qv5btQKTPuKNUZ6Ho7eztKbp5Ez9yWamub3nsl
	PgII4xEuLgWK+jPbh2FlIozhFr/RzmyDY6MButtH5g62wHy4p9GV78lhZxZDCfrAegRdhH
	/c2YZ+I2Iee8208kRbvYfqIyi9FbIbD8dtrkd1Tp+PIJw5WGwZ/S8gbgTton5HTxf7uaaW
	NuYOUAy0n9YSyAakn+wQ3yRpN3uHj5IIzTPOAxKl5qgboKuCT11Fuv1vcma3Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcF84LKqTRVAh7FtGuAc2xkqz8erKdW5usziD/drwKg=;
	b=bjpnwQxC9JtHSedvJwb0ZE20uPHaAZXij3zhWNSboaGEELeBKmBlH8SZyvYoXvWU+YEHTh
	Giy6px+W97ndVcAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Use <linux/sizes.h> symbols for literals
Cc: Nikolay Borisov <nik.borisov@suse.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <92a15c2d-055c-4f4e-b232-32030a8e5e54@suse.com>
References: <92a15c2d-055c-4f4e-b232-32030a8e5e54@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570143736.498.10979676426058637417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     6c08d768a528ad22016850a481d67bfc8cdb9d4b
Gitweb:        https://git.kernel.org/tip/6c08d768a528ad22016850a481d67bfc8cd=
b9d4b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 14 Dec 2025 09:22:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:24:18 +01:00

x86/boot/e820: Use <linux/sizes.h> symbols for literals

Use the human-readable SZ_* constants.

Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/92a15c2d-055c-4f4e-b232-32030a8e5e54@suse.com
---
 arch/x86/kernel/e820.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index d1b1786..97b54bd 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -617,7 +617,7 @@ __init static void e820__update_table_kexec(void)
 	e820__update_table(e820_table_kexec);
 }
=20
-#define MAX_GAP_END 0x100000000ull
+#define MAX_GAP_END SZ_4G
=20
 /*
  * Search for a gap in the E820 memory space from 0 to MAX_GAP_END (4GB).
@@ -696,7 +696,7 @@ __init void e820__setup_pci_gap(void)
 		pr_err("Cannot find an available gap in the 32-bit address range\n");
 		pr_err("PCI devices with unassigned 32-bit BARs may not work!\n");
 #else
-		max_gap_start =3D 0x10000000;
+		max_gap_start =3D SZ_256M;
 #endif
 	}
=20
@@ -1080,7 +1080,7 @@ __initdata static struct resource *e820_res;
 __init static bool e820_device_region(enum e820_type type, struct resource *=
res)
 {
 	/* This is the legacy BIOS/DOS ROM-shadow + MMIO region: */
-	if (res->start < (1ULL<<20))
+	if (res->start < SZ_1M)
 		return false;
=20
 	/*

