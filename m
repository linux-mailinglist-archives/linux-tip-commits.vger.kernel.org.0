Return-Path: <linux-tip-commits+bounces-1906-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2C9458B8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE781F21394
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7A1BE87A;
	Fri,  2 Aug 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EOE4XRa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lav2scx3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2A433C7;
	Fri,  2 Aug 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583728; cv=none; b=FVcZwqLHjKwLhD0OQw2g+gcc1gvcmBC4cczz4nE9GmfYdSroCBOVpXuTSQOaSMsM567ZbgliNLEsSWkViGgHmgW/fgxCse08cJ9CIRgKg3GkZhHq5YC9UFOARS3e9H6c1vWPJ7Z0GtWRz0YweRDC8IH9f3t+cjobpd+zro3clCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583728; c=relaxed/simple;
	bh=4VQ3ivKRlQ0lgUsIo4wauWqLKiH+Xq6sfMJxB/lqjqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=koaNx9oGeQBhqDqUdLCHES1b+N4swnRoZBfjsdH8P8qQf2BDOLY60gWR0pxochhf6hTz9q2L2Tyv2vedeUEa6FOLxcUoKU+OABQleesvFmL9ntgnVoG7GVvzlRRuBCZIRmTmhqTzqSfOHzf+wwPb7UT5z/e2U+UKLGocBvVwpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1EOE4XRa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lav2scx3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBwVnxWUQ5ex15M7GiSzCOaD763UcOUXJH7zqhO75BM=;
	b=1EOE4XRaL0EwX2QNaKa+3p60jjZUVM5U1uPu2FkzWnWGCITLu805aMWNmowragvHYAEKAk
	vB6laaxXyBKo8iI7ooVvo3HiVWTkuvrielI62a8UJ6vReO/TxOw8NY8di2IbYyjsWANFTW
	7FEHKLu5YJijFMfr7+1FDBS847ABRKOPMSgto33kHPF/zSwhKZP4W7zC61sOeFUYzW3iBm
	eC5HSov8n/FVwPl8/RXUvepKEPr8W9wBRYZg7Q0pWktcbKwL4n8KGYVlg9cFaDrQY/lZcN
	/bXdJa9BDXo9kYG+BmxmgqHTpfIwuLxWZ7eI1Zp0/qZ+m9JMduIBR7Ob3mFxMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBwVnxWUQ5ex15M7GiSzCOaD763UcOUXJH7zqhO75BM=;
	b=Lav2scx3s7tf7aVeeclmlI1AyHPwLZ4agbfi0lixF5UjJB/aquiHGw1Mk73nHMoMDSnSqP
	iMR/bPMzauuLabDQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Add x86 cpuid database entry
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-10-darwi@linutronix.de>
References: <20240718134755.378115-10-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372403.2215.11768437846104442379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     ea66e7107bdc4efb530878f2216390b8bc5bae0d
Gitweb:        https://git.kernel.org/tip/ea66e7107bdc4efb530878f2216390b8bc5bae0d
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:19 +02:00

MAINTAINERS: Add x86 cpuid database entry

Add a specific entry for the x86 architecture cpuid database.

Reference the x86-cpuid.org development mailing list to facilitate easy
tracking by external stakeholders such as the Xen developers.

Include myself as a reviewer.

Note, this MAINTAINERS entry will also cover the auto-generated C cpuid
bitfields header files to be submitted in a future series.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-10-darwi@linutronix.de

---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde..6daab3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24773,6 +24773,16 @@ F:	Documentation/arch/x86/
 F:	Documentation/devicetree/bindings/x86/
 F:	arch/x86/
 
+X86 CPUID DATABASE
+M:	Borislav Petkov <bp@alien8.de>
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	x86@kernel.org
+R:	Ahmed S. Darwish <darwi@linutronix.de>
+L:	x86-cpuid@lists.linux.dev
+S:	Maintained
+W:	https://x86-cpuid.org
+F:	tools/arch/x86/kcpuid/cpuid.csv
+
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org

