Return-Path: <linux-tip-commits+bounces-4432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1354A6EAA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E133B60E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2AD255238;
	Tue, 25 Mar 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iihnV50G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpuUEiQy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996662F3B;
	Tue, 25 Mar 2025 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888175; cv=none; b=lsyESqm80hIMXHI2IqiS+Bt/PCjmT5SUdE0oPa/2cprMwUX/oSriflHUzQdh1Izbrri6o+1NEHrblcccnUEaCne+Sq90gRyhUMZvVXKicpoOR1J6dknHQ9cKpMuimTuaA5eAVuDG40ucfi7SqzY8vWpEtuN/4pJKmIjErwKxgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888175; c=relaxed/simple;
	bh=DnuYk0x+SFvyp22G1fTfcg7WJqmettww7pG88pBXaEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DyObrzr++x3L6+F0tvDVNMy6PSVmyPUQ4eYUitc8S6i6228FwcLPFxiV1Bu+sKp/6XGjCvSERRxK5QQTBRAynlEddBfF099zWWLGWe7RJwHGN+/LvUQS11QSv5nkU/ad/H5XJY7ohyeaiZvo1sQYlSuragtmdtBxP2ia1foYdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iihnV50G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpuUEiQy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFdC9KBiiTclmsO/8q/IgoobOgIKfUMYwcYMtL2Af2c=;
	b=iihnV50GClZYgz2PxreCB8UH3rTCyb118LIyrpDwTSzx/oVJSfCIh+6K+ZuRfAsaEPOF0B
	fzTk+7ED0FbMw9nNbKO6C54h2wZHeufG30UAP50gyHGSpPf1kRjes99+vZmLxFiSkbIr+9
	UmXLm/287n1VkUcRtwJiekenOvMsoWiY1hl7g1iGB/llzsxjCAxK1RhbfRsFFQAERe6rsq
	CM94kDYZSE31gjKk773DOm8Vvb/0i3WVlIn6tiksWAKkyG/b6uiZgwKDc45qKcw2yryXKc
	U2zTffLMIUxEMnvpr0aRqz/0fqdRvu7vHLQCDyCgz3fQ8EPUp+nqaTIHG7fs4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFdC9KBiiTclmsO/8q/IgoobOgIKfUMYwcYMtL2Af2c=;
	b=MpuUEiQyrk6vrXVNj8nZeWiMxepuyg2/Q4wU6+U6Yq7zlEvDUo90GJ/j0vj9M+xSGSu+Hl
	DKTZz/w/Rbt62NAg==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Update lists in X86_EXTENDED_PLATFORM
Cc: mat.jonczyk@o2.pl, David Heideberg <david@ixit.cz>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288817105.14745.14614627013694495488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4047e8773fb627df3779291d9138e425537573af
Gitweb:        https://git.kernel.org/tip/4047e8773fb627df3779291d9138e425537=
573af
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:02:16 +01:00

x86/Kconfig: Update lists in X86_EXTENDED_PLATFORM

The order of the entries matches the order they appear in Kconfig.

In 2011, AMD Elan was moved to Kconfig.cpu and the dependency on
X86_EXTENDED_PLATFORM was dropped in:

  ce9c99af8d4b ("x86, cpu: Move AMD Elan Kconfig under "Processor family"")

Support for Moorestown MID devices was removed in 2012 in:

  1a8359e411eb ("x86/mid: Remove Intel Moorestown")

SGI 320/540 (Visual Workstation) was removed in 2014 in:

  c5f9ee3d665a ("x86, platforms: Remove SGI Visual Workstation")

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6155b9..917cd2f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -542,16 +542,20 @@ config X86_EXTENDED_PLATFORM
 	  CONFIG_64BIT.
=20
 	  32-bit platforms (CONFIG_64BIT=3Dn):
-		Goldfish (Android emulator)
-		AMD Elan
+		Goldfish (mostly Android emulator)
+		Intel CE media processor (CE4100) SoC
+		Intel MID (Mobile Internet Device)
+		Intel Quark
 		RDC R-321x SoC
-		SGI 320/540 (Visual Workstation)
+		STA2X11-based (e.g. Northville)
=20
 	  64-bit platforms (CONFIG_64BIT=3Dy):
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
 		Merrifield/Moorefield MID devices
+		Goldfish (mostly Android emulator)
+		Intel MID (Mobile Internet Device)
=20
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.

