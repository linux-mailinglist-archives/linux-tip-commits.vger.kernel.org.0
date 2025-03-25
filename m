Return-Path: <linux-tip-commits+bounces-4434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D86EA6EAA8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8867418976DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BE255E37;
	Tue, 25 Mar 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="spcXUgax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9kiiZiW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1E254B11;
	Tue, 25 Mar 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888176; cv=none; b=erPvh5jSbbuqL2VZ7iZiDJIUtJ1/MxlbDm5JJg3IQx0IlctZKggk/I3LPa/1r9ctXwDk90GYZ0hvTrP4NpqPFF9wL9nG6AV4PhLsBcItMNsK5m9/N2N6vkX2M1jTmMkBsHrvh5REPPc9McwylyP55MolMFLvZ7bWJC3n1NckaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888176; c=relaxed/simple;
	bh=R/Bgk2ZQhhQ82+k9KnMxR3d8RUARWiiYu0D0pp/nBdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pY0owEsN2CCbwfcP5ygwrb9wKuqrVn/EYSnScj2ZwtvMhcP+3jPftctVor0RS1WUHJVV3LXsxmBmzIVTisyj52DrAwTyrtR7ewpiMNYkH0gHdEaU3rlDaDeLXRQoyNETyL7G0AmQw5GiEz4CjHEiLHxCWG5IL3Uq3Ey8EolVgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=spcXUgax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9kiiZiW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtqWtCDlIlO358Ff/Ea1lcxBaWSM/8os8O/8ZhUe+iI=;
	b=spcXUgax9pNbQ6ISm/JTxn2kA2mbD9bg5FAHcAGTtozgyV8/eWm8rxGxn9+ul/4Mg5Pu2m
	vtfvYtJ4S8NGnRqs0vdukUAxaiF4DheULxhGtQH3BnJSLd/RagFCjzHH8305ZB1EQ0F/Fl
	CgdgqxMHk9Nx2WipzacjjjkLLpL6IGWp+2CrM9CzJO33fIV5LKX7zIHt2MUS3UTGZRQfx9
	FU5liE7shu8VFH+q4qqcZ/hLNeeQ+oHKlqH3BIAF+BUSF34k2SrcxbyYgN3IrqDzqJPc5m
	eGOYO4+jz0pAt9oKRQ1cjqwur/3qsufjX2tnKQ1axcvmD35TLMBhrIrye4HcOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtqWtCDlIlO358Ff/Ea1lcxBaWSM/8os8O/8ZhUe+iI=;
	b=m9kiiZiWUoYTtdHnZN0VVpM0k7g2DnQrb7NHL8NLXkiJF5qSN++iBQc/9n47oEw8AI/RRc
	GfdTH34bDBb+XHAQ==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Always enable ARCH_SPARSEMEM_ENABLE
Cc: mat.jonczyk@o2.pl, David Heideberg <david@ixit.cz>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-2-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-2-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288817228.14745.8439055529176907969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31be5041dca37a67c11042678c55804e964e5145
Gitweb:        https://git.kernel.org/tip/31be5041dca37a67c11042678c55804e964=
e5145
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:02:16 +01:00

x86/Kconfig: Always enable ARCH_SPARSEMEM_ENABLE

It appears that (X86_64 || X86_32) is always true on x86.

This logical OR directive was introduced in:

  6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")

By (EXPERIMENTAL && X86_32) turning into (X86_32). Since
this change was an identity transformation, nobody noticed
that the condition turned into 'true'.

[ mingo: Updated changelog ]

Fixes: 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-2-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 08bc939..442936d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1563,7 +1563,6 @@ config ARCH_FLATMEM_ENABLE
=20
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on X86_64 || NUMA || X86_32
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
=20

