Return-Path: <linux-tip-commits+bounces-4431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E1A6EAA3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AE5188DDBC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88C254AF9;
	Tue, 25 Mar 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyMqqdtu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ujb+hZDE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2E253F35;
	Tue, 25 Mar 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888174; cv=none; b=hxODYqqfzF6qC0O9hpfG6SVV3Yj2pF+kukcCQFXgtE4/Xdq/IVUgWk/Q9YM1OkX9Zcn29EGTO7WhXN5iWvUltHd8VfFoHaRVv6u7cjf1iuNDUXihsO18rVSV3Z9ZHjbUB8y2Vg1Rf0U+gL7YhVEkgD7zUl0tqwZwHbpfqF2rjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888174; c=relaxed/simple;
	bh=XcJyY3wGKpcT423ocmHs5TJMHF+prodiNcMBActqDc4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FRXCWio9hCJaLz9LOa19ZglZfGTbDTOcOFtqsKvgiiBUiABhtNFm4mGh5tIXOz5f4vP4IK5o0gfgQfUiGjBrZHun7TGInvhFrOyiP3JG2t19ToWUHzGW/LwmV3tM1P5RReHkonddx90S2uT7lVXlZT9qPjyfO2TmVcuADL5XlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyMqqdtu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ujb+hZDE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez7An6mqQ0YdyzErr2athNp0PxN4F4F6r9ilmzYyhIc=;
	b=cyMqqdtul7YR/oHbNspvRS6kw61QHJwVrhScxsmJ7jnBrqwc2xj3GM4SVSFuXJvwi8iq0C
	1xHvzNWoHKki+ljb7CVmspNQZsBXuelXNEhrcWx4Vk9LGXC2DghB3gCDNQYdHdB/06XbQY
	FHbWHZKF78SLU5jyzg7AI9j82E+kS2Cv5ukKid+iqmR+7QN7pIoPCuAALa5w5pcna/3BdQ
	PHieUHaQVgJLSmtvCFDMUpYClMDUjd8pKQ9SMzKygjRCV24PucY/pO9FPVuU7OhsB0v6u6
	aUjWqqfDfPu9kI3E26NJYqzBgGTxeFK/pD6PocgoyQFHhw2m3uWULRw3Epg31g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez7An6mqQ0YdyzErr2athNp0PxN4F4F6r9ilmzYyhIc=;
	b=Ujb+hZDEWs7JCQDdZ7Q/i3WmcdIPb3+USaYofJFjdhsS68aY8oCEhl6OJqrcP19nMUAEhY
	DRF8kunsG8T+seCA==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Document CONFIG_PCI_MMCONFIG
Cc: mat.jonczyk@o2.pl, David Heideberg <david@ixit.cz>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-5-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-5-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288817046.14745.11802846447168020418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     21d8fb8d4e7071b2e60bc48c217ff1b4ce8cb855
Gitweb:        https://git.kernel.org/tip/21d8fb8d4e7071b2e60bc48c217ff1b4ce8=
cb855
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:08:20 +01:00

x86/Kconfig: Document CONFIG_PCI_MMCONFIG

This configuration option had no help text, so add it.

CONFIG_EXPERT is enabled on some distribution kernels, so people using a
distribution kernel's configuration as a starting point will see this
option.

[ mingo: Standardized the new Kconfig text a bit. ]

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-5-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 917cd2f..a079ecf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2902,6 +2902,19 @@ config PCI_MMCONFIG
 	default y
 	depends on PCI && (ACPI || JAILHOUSE_GUEST)
 	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
+	help
+	  Add support for accessing the PCI configuration space as a memory
+	  mapped area. It is the recommended method if the system supports
+	  this (it must have PCI Express and ACPI for it to be available).
+
+	  In the unlikely case that enabling this configuration option causes
+	  problems, the mechanism can be switched off with the 'pci=3Dnommconf'
+	  command line parameter.
+
+	  Say N only if you are sure that your platform does not support this
+	  access method or you have problems caused by it.
+
+	  Say Y otherwise.
=20
 config PCI_OLPC
 	def_bool y

