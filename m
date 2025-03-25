Return-Path: <linux-tip-commits+bounces-4429-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED91A6EA9C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453A73B1C2C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D290253F13;
	Tue, 25 Mar 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gWjHgdGb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5L22UljR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C4204587;
	Tue, 25 Mar 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888172; cv=none; b=aac48/rTklqir1Z0zc1T9RbGIJ3xrhqCazIo2+v0/gkOvdEUN/foMocQYb1C1HVGRATRcb3uE9Ii6Ik2XcPheeX7ReMS5gxTlR3zQco+GhTSsyHqFMwPz61WFdVzSmxKRzKKZFDArs+kUfpWHgdof9zHZ2EWVPMapAsE9k2oYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888172; c=relaxed/simple;
	bh=6MsNOsvNvb2m/yM15X+jlSAeinvz9EZFaC4p/eTB8L0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AKpXHHhligFlG8qphUL/5bhRijT5jguHKa9QonlbDLV7/p9OOF4rI7h37OJRR7dakGY+f3AGkIdCglDMhL+ODT68myfVwFkPsGBCfdNIJ2aRlPvxM37oZOP4ZqIiHET15C6awtngqIDEO9O68mTvLsSThTpsScC0RMzrVnG7MZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gWjHgdGb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5L22UljR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gAw9t5ets7Sv7W3JxNRtrIGZ+tRk5lxebkDEtcRyXQ=;
	b=gWjHgdGb2DJaxh8omsMZt1TKdDyRBMjaBTP9iAjX5aCnQAOGNtB3DF4Mf3L7x9rbbGVCsk
	cDq7Vsg5KyWSEmFXDA+ifOkMOkadv5vsMvBxX1mWdLqT++XSy9ANIkzvqE3i45ZrHnTa7N
	uX9N8YiDupPc5gpXh4zymYxguAHhthcHXRxtPfTWfH1AFEPs5L3H0sesDnyNTrva4TztXx
	YHMXUXgvM0+HuStYEx2+NzpmmRzKQ02CkgH4/ry3nrx+593uCg89sdDQICdFOROVxi1PpH
	GFBsFwsbjZBUHmNPcWgKUPM1hauItkURJH0FkoURxbypxRQoXQxm1aF5ASL0Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gAw9t5ets7Sv7W3JxNRtrIGZ+tRk5lxebkDEtcRyXQ=;
	b=5L22UljR5s8S2pA1K7yAkamdjnd1RrxVX/ckkq2Gr8R20h1gtI7kiuFowmjLCxgXAk0UDT
	ey+zsl2R2sC2GnAg==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Document release year of glibc 2.3.3
Cc: mat.jonczyk@o2.pl, David Heidelberg <david@ixit.cz>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-7-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-7-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288816852.14745.14262813059892479292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     de7115636c41fd0c654f5865d513df52a0798f5c
Gitweb:        https://git.kernel.org/tip/de7115636c41fd0c654f5865d513df52a07=
98f5c
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:08:57 +01:00

x86/Kconfig: Document release year of glibc 2.3.3

I wonder how many people were checking their glibc version when
considering whether to enable this option.

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-7-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1090eda..e72cb77 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2213,7 +2213,7 @@ config HOTPLUG_CPU
=20
 config COMPAT_VDSO
 	def_bool n
-	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
+	prompt "Workaround for glibc 2.3.2 / 2.3.3 (released in year 2003/2004)"
 	depends on COMPAT_32
 	help
 	  Certain buggy versions of glibc will crash if they are

