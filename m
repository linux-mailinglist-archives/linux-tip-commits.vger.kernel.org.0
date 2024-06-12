Return-Path: <linux-tip-commits+bounces-1383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9099905CC0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1111C21E85
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134B84E1E;
	Wed, 12 Jun 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oKfJAhn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4PyHnlN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B655C08;
	Wed, 12 Jun 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223867; cv=none; b=Nq4I2HrsA5Cpo0EPRJzvBMPE7fvePREFVu+YEkBi7yClgwEjvp0mxEm5/8YJ9OBz87cZJhfm9Z9/z3bfMFQdJXlEYXcg58jl6MUZJ0jhR4BHZ1imQmtsssi2JIWt/+K32h+Ryv+tp14hpPSBfqiJ9YJOwPjDgTSpH450l3izFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223867; c=relaxed/simple;
	bh=XFv1w4MP/icuRunpNsbZXGMTL0ekm3+wuCm31bs/Reg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ceEYZxLHqedLw2jPRQdhUzI87TX1D3m54s3QJjSwhRX3PYgUOsYO1EJeQTAGzMeZm3bU99OZng693c5b+W0e4BakT0CMJhyf+ck9sgI5fZTVrUxL/Q0TsFC2nbN9KxqX9UCPMNDU0wiKzE1xtRMHKw9oZy+7OiL7BMNoHoZeWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oKfJAhn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4PyHnlN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UnLYSXhK1xnYoFSnlcbaxaS8i5nYimnW5GleY60k+I=;
	b=0oKfJAhnehkl6mD4DqTZQln4d5kdCQcxUnKzSb25bENaXfPOEt2iIQHFe2uHZ+q4B9YPHj
	2lNP/gzrSsrplQI/HoQp6sqAuLUi524dTm1flU8nJQwgWebFj1qaOi/sVHrrdMgmn8uddU
	AH6//WxpD9qE5DjlicjLsPggRCrSTSzqjwgcvgx00q92bgtEG2m+3VsUtcM17KrWskCcy6
	YMNJ51nzGezP2FVuSTFklHuRENar5/mFFGKRS+/9P+YXMRiOf3Solz47G/ng7dFuO9ypl9
	dJKfFK8Cajm3i4kmUJtJnNMow0jaUKvmiBuVktDjbBruGbDSQt84TeetlR1THA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UnLYSXhK1xnYoFSnlcbaxaS8i5nYimnW5GleY60k+I=;
	b=C4PyHnlNt7ihDF6JwcQSMINccrLCsBXM3X5izTljJXrOCM/5duVikr36nNaanwCOm7Vgaf
	G6Qm5WsnnVBtT7CA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Enhance SMN access error checking
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-4-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-4-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386407.10875.16449136725170041056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     dc5243921be1b6a0b4259dbcec3dc95016ad8427
Gitweb:        https://git.kernel.org/tip/dc5243921be1b6a0b4259dbcec3dc95016ad8427
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:12:57 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:38:58 +02:00

x86/amd_nb: Enhance SMN access error checking

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The accesses can fail for a variety of reasons.

Include code comments to describe some possible scenarios.

Require error checking for callers of amd_smn_read() and amd_smn_write().
This is needed because many error conditions cannot be checked by these
functions.

  [ bp: Touchup comment. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-4-ffde21931c3f@amd.com
---
 arch/x86/include/asm/amd_nb.h |  4 +--
 arch/x86/kernel/amd_nb.c      | 44 ++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 5c37944..6f3b6ae 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -21,8 +21,8 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
 
-extern int amd_smn_read(u16 node, u32 address, u32 *value);
-extern int amd_smn_write(u16 node, u32 address, u32 value);
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 027a8c7..059e5c1 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -180,6 +180,43 @@ static struct pci_dev *next_northbridge(struct pci_dev *dev,
 	return dev;
 }
 
+/*
+ * SMN accesses may fail in ways that are difficult to detect here in the called
+ * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
+ * their own checking based on what behavior they expect.
+ *
+ * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
+ * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
+ * can be checked here, and a proper error code can be returned.
+ *
+ * But the Read-as-Zero response cannot be verified here. A value of 0 may be
+ * correct in some cases, so callers must check that this correct is for the
+ * register/fields they need.
+ *
+ * For SMN writes, success can be determined through a "write and read back"
+ * However, this is not robust when done here.
+ *
+ * Possible issues:
+ *
+ * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
+ *    *not* match the write value.
+ *
+ * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
+ *    known here.
+ *
+ * 3) Bits that are "Reserved / Set to 1". Ditto above.
+ *
+ * Callers of amd_smn_write() should do the "write and read back" check
+ * themselves, if needed.
+ *
+ * For #1, they can see if their target bits got cleared.
+ *
+ * For #2 and #3, they can check if their target bits got set as intended.
+ *
+ * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
+ * the operation is considered a success, and the caller does their own
+ * checking.
+ */
 static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
@@ -202,9 +239,6 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	err = (write ? pci_write_config_dword(root, 0x64, *value)
 		     : pci_read_config_dword(root, 0x64, value));
-	if (err)
-		pr_warn("Error %s SMN address 0x%x.\n",
-			(write ? "writing to" : "reading from"), address);
 
 out_unlock:
 	mutex_unlock(&smn_mutex);
@@ -213,7 +247,7 @@ out:
 	return err;
 }
 
-int amd_smn_read(u16 node, u32 address, u32 *value)
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
 	int err = __amd_smn_rw(node, address, value, false);
 
@@ -226,7 +260,7 @@ int amd_smn_read(u16 node, u32 address, u32 *value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
-int amd_smn_write(u16 node, u32 address, u32 value)
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
 	return __amd_smn_rw(node, address, &value, true);
 }

