Return-Path: <linux-tip-commits+bounces-5831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E7AD8578
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8690716BDEA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F5279DD2;
	Fri, 13 Jun 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqJlWgW8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTECr+3g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76820279DAF;
	Fri, 13 Jun 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803115; cv=none; b=DEXJ2cZOKjCOApNXrk5WFvdg2c1WAIWb7MRpAIpbO28jhpFyUoU83hdUe7d/h3lE3X6OQLPWicYCes8PbqqjejjSLzEzAa2tefcW6749aX1D7HiLALvtKCDB/aJ+lBbXgI3fvnHwIcBch5eaboFJRYO7x95oAwKeOxSF7iPo2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803115; c=relaxed/simple;
	bh=JdDS7wGX8IBpJH9lI2r/bdKG5D1zmKJ6z4F5aMVyZrU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sAYRv6veKYy+PidsWASWtvVQ5AGH1NuRz+HJu7CTLe0Kyk2/VTi1n8B3iRL12UnT8hNWicTZdeO8i1/Hwe94k+0NRO1MzRpjwk3SGxNInqI911tUKfI0m7R8IBgl40Gmx1UsARHCReta5O7FCnKGe03hIzuRc4wzcUiPS+w1vJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqJlWgW8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTECr+3g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AU0BYaqkolUf3xi8uBvmwg/lLq2/V2keDc1IOWg5O6U=;
	b=mqJlWgW83UJLudD5M+uzQwM4FqpX6emlHQbHo3s1JKwq2/9G7UTZDI5XdpOFo+ggSE1CA9
	pqXk5C5Tegc0Me7MIs+J+bYNOMttDW+gu+lbO7mfSlrisaVua+jaICh41WZ7HFU4USq9vB
	+72SRA15VV4+MQujNW5AofGYY1NdBkhYYeEwv146crDld/mbh1vQuWZlLoGRncVlNaf/fX
	B2SOD6qg11p7sfL8YeXdfsGOkDIyvCnHRgknckpwRDrqzK8uHNOyGPKsMaF4d3fNE4CYUp
	mhnS0+elBMGRc0otPArCQ+vlgTyNLj3f4m5vLBKu5y9n1/EMOW7JgKMU1f5JzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AU0BYaqkolUf3xi8uBvmwg/lLq2/V2keDc1IOWg5O6U=;
	b=sTECr+3gcqp9SgJdk7s2DSddJziVEDPrWoywBl3pjiO880Gu2qZ1+bE4btqsOlB2oUysuE
	SgDoa7icH5pNxPDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/kconfig] x86/kconfig/64: Enable the KVM host in the defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-7-mingo@kernel.org>
References: <20250515132719.31868-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980311077.406.16769849111452483926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     011f3ac1694977dcee888715d4973413e4dba231
Gitweb:        https://git.kernel.org/tip/011f3ac1694977dcee888715d4973413e4d=
ba231
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:01:16 +02:00

x86/kconfig/64: Enable the KVM host in the defconfig

These days all distros enable KVM, and since the x86 defconfig
aims to be a distro kernel work-alike with fewer drivers and
a shorter build time, enable the KVM host in the defconfig too.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-7-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 7d7310c..156e949 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -50,6 +50,11 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_X86_ACPI_CPUFREQ=3Dy
 CONFIG_IA32_EMULATION=3Dy
+CONFIG_KVM=3Dy
+CONFIG_KVM_INTEL=3Dy
+CONFIG_KVM_AMD=3Dy
+CONFIG_KVM_XEN=3Dy
+CONFIG_KVM_MAX_NR_VCPUS=3D4096
 CONFIG_KPROBES=3Dy
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy

