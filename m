Return-Path: <linux-tip-commits+bounces-4426-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B07A6EA97
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21432188D3C1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D862F3B;
	Tue, 25 Mar 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AcYpBS4e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uq12UIgh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52725776;
	Tue, 25 Mar 2025 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888170; cv=none; b=YifmJhuCiWRdQLkkMcH0AkniOVX8+XoDrpvfcgUE6vxixVyVlAjog4f81rNozxv4IPk/qP3PDJdNnOVmF4avwSSMB7TM9Bv5iDKw5wTrV80Csk7eaHIvar+R3K7JEqFOFf5aHpKz+uFhJtRV5GoVqnYwyBu+y/HvrfXCt7+ySxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888170; c=relaxed/simple;
	bh=YNrjLZIgVt+7FsOu8FR/zvKSOW9gDbGDqDrUvZOw6Q0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J4AHNn0Nosy1d18SNmGtXOG/4rCTtUrSlVpm8syYYtx79UoHuBsJ6aNRjzerZaKa9U52RoM7KxkDY6bPK0o9Wh+9h+ko6Qxore0Bd6I/CYgQTrm3AUvEG1FhDsWRQOQ52CYk8lKyLce72Ze/IIc98h9eLzaaJK34C1dg9P5lVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AcYpBS4e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uq12UIgh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc/L/Kik+NsHrdOpMvY6lXXcw63iDxeGrQuWUcctioo=;
	b=AcYpBS4epZ6cBE4BA/MyEkpuwbMIs6o2wVnpzduwPoJivt7l4c7+DZreu6SQwxgcSn5xZ/
	ce5iMP8RUCBZZQVfvFf0z5V3HJu/rnFnod/wt0blz2P4Vu/3sCyTJ+ZBNXnzX31xDHue+1
	Thr+fsCs+PA4dRF/nlvgNFZ3GHq+I2wPgO/nYKLs7RUX4vZ6VyebQM5yG9MPOeykxQlpgJ
	+XdpJtIT9JKN7ZRYhC4ZLDi0IvWi+YZrxnLMreZ5ot5tu77jTa8GqZ/i+WVWZlyepVI0DQ
	Wf72ofv89byvgWZuFZ2FZvc0AiEss+jQYCuYevG0hMqhuqpRinxwUPvnvHi8qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc/L/Kik+NsHrdOpMvY6lXXcw63iDxeGrQuWUcctioo=;
	b=Uq12UIghkSJ6Mo5fOJujFnr/6YnNawUfeoI6tINWFg65rL16i47xA9TJvZQ5lTtxQWd/LZ
	hXmyPeIGEadEPIBQ==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/Kconfig: Fix lists in X86_EXTENDED_PLATFORM help text
Cc: mat.jonczyk@o2.pl, Ingo Molnar <mingo@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250322175052.43611-1-mat.jonczyk@o2.pl>
References: <20250322175052.43611-1-mat.jonczyk@o2.pl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288816617.14745.14886579662628627185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2704ad556cf2b1f3a08526f4f12f9200cf7dcb03
Gitweb:        https://git.kernel.org/tip/2704ad556cf2b1f3a08526f4f12f9200cf7=
dcb03
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Sat, 22 Mar 2025 18:50:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:22:26 +01:00

x86/Kconfig: Fix lists in X86_EXTENDED_PLATFORM help text

Support for STA2X11-based systems was removed in February in:

  dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support")

Intel MID for 32-bit platforms was removed from this list also in
February in:

  ca5955dd5f08 ("x86/cpu: Document CONFIG_X86_INTEL_MID as 64-bit-only")

Intel MID for 64-bit platforms is a duplicate for "Merrifield/Moorefield
MID devices".

Fixes: 4047e8773fb6 ("x86/Kconfig: Update lists in X86_EXTENDED_PLATFORM")
Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20250322175052.43611-1-mat.jonczyk@o2.pl
---
 arch/x86/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef48584..ce46252 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -545,10 +545,8 @@ config X86_EXTENDED_PLATFORM
 	  32-bit platforms (CONFIG_64BIT=3Dn):
 		Goldfish (mostly Android emulator)
 		Intel CE media processor (CE4100) SoC
-		Intel MID (Mobile Internet Device)
 		Intel Quark
 		RDC R-321x SoC
-		STA2X11-based (e.g. Northville)
=20
 	  64-bit platforms (CONFIG_64BIT=3Dy):
 		Numascale NumaChip
@@ -556,7 +554,6 @@ config X86_EXTENDED_PLATFORM
 		SGI Ultraviolet
 		Merrifield/Moorefield MID devices
 		Goldfish (mostly Android emulator)
-		Intel MID (Mobile Internet Device)
=20
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.

