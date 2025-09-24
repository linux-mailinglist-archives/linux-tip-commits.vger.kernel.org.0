Return-Path: <linux-tip-commits+bounces-6715-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5EB9AD38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BF82E8459
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991731352D;
	Wed, 24 Sep 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OESK+YAl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VACrSYaB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3330FF0D;
	Wed, 24 Sep 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730568; cv=none; b=DPrEyIMQjmVLR1dv8XR3U49zqFJdhn7rIe0nzlWrB7MfxVsxLks1CqqG8YBRzOuzeauLNnU8O9iP4lRsWz3Rpjq1uy337+3hhFlKQu76XHaj5c9tSyHV+2vfDP8TJRrSdb0nYvW2F1GanhUbfKk38RbUZDsFRrJBQyvpOtHA680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730568; c=relaxed/simple;
	bh=mg4i2RXqsF8TlpcGWAuJrDAQmmNxwUOdOGnTKHHVRHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=drSUSUFjSk6K/C+pEmN1pABRGMizQZAMZyoT7pQQ0uwQisdURMNRFClPeoplTpCBthWr1mDxnzmHpmEP7QasTCNqlqZqer4wjpHp0JHw54Uft4I97IMUBkl32u9LYN8rYZVzFUIgcNjJV7dwAi36M/aOSdhb5+XPAOnXeLYlABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OESK+YAl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VACrSYaB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Sep 2025 16:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758730562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xmqn1uaYi108OYm7YZrsQrWxPa21vKamK8gzajt6h5c=;
	b=OESK+YAlygkR9DaTzWQ+wCCW7hZxhegT6cZs3E2BqdHcCdDEhEIQsIFFQatV15ZDBMBjlI
	CV4B++32edkPpcdDmyjvWcP3JkYYV74IOguQq26RjOrEPC4DJ2XzmzydTVLdf9O+UXztvT
	x1dmC1RCwsX5vOtvtCUDop6XSs6ZZsPzFmCm6vaTKZsoIMkpgqes20tYd9Pkk/ag6y4xfJ
	ndH0Moo5L+0ncpQgbAAIDu5rHPeF0IIgGR/cdkK2vRws5sVlzwmSQdXe+t3rZwn6Is/1/F
	7gx6h0ybNh2aolPeIBfC/2t1b/aMMmkqi5+CFcHkuww+HaQ3XcMqsuEWraEDgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758730562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xmqn1uaYi108OYm7YZrsQrWxPa21vKamK8gzajt6h5c=;
	b=VACrSYaBks9dQ7oQ/lODENVMymL1bDEXdpp6AJsymH5Itk+TuNt030Sa8Z6mqG0LFqOepA
	ZNzLAPXdQsAmm1DA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/boot: Drop erroneous __init annotation from
 early_set_pages_state()
Cc: Srikanth Aithal <Srikanth.Aithal@amd.com>,
 Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250924155310.3341370-2-ardb+git@google.com>
References: <20250924155310.3341370-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175873056047.709179.8745227045157093968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1f6113ae5ac4927fe80256154ebb0461e670fa85
Gitweb:        https://git.kernel.org/tip/1f6113ae5ac4927fe80256154ebb0461e67=
0fa85
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 24 Sep 2025 17:53:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Sep 2025 18:08:34 +02:00

x86/boot: Drop erroneous __init annotation from early_set_pages_state()

The kexec code will call set_pages_state() after tearing down all the GHCBs,
which will therefore result in a call to early_set_pages_state().

This means the __init annotation is wrong, and must be dropped.

Fixes: c5c30a373693 ("x86/boot: Move startup code out of __head section")
Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
---
 arch/x86/boot/startup/sev-startup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index a9b0a9c..0972542 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -44,7 +44,7 @@
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
=20
-void __init
+void
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, const struct psc_desc *desc)
 {

