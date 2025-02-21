Return-Path: <linux-tip-commits+bounces-3558-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51672A3EF7C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1DC16CBBC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39115205AC6;
	Fri, 21 Feb 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4pCyaea1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xchNJtK1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32104204F96;
	Fri, 21 Feb 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128601; cv=none; b=GSUKMnZvWqYf2W50gJMOSo+nunaxWbnt57xxH3Lebr3pSBLQrHo49sCRryLe06VeyCNr5qMHOksnqaOsezbhZ4VVZJoBKylGH1sTwi/J1uqDhBnDIYD8DntiMC6E3voEmghSimGOpi7noj5TOXUQBfAeCVDvEiGoeIlZg4pER7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128601; c=relaxed/simple;
	bh=RcehuO4Cx9VAT0yQ9KjmNEtmFjyE/VCTu33XkNjuYIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XBBC5Vdw7tPe62nTDxMMTwuVNRaEtDOzA2FCxwf7ASKCvKctBqNMpmnmLdnhyMVSV92g553WudtZ5Tr3JvncdTeUHOF+l7IO4hrA8b2eLGK5NT6xno5/72l7t1tSK7TpMrdIoQOm6ms2gZGrOGB0Z+3Xqop1xz2uJsX6j9wGLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4pCyaea1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xchNJtK1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkAgHaNroju+nOJK4x4XB8+ll44b1/Sm7C45OgpgJvQ=;
	b=4pCyaea1brI2fnn4aYPXJk757N0OLqHO1iA30nM63gpRnZ39vPPYGq/iP+QHvOZTAwjJ6N
	rM0NF8OeeZDyjzFOGGmPjpFtbjrRed0vRZ1bzcfnsBmp3ni2L4WavSr97wg0is5T6X/RdW
	Nlgr+MbiFSXTJR/n77XyMmjkfmgRKkO9T3Y7x4LxFLShuEsSfdqAK06Fm7JzmbOLIdg6wR
	7qFrEKWMqLLN8YkFGVS6iB8u/h1YS8fYURuFE9zKahWbtaGz9J5vqvt3XNUKsDYM/Sl+6O
	Ufh9TxmTECi/WNVt6alL4wj3aaHi/+YhuStSnEQUto6wsy4kT5XaGH/C4UG/sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkAgHaNroju+nOJK4x4XB8+ll44b1/Sm7C45OgpgJvQ=;
	b=xchNJtK16W9UxBjcNswhfF7HqqLjTB/5P6FZaTn9V3GrUaKNKIcHcqoiB0NSPNv50r5JpZ
	ztPce2mE35gw1CBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] parisc: Remove unused symbol vdso_data
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-2-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-2-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859689.10177.12969393750836340571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     30533a55ec8e6cd532989421a2d99ec422396fce
Gitweb:        https://git.kernel.org/tip/30533a55ec8e6cd532989421a2d99ec4223=
96fce
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

parisc: Remove unused symbol vdso_data

The symbol vdso_data is and has been unused.
Remove it.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-2-13a4669dfc8c@l=
inutronix.de

---
 arch/parisc/include/asm/vdso.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/parisc/include/asm/vdso.h b/arch/parisc/include/asm/vdso.h
index 2a2dc11..5f581c1 100644
--- a/arch/parisc/include/asm/vdso.h
+++ b/arch/parisc/include/asm/vdso.h
@@ -12,8 +12,6 @@
 #define VDSO64_SYMBOL(tsk, name) ((tsk)->mm->context.vdso_base + (vdso64_off=
set_##name))
 #define VDSO32_SYMBOL(tsk, name) ((tsk)->mm->context.vdso_base + (vdso32_off=
set_##name))
=20
-extern struct vdso_data *vdso_data;
-
 #endif /* __ASSEMBLY __ */
=20
 /* Default link addresses for the vDSOs */

