Return-Path: <linux-tip-commits+bounces-8042-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D786BD39000
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Jan 2026 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE6D3009415
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Jan 2026 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3A51EB5E3;
	Sat, 17 Jan 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UlXWSgyn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dcm5VS08"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3227700D;
	Sat, 17 Jan 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669980; cv=none; b=Cge+ETMwnnLSpmK5XEcG4ag4MQt36sGsJL3ORK7Ycn2H5lOZhAcdZQ3p3nBtpIIO3ds7zHwxUcglPa0wgBnyYU/9/g0lgSSVnv+0oz4cB5O0yNeRLr9AIffuQZc77wl09dLfZRBdpfQyr2NFebRh1wFqADv7yA/o62uzrVtJ5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669980; c=relaxed/simple;
	bh=J989AIRvoQPNNdIt/1HT4iLvIa9YNase5NIk05vm2RU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f21/HkBFpIpT2C3ThnqsTDpuxVlkzV940Xi/6oJY+pumIz6SZwd2tE+CYiab42JAhZXESNbhhpZYHgWZ9p7uYYo4V+llrD7KsDRmcCqAfwn+o0xkqXNU+E24my2BsCn02ipBl1CDiF3yY7/6yV6szr690L1F1zgHVo+gqBbEj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UlXWSgyn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dcm5VS08; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 Jan 2026 17:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768669975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ROnl/qBjy3HFt2RZjY4LcguVAoAg3v/H1OOVfyZgrs=;
	b=UlXWSgynb6rYLHqpM0HIFT+Rqw5Z4UCDox9KI7XqKwxvgTk+aanX9D5uRMLx/Vl975GV2s
	7EQ96Re6JLF9o+hrOASPN/xT06VTmUk17McUpaXAWeOartumRWkdkZs5j1fbiKsHkZ5GKM
	HQCNFqTRFwwl6nDF1b/SII/I6tmw8ETI1BlOCH+LBJ1pZ1pYY0JN/uLZVMVXWY8rtbyxKj
	HRx5GSygt7E4aspbcyJH1Iyq54nnIlbjf09uvi5QEk2JvnE6TS+JdaU/VtjzupfQgOIHpL
	GXVfnmAKYikQZCzvx9NiXmLZ6usl1nwAmwOZKP8OgH8beD03Wc0RVEmgcnHLsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768669975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ROnl/qBjy3HFt2RZjY4LcguVAoAg3v/H1OOVfyZgrs=;
	b=Dcm5VS08YhYME/ZnhlR65cOEyYrjSQSN5iK7KtikMsBMvNyUtdzFghajhavJwfHVLiA3cO
	V5q1MWR8a/8FJSAA==
From: "tip-bot2 for Shenghao Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/acpi: Add acpi=spcr to use SPCR-provided default console
Cc: Shenghao Yang <me@shenghaoyang.info>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260117072827.355360-1-me@shenghaoyang.info>
References: <20260117072827.355360-1-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176866997362.510.10737848539349754089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2a11e1479ef07519bfd6b64ee276905ca84cf817
Gitweb:        https://git.kernel.org/tip/2a11e1479ef07519bfd6b64ee276905ca84=
cf817
Author:        Shenghao Yang <me@shenghaoyang.info>
AuthorDate:    Sat, 17 Jan 2026 15:28:27 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 17 Jan 2026 17:43:21 +01:00

x86/acpi: Add acpi=3Dspcr to use SPCR-provided default console

The SPCR provided console on x86 is only available as a boot console when
earlycon is provided on the kernel command line, and will not be present in
/proc/consoles.

While it's possible to retain the boot console with the keep_bootcon
parameter, that leaves the console using the less efficient 8250_early driver.

Users wanting to use the firmware suggested console (to avoid maintaining
unique serial console parameters for different server models in large fleets)
with the conventional driver have to parse the kernel log for the console
parameters and reinsert them.

  [    0.005091] ACPI: SPCR 0x000000007FFB5000 000059 (v04 ALASKA A M I    01=
072009 INTL 20250404)
  [    0.073387] ACPI: SPCR: console: uart,io,0x3f8,115200

In commit

  0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86")=C2=B9

the SPCR console was only added as an option for earlycon but not as an
ordinary console so users don't see console output changes.

So users can opt in to an automatic SPCR console, make ACPI init add it if
acpi=3Dspcr is set.

=C2=B9https://lore.kernel.org/lkml/20180118150951.28964-1-prarit@redhat.com/

  [ bp: Touchups. ]

Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260117072827.355360-1-me@shenghaoyang.info
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/kernel/acpi/boot.c                     | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index a8d0afd..4d2f0bf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -125,6 +125,8 @@ Kernel parameters
 			may result in duplicate corrected error reports.
 			nospcr -- disable console in ACPI SPCR table as
 				default _serial_ console on ARM64
+			spcr -- enable console in ACPI SPCR table as
+				default _serial_ console on x86
 			For ARM64, ONLY "acpi=3Doff", "acpi=3Don", "acpi=3Dforce" or
 			"acpi=3Dnospcr" are available
 			For RISCV64, ONLY "acpi=3Doff", "acpi=3Don" or "acpi=3Dforce"
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d6138b2..a3f2fb1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -48,7 +48,8 @@ EXPORT_SYMBOL(acpi_disabled);
=20
 int acpi_noirq;				/* skip ACPI IRQ initialization */
 static int acpi_nobgrt;			/* skip ACPI BGRT */
-int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
+static int acpi_spcr_add __initdata;	/* add SPCR-provided console */
+int acpi_pci_disabled;			/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
=20
 int acpi_lapic;
@@ -1669,8 +1670,8 @@ int __init acpi_boot_init(void)
 	if (!acpi_noirq)
 		x86_init.pci.init =3D pci_acpi_init;
=20
-	/* Do not enable ACPI SPCR console by default */
-	acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
+	acpi_parse_spcr(earlycon_acpi_spcr_enable, acpi_spcr_add);
+
 	return 0;
 }
=20
@@ -1707,6 +1708,10 @@ static int __init parse_acpi(char *arg)
 	/* "acpi=3Dnocmcff" disables FF mode for corrected errors */
 	else if (strcmp(arg, "nocmcff") =3D=3D 0) {
 		acpi_disable_cmcff =3D 1;
+	}
+	/* "acpi=3Dspcr" adds the SPCR-provided console as a preferred one */
+	else if (strcmp(arg, "spcr") =3D=3D 0) {
+		acpi_spcr_add =3D 1;
 	} else {
 		/* Core will printk when we return error. */
 		return -EINVAL;

