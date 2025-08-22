Return-Path: <linux-tip-commits+bounces-6322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F928B32338
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 21:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B461C283E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63152D63FD;
	Fri, 22 Aug 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyn9rIVT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VdWFdy1n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8602D5C9B;
	Fri, 22 Aug 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892401; cv=none; b=Jjxnkft6vQOwaZJVCHOXPUOHrbczgVzFQE6Y6U2fAQreaSPlzNdpnDyI9ftEO2/6bFXUkoZG/EkEWgj3Kz8/mDZWbvF6mQq39NOvK3bR9zdultR4STdGaTr5rWLnKp5g4CTkOb4ihfvE4ZRXRdrZIlF0vu9E8GU9NpFAUIM6G4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892401; c=relaxed/simple;
	bh=H3uGrUUzHrS3zFAm6jBW06/pIemOUH8HTl/FVvdz4SM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PyntiaZTCAEglGjM/nbm+9PtR8cnytYxk0VGyBU2OynRrzUH0ktVBBhCKVbREl2Yja/+sHJDkc918JX1YzH2rwgLrCMGPXNjBVOMspIAwAWyoP9B7onMUAZfAyvZBZAn3gIKuaVHHoaUoKSTkibi1+YF81EwzQ4/bMHcowH63jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyn9rIVT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VdWFdy1n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 19:53:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755892397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X3+vufUYrcDlOURApxBLnSFe87VcKfZcefeiST0+zfA=;
	b=vyn9rIVT/yiLcrH+VQJv4ouL3iK8OgZXXuy3aq8qyyk0Btkpm5D/SsHPbew3rWHwF+Zbac
	5bofdFgoQVL2FkcYswUoFDT5EEJqGuMz5816fDBbLnTl9SsIhZ2IMqTWwT6QeKQZsktgxT
	pY0rYFAtg4rO8rNDKYZ4vAegnCY52JcNuXqD7k63A5t0jczsmCQWl75c+qQyV/49I4d3xI
	wHSVsG31xB/AN6dCvlRurxScsvBx6U17SnslH6LxsC1cf1kWGNQn6WjSBSniEauc5udp04
	39vVM2h2LRQP0s51cjz3RPc6r7POaQM7ntpO8io7932tboYfTwJ5bszmVn7iNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755892397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X3+vufUYrcDlOURApxBLnSFe87VcKfZcefeiST0+zfA=;
	b=VdWFdy1nTpRhwfFuTlMeCScYBT3sKnaAbf+pkD1l1aEtrRg7172qJ602FiKiZH+DHQ//vF
	BBf1dWWaZbWCM8AA==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86: Drop unused and needless config X86_64_SMP
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175589239618.1420.10700126604519433794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     87d1911cca1e947fb444c158de9be358a1964df7
Gitweb:        https://git.kernel.org/tip/87d1911cca1e947fb444c158de9be358a19=
64df7
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Wed, 23 Jul 2025 09:12:11 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 12:45:53 -07:00

x86: Drop unused and needless config X86_64_SMP

As part of the commit 38a4968b3190 ("x86/percpu/64: Remove INIT_PER_CPU
macros"), the only use of the config option X86_64_SMP in the kernel tree
is removed. As this config option X86_64_SMP is just equivalent to
X86_64 && SMP, the source code in the tree just uses that expression in the
few places where needed. Note further that this option cannot be explicitly
enabled or disabled when configuring the kernel build configuration.

Drop this needless and unused config option. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250723071211.622802-1-lukas.bulwahn%40red=
hat.com
---
 arch/x86/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 85b9126..99866e3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,10 +410,6 @@ config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
=20
-config X86_64_SMP
-	def_bool y
-	depends on X86_64 && SMP
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
=20

