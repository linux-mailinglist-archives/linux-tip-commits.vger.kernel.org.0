Return-Path: <linux-tip-commits+bounces-6462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26567B439CF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE1F5A2613
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0E2FE074;
	Thu,  4 Sep 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RreQWtrZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3f+0U4ce"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AE2EE260;
	Thu,  4 Sep 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984854; cv=none; b=fLa4nzWW/vnWXJsD9l9PqZLeV4kPJ/HlpCDim0vB6Jf+b7FPkOkloiZfan+U7jgpy/8hUgNvV0YYNn+Kx0DmRqqfIM21Zi1/isLepPVBrPhXR0tX5o7VnBWKdZHONRfr7eSGYBjn/CjMOMIEDLu0m+Z/kpVms46cr0/uW7vuPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984854; c=relaxed/simple;
	bh=MeHVd9RysaDlOULCKdNfEL/S8qIwUP8xvmoXD2EhMkc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n4ClvEoZEwpSKAXLLbZEfANd9uGHjivSDd8Qi+kRx4obwcVosO5OqCiB8L+p/XNc170Gk9jRfmCUPTMWUveZEsfnzWwJ58MqBknV8BIp6a3ojjrmbn0A2bno1/riIiJIS3IkrIuT5bG73Ys+PjWHxT83an9sJo7MsxkEIBEFKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RreQWtrZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3f+0U4ce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6g6S3fyKlcgp3tkBtbXtzlBlo1AbkoN9ETIm/Zw8DQw=;
	b=RreQWtrZwepuSv4E7wWkGWJKE9BunuDkYi2BpmuN1Us5cnIGIQ2s2bfV7yypQawJQ8O7bt
	p9qkp5XLiQAROxIkSNgFgNzycyYVB0S88VBUsYeuBXqgv2nLhm+205pmd0P4QoE33jld01
	y+eNMgJjCFtOIYIRujE+ngEa3SflVn+Xq9bmZ5nqzG8kJUrM3sCuaO9McwrhepOBM6Y1s8
	cfwOxOCKU61NG4QU5yaidNA9aY3qs5Mp6dBFHn/gAU15AwP9eKCYi+r3G1zJl26cVi2Bzo
	EYIapEJ0ztM18+nK9L8nmZ+XrPscVsWiRfn9oxqg+0XhCqf1KBHJToLAob399A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6g6S3fyKlcgp3tkBtbXtzlBlo1AbkoN9ETIm/Zw8DQw=;
	b=3f+0U4ce9QlrQYKRfvmynm4tGhajX08RQZy4T/FEjtY4tbIBZwZ0E+ehxySWKPctWn14cS
	aD+BlNWvXKbVZKDA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-42-ardb+git@google.com>
References: <20250828102202.1849035-42-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485036.1920.8375960528121995879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     749627c3980e4421b709857e979e8aa16a4c7147
Gitweb:        https://git.kernel.org/tip/749627c3980e4421b709857e979e8aa16a4=
c7147
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:21 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:59 +02:00

x86/kbuild: Incorporate boot/startup/ via Kbuild makefile

Using core-y is not the correct way to get kbuild to descend into
arch/x86/boot/startup. For instance, building an individual object does
not work as expected when the pattern rule is local to the Makefile

  $ make arch/x86/boot/startup/map_kernel.pi.o
    GEN     Makefile
    CALL    /home/ardb/linux/scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
  make[3]: *** No rule to make target 'arch/x86/boot/startup/map_kernel.pi.o'=
.  Stop.
  make[2]: *** [/home/ardb/linux/scripts/Makefile.build:461: arch/x86] Error 2
  make[1]: *** [/home/ardb/linux/Makefile:2011: .] Error 2
  make: *** [/home/ardb/linux/Makefile:248: __sub-make] Error 2

So use obj-y from arch.x86/Kbuild instead, which makes things work as
expected.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-42-ardb+git@google.com
---
 arch/x86/Kbuild   | 2 ++
 arch/x86/Makefile | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d8..36b985d 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -3,6 +3,8 @@
 # Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
 subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) +=3D -DDISABLE_BRANCH_PROFIL=
ING
=20
+obj-y +=3D boot/startup/
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) +=3D coco/
=20
 obj-y +=3D entry/
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1913d34..9b76e77 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -286,7 +286,6 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
=20
-core-y  +=3D arch/x86/boot/startup/
 libs-y  +=3D arch/x86/lib/
=20
 # drivers-y are linked after core-y

