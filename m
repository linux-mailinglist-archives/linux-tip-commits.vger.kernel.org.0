Return-Path: <linux-tip-commits+bounces-7587-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69492CA0AC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99C6E300F1B3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D63101BC;
	Wed,  3 Dec 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tg4UcVIW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8903FR/C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A92FB0B4;
	Wed,  3 Dec 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784222; cv=none; b=pB36Sx8JuyVRtc0uhHOlqCS6A3xp4lOs91m21SQGcfMIToxXoddi0mWQGilvNdcJj0Lcfk/N3iGDRc47g6S7GbtihZP9/KtHnc7hPyDipr2pOe+eUn+0xVy3zSo0cxrxQcucyjp9w9TfC9y+DOARvXrB4WD47nDVIrwBoglMIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784222; c=relaxed/simple;
	bh=T6lCsIRZEwUomME5QVhrhiJHWEhADe/wNVdi51b4T0I=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fM25vxbsCoosqE6uiOWTBwAHBir6LWDRxlfjJRC16tRS7lk3eTAUEUzpJBNzVDqJLZfLy82G20dbi/mGyavcinuVd6c5wmbzVdofOvwwvLFmgPPXpI5AivwitEywVbXDH0OfwgPeHNOZAwQABGzKspabJ0F4ZAf1Hbvt8fpGGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tg4UcVIW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8903FR/C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 17:50:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764784217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=saAop5RS6KZmsoktxd4GU1NJsDoFfmlxEvuEAkQqtZE=;
	b=Tg4UcVIWL7+v3CkEz61brUnT7XKcpVlg5VnNDGTnHtHTY6uMZ1fuTMSSlgWEmBcQOnFdiF
	bYJNdWTbyR2E7mxOaUY847sSrQq5zjSOjmYscRUcaCMdnB/TiiWol2x0Uco//86hprd0Gv
	CsvuGeGCQvmcxg/APJ22cl2ThdxezMHfgtSnP1ezmRbUo0BYqizTsOWX2VudTiGAHDrMr3
	XhvGP9Is1mXI2tIDfnftPTCSI7iuVyqFTv6YaMUORsBQxSL8PVYd3j+oBls44mwFvnjcRh
	9zcBmJTfk/bErOC7wlBai5TmO8ds/0iMG5/YXhDuwBpBf5e4ELlwTkDqY46OsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764784217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=saAop5RS6KZmsoktxd4GU1NJsDoFfmlxEvuEAkQqtZE=;
	b=8903FR/CbOBKhMGpVwQwgXLZZHMVW9Y0+UPwsdc2b3nH470E/cJMy9X3ail5Dp4dcdbPaE
	xUIcFvMEskwOncAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/boot/Documentation: Prefix hexadecimal literals with 0x
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478421534.498.1718811169860557062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1c3377bee2127f98f16705376a36326c98113d1c
Gitweb:        https://git.kernel.org/tip/1c3377bee2127f98f16705376a36326c981=
13d1c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 18:29:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 18:49:09 +01:00

x86/boot/Documentation: Prefix hexadecimal literals with 0x

The x86 bootloader ID specification text uses hexadecimal
values without a 0x prefix:

        D  kexec-tools
        E  Extended (see ext_loader_type)
        F  Special (0xFF =3D undefined)
        10 Reserved
        11 Minimal Linux Bootloader
           <http://sebastian-plotz.blogspot.de>
        12 OVMF UEFI virtualization stack
        13 barebox

Which beyond the ambiguity of '13' in isolation, also
made me fail a grep -wi '0xd' when I was looking for
the kexec bootloader ID definition and caused quite
a bit of head-scratching before I found out why it
didn't show up.

Furthermore, the actual explanatory text uses the 0x
prefix:

  For boot loader IDs above T =3D 0xD, write T =3D 0xE to this field and
  write the extended ID minus 0x10 to the ext_loader_type field.
  Similarly, the ext_loader_ver field can be used to provide more than
  four bits for the bootloader version.

So make it all both unambiguous, easy to grep and consistent
across the entire documentation by prefixing the IDs with 0x.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
---
 Documentation/arch/x86/boot.rst | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index b0f648b..42f50fa 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -431,31 +431,31 @@ Protocol:	2.00+
    ext_loader_type <- 0x05
    ext_loader_ver  <- 0x23
=20
-  Assigned boot loader IDs (hexadecimal):
+  Assigned boot loader IDs:
=20
 	=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	0  LILO
-	   (0x00 reserved for pre-2.00 bootloader)
-	1  Loadlin
-	2  bootsect-loader
-	   (0x20, all other values reserved)
-	3  Syslinux
-	4  Etherboot/gPXE/iPXE
-	5  ELILO
-	7  GRUB
-	8  U-Boot
-	9  Xen
-	A  Gujin
-	B  Qemu
-	C  Arcturus Networks uCbootloader
-	D  kexec-tools
-	E  Extended (see ext_loader_type)
-	F  Special (0xFF =3D undefined)
-	10 Reserved
-	11 Minimal Linux Bootloader
-	   <http://sebastian-plotz.blogspot.de>
-	12 OVMF UEFI virtualization stack
-	13 barebox
+	0x0  LILO
+	     (0x00 reserved for pre-2.00 bootloader)
+	0x1  Loadlin
+	0x2  bootsect-loader
+	     (0x20, all other values reserved)
+	0x3  Syslinux
+	0x4  Etherboot/gPXE/iPXE
+	0x5  ELILO
+	0x7  GRUB
+	0x8  U-Boot
+	0x9  Xen
+	0xA  Gujin
+	0xB  Qemu
+	0xC  Arcturus Networks uCbootloader
+	0xD  kexec-tools
+	0xE  Extended (see ext_loader_type)
+	0xF  Special (0xFF =3D undefined)
+	0x10 Reserved
+	0x11 Minimal Linux Bootloader
+	     <http://sebastian-plotz.blogspot.de>
+	0x12 OVMF UEFI virtualization stack
+	0x13 barebox
 	=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
   Please contact <hpa@zytor.com> if you need a bootloader ID value assigned.

