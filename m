Return-Path: <linux-tip-commits+bounces-6458-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F587B439CE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5867C5DCB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2273E2C11D9;
	Thu,  4 Sep 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I6G08lh4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbdbpbF8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3262EE260;
	Thu,  4 Sep 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984850; cv=none; b=BiCQznePWPWEEX1m7ePE4+X8Vn9lAIfA4N0zfb3mCVH6TQNODIZFNeQmJXzKsmCeLN2lgY6qGPWMskly0JgYC2625hI77TuFlFEN9Leaq2GpqRDwWlUMtFZt6VK5yaMqjT0FOaYXEaZx7q6mhKSKnTmfAFR6axD9sT0XiKQn99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984850; c=relaxed/simple;
	bh=4ylEL2rdzSSvHdvYuCRbyMZcBZcA2h98HpcL//prmGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ci890SkOPyPU+8q+A8twoQAUks9rwrNXdpLFbbjd9Jtjhuxy6xJwNBNE+0jdwLGmBCpBBZqEixrkMSoimQDFII9oUrWEnEGKCgs+oKqZPA/zqVCXMopO6njqR6v2Zq49SL16mhq8Yk9UH4PK0ZrmTgJ9e4OAueeDPMtHfEXhqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I6G08lh4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xbdbpbF8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZO1gADy8i5ddbxLapqxNo6IOO1sob3pON748UCxrPQ=;
	b=I6G08lh4DTwhFg+8V6wxiNjM5z/VcJ0Bt3yc7CT1FBKJAqwvHh69s97H0t7crPVlRPainZ
	TFmrppHG+fgT5ZsNxPwgSy1rz+IUHsgaDrScUQw4GG4D/mfydXMFB8kdHfZe+f+Wn+nP6T
	wiN+dTiPl3Hppusf1Rqc5eBRjcnO1hft6gC+AuIhoEbXo6Z7xx3hJ4zlx+udVDH/gT5OZL
	gzBDQiNx0xgab8+x+/welNAE+DdDR7YRDdJ1b0e23wDtNl4YT0x5lDUNYsvb036CmhXxtl
	6w1iYgO9r6u7eoSGqZO/oNhY0a+AxhJT96pnt7ykM6x6t5ADgOXsfq84IrMjHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZO1gADy8i5ddbxLapqxNo6IOO1sob3pON748UCxrPQ=;
	b=xbdbpbF89IvTCvQOzRv3O7xEkT9tLItmD7Ju//svVVBbndyy7qWjdNPQx/f3Py7y0JFcRK
	EDv62uxH2GEFdaCA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Get rid of the .head.text section
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-46-ardb+git@google.com>
References: <20250828102202.1849035-46-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698484565.1920.5836741089574743385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ce39a6aa8802e718f9b68bf6892612e4fd7f9d2d
Gitweb:        https://git.kernel.org/tip/ce39a6aa8802e718f9b68bf6892612e4fd7=
f9d2d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:25 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 18:06:32 +02:00

x86/boot: Get rid of the .head.text section

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-46-ardb+git@google.com
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4277efb..d7af4a6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -160,11 +160,6 @@ SECTIONS
=20
 	} :text =3D 0xcccccccc
=20
-	/* bootstrapping code */
-	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
-		HEAD_TEXT
-	} :text =3D 0xcccccccc
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext =3D .;
 	. =3D ALIGN(PAGE_SIZE);

