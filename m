Return-Path: <linux-tip-commits+bounces-4430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07853A6EAA1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60588188DDC9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55979254AF2;
	Tue, 25 Mar 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GRimYak";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+T2ma84K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D6253F02;
	Tue, 25 Mar 2025 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888174; cv=none; b=LtdWrbPDcGBISx/O3oKCJ3oDRlHyQpKWuCnT0zc8Mo/y+YizawlCXXA2IqY6XySBmNk/SIIdcvs4ws8Yk4RzY/SLkC1cXXtQQp6b3LUVexnKznSQlSq6WBIjj9B+M6zVuRHt1soZe+KAovEAJ3xU6GDTvjGZlowhjRRAy3bMZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888174; c=relaxed/simple;
	bh=c1M2WwfFg4BcwHdH4MkElkNTFx/Zj2M9lwdTa0I+JZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oOvmgVIK2ssIS8gow/YUmw63zswEH3Ai8CcxCxJdd3rmO1/A2Q42f+gAMSclczMzvXQKiXJ6gm0Yhsgk4xtp0UAN7jA4spMsshh2ZRKIrf9YiWWB/RvRFaCbCOm/TM+w6JRe39KJe2lYyoMhfQptwDwUmzdK9nr6RZ+mDItutfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GRimYak; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+T2ma84K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa5962az/e/BhtTEeDfQpkCWvh1sFwc35PSUiwSW9J0=;
	b=3GRimYakiJrpRkxKQc7jXTwE1lqvU2UStvSMoGDsxJMOqkJ9ofQwKsbRDLySFpCgvPClI8
	Y5FFc0wNHkiELZD9IOGKW5oowcAD+6n+mUNoSfU2ZSLXMyFR3lwkDseUEbpMxeyxu1ulR5
	k0s4bx/il6k/sAJxIZBF2xFNGaDAYYfmwdFPDo/2iqt1TrOWGl3+jLZ4zZSI49I5nkkJax
	/npVNqKyd6oVH24ZzhYyLodlM6Y6HOvaWG08Nd/pgRca5/GX8ZzANl9KVej7jvvUX8N9t3
	csltfyQTlo2M+dDBHvpRTEQnjoYzzgNK54+Yr7NQwbnlgRRPUrp3JC0Ih+pYWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa5962az/e/BhtTEeDfQpkCWvh1sFwc35PSUiwSW9J0=;
	b=+T2ma84KwXHBCOnnT0rIJngqEo0tTLkxezXyGgJ0fl1MM/KpwrWa4OqKSNctYYHMb2ekyY
	nozMwkUVOpFKUSAw==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
Cc: mat.jonczyk@o2.pl, David Heideberg <david@ixit.cz>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-6-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-6-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288816909.14745.1771292848425363053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d9f87802676bb23b9425aea8ad95c76ad9b50c6e
Gitweb:        https://git.kernel.org/tip/d9f87802676bb23b9425aea8ad95c76ad9b=
50c6e
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:48 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:08:57 +01:00

x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32

I was unable to find a good description of the ServerWorks CNB20LE
chipset. However, it was probably exclusively used with the Pentium III
processor (this CPU model was used in all references to it that I
found where the CPU model was provided: dmesgs in [1] and [2];
[3] page 2; [4]-[7]).

As is widely known, the Pentium III processor did not support the 64-bit
mode, support for which was introduced by Intel a couple of years later.
So it is safe to assume that no systems with the CNB20LE chipset have
amd64 and the CONFIG_PCI_CNB20LE_QUIRK may now depend on X86_32.

Additionally, I have determined that most computers with the CNB20LE
chipset did have ACPI support and this driver was inactive on them.
I have submitted a patch to remove this driver, but it was met with
resistance [8].

[1] Jim Studt, Re: Problem with ServerWorks CNB20LE and lost interrupts
    Linux Kernel Mailing List, https://lkml.org/lkml/2002/1/11/111

[2] RedHat Bug 665109 - e100 problems on old Compaq Proliant DL320
    https://bugzilla.redhat.com/show_bug.cgi?id=3D665109

[3] R. Hughes-Jones, S. Dallison, G. Fairey, Performance Measurements on
    Gigabit Ethernet NICs and Server Quality Motherboards,
    http://datatag.web.cern.ch/papers/pfldnet2003-rhj.doc

[4] "Hardware for Linux",
    Probe #d6b5151873 of Intel STL2-bd A28808-302 Desktop Computer (STL2)
    https://linux-hardware.org/?probe=3Dd6b5151873

[5] "Hardware for Linux", Probe #0b5d843f10 of Compaq ProLiant DL380
    https://linux-hardware.org/?probe=3D0b5d843f10

[6] Ubuntu Forums, Dell Poweredge 2400 - Adaptec SCSI Bus AIC-7880
    https://ubuntuforums.org/showthread.php?t=3D1689552

[7] Ira W. Snyder, "BISECTED: 2.6.35 (and -git) fail to boot: APIC problems"
    https://lkml.org/lkml/2010/8/13/220

[8] Bjorn Helgaas, "Re: [PATCH] x86/pci: drop ServerWorks / Broadcom
    CNB20LE PCI host bridge driver"
    https://lore.kernel.org/lkml/20220318165535.GA840063@bhelgaas/T/

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-6-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a079ecf..1090eda 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2929,13 +2929,21 @@ config MMCONF_FAM10H
 	depends on X86_64 && PCI_MMCONFIG && ACPI
=20
 config PCI_CNB20LE_QUIRK
-	bool "Read CNB20LE Host Bridge Windows" if EXPERT
-	depends on PCI
+	bool "Read PCI host bridge windows from the CNB20LE chipset" if EXPERT
+	depends on X86_32 && PCI
 	help
 	  Read the PCI windows out of the CNB20LE host bridge. This allows
 	  PCI hotplug to work on systems with the CNB20LE chipset which do
 	  not have ACPI.
=20
+	  The ServerWorks (later Broadcom) CNB20LE was a chipset designed
+	  most probably only for Pentium III.
+
+	  To find out if you have such a chipset, search for a PCI device with
+	  1166:0009 PCI IDs, for example by executing
+		lspci -nn | grep '1166:0009'
+	  The code is inactive if there is none.
+
 	  There's no public spec for this chipset, and this functionality
 	  is known to be incomplete.
=20

