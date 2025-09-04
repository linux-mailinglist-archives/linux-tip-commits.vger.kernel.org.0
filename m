Return-Path: <linux-tip-commits+bounces-6464-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF18B439D4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F125A2866
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F942FF679;
	Thu,  4 Sep 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XdT8nVUB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XJXhDJX4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1942FF14C;
	Thu,  4 Sep 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984858; cv=none; b=FUilagJTEmcA6FaFdIeG1jo0LDJlq9AwyQe7IsWKOPfzJM8dOMBkOfWEcrKVRlvezF4Q1SlsPe+YXjKhfEqjLyzFLmLz8Ft9ptAnXdRmyIO/MiSrms5lLvl2QpgCTT4vx6OLXWpSiI7rw0+h7YY/uyz133u7rCeDdTQjYVEH+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984858; c=relaxed/simple;
	bh=6g6U5XN4uHmjoO3vAd1ibdz9kXbvvuRybw4U9MBWDBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g9MiG7sRHWgnhC4MswP2WYVaoIXeLATKMH1B7wFQAATQHI91vLXMCiTo3s33CpRr5hb4Ta2PTDvHeqE5NvTd5yd1akIligDpPfYB9xm9PCgcBph7cIvC2DIMcDdYuj9UYgP4mYZOtjoAazVRaK+qFvbGrZUmf3+3p+oZYd5uupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XdT8nVUB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XJXhDJX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yugi8dahLpnnGhMbWt36hrvU7gKX3OSgf6X+jS4O7g=;
	b=XdT8nVUBK2mlkybKmigq4QeeSj84EO37pyB1pi+XEBnSNqyzjGAkZUb2/D2WPPP2xTIgie
	n6bhQCwLh4n9gsih68eZCwFK/Qtj35/2iXIwKwPu8sPOA2Ld3PcLLsQmz5rV4pyQkVYNCr
	caicMHI2Qbj20j41EmrcThdhxug5JLc4NkGVI6XoGJ8m3q6KMsHUkIG7kCoezIqPOWXd9q
	NQwrsGyjSJl97u/y22/hl+gPfVLStjS79LWzVpea53UpfW/uzzUUpUjh/VcvR5WShm3jn5
	Zqutxl4HdXIDC6gt0Z6P+7GKU5V5lf1H4biprf9nE62Ho4N6+KiJypSjT2MkTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yugi8dahLpnnGhMbWt36hrvU7gKX3OSgf6X+jS4O7g=;
	b=XJXhDJX4JUQe1hR6Egq9PnwgkOWbzjsSC8XDPidFNYdbr5XnGlyu2qpZgnQQQzFN/oITbl
	dmdil/iySIcy4RBQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Check startup code for absence of absolute
 relocations
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-40-ardb+git@google.com>
References: <20250828102202.1849035-40-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485254.1920.2686592170748211347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     296650c8ac4f18e886dd2a606152c00adf527219
Gitweb:        https://git.kernel.org/tip/296650c8ac4f18e886dd2a606152c00adf5=
27219
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:19 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:54 +02:00

x86/boot: Check startup code for absence of absolute relocations

Invoke objtool on each startup code object individually to check for the
absence of absolute relocations. This is needed because this code will
be invoked from the 1:1 mapping of memory before those absolute virtual
addresses (which are derived from the kernel virtual base address
provided to the linker and possibly shifted at boot) are mapped.

Only objects built under arch/x86/boot/startup/ have this restriction,
and once they have been incorporated into vmlinux.o, this distinction is
difficult to make. So force the invocation of objtool for each object
file individually, even if objtool is deferred to vmlinux.o for the rest
of the build. In the latter case, only pass --noabs and nothing else;
otherwise, append it to the existing objtool command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-40-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index b514f7e..32737f4 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -19,6 +19,7 @@ KCOV_INSTRUMENT	:=3D n
=20
 obj-$(CONFIG_X86_64)		+=3D gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+=3D sme.o sev-startup.o
+pi-objs				:=3D $(patsubst %.o,$(obj)/%.o,$(obj-y))
=20
 lib-$(CONFIG_X86_64)		+=3D la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+=3D efi-mixed.o
@@ -28,3 +29,10 @@ lib-$(CONFIG_EFI_MIXED)		+=3D efi-mixed.o
 # to be linked into the decompressor or the EFI stub but not vmlinux
 #
 $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD :=3D y
+
+#
+# Invoke objtool for each object individually to check for absolute
+# relocations, even if other objtool actions are being deferred.
+#
+$(pi-objs): objtool-enabled	=3D 1
+$(pi-objs): objtool-args	=3D $(if $(delay-objtool),,$(objtool-args-y)) --noa=
bs

