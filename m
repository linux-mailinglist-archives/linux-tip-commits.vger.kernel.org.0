Return-Path: <linux-tip-commits+bounces-4433-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE29A6EAA4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DC51897E5D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D725523E;
	Tue, 25 Mar 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYbIMiWj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZtC9PVW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6583254875;
	Tue, 25 Mar 2025 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888175; cv=none; b=QdWNovj5CcPILGxLa1PfK7yfvpeWhkaoYuCulS9o7hozHF+P564W8pJFQKgD7kKN9vC62FEpzDX8yffS//0J/ocTlw65keKqu0lrvcnXEa34xkPKFt8wwAUBat4nIVqf5Req7HfJHObdu+5w/Si0P4yliBUKj1bNwIipjYbmY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888175; c=relaxed/simple;
	bh=Lx1PJbvslMbNmiHVFuw2FXiK1aKxMD1a0iON26OuN7A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BDqK2YyKnOkVekLZwCGQ6Th+yJiuwDq9CnL7/RAaKXrpB2DkE9ztQ2aZR+E7WYFxP0LItjPskw0FElM67K8MSM79VV85c5J11MkTsVHK5O2MSVAOg3P6+DyxwV7yKHN6QsYJ8qq9QuZkFNBcc/0c8jXYThFIHnhAcE0HlMssZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYbIMiWj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZtC9PVW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fppa6bYAw4iiAvZ22nEdAa+0WZHQgSFclB/nruij0k=;
	b=TYbIMiWjlhLZ6X/P4h0RggQNyCUKXXaZZ5Oz2leJOiIFdAIsqbUG3AhyS5VAfA7py+Ahyh
	4u2vNOfdd+O7CQrZZ4UPZV9Y2x7BhpFzdgMldU4V8f4wkJKNOK64zCep6GrMfGTx4G9C3t
	Vi/ppERyPQtKNQiw/XvrG7r/6EudFbrGNDRq/tNlghbDFp0i97hqj5FQOfXjkIvjKaESZM
	TQJbdGBnSQEpb4sOnUFWPHq8xiDa9vIl4HCK4PXmsElaStBbFR7025lciXpJkOYrFs9X48
	2cCfdsL9FFqyiBwDU5Efi7o2tm9AHtw7nkCLm0JBwHpaGLb9PfA5+f0P7rXeSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fppa6bYAw4iiAvZ22nEdAa+0WZHQgSFclB/nruij0k=;
	b=TZtC9PVWgDVgReAO1MT+VX325auxJEMAddeiH9wikDNdz3IhjOTjAHZv1LwfMrB245oLcy
	4COD8XOBqRWLrTAA==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Move all X86_EXTENDED_PLATFORM options
 together
Cc: mat.jonczyk@o2.pl, David Heidelberg <david@ixit.cz>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-3-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-3-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288817165.14745.16947126967594704519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e35e328d37ee20df9a4dc9c4b0478f9e6b2c8c3e
Gitweb:        https://git.kernel.org/tip/e35e328d37ee20df9a4dc9c4b0478f9e6b2=
c8c3e
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:02:16 +01:00

x86/Kconfig: Move all X86_EXTENDED_PLATFORM options together

So that these options will be displayed together in menuconfig etc.

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-3-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 442936d..d6155b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -665,6 +665,17 @@ config X86_INTEL_QUARK
 	  Say Y here if you have a Quark based system such as the Arduino
 	  compatible Intel Galileo.
=20
+config X86_RDC321X
+	bool "RDC R-321x SoC"
+	depends on X86_32
+	depends on X86_EXTENDED_PLATFORM
+	select M486
+	select X86_REBOOTFIXUPS
+	help
+	  This option is needed for RDC R-321x system-on-chip, also known
+	  as R-8610-(G).
+	  If you don't have one of these chips, you should say N here.
+
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
 	depends on X86 && ACPI && PCI
@@ -718,17 +729,6 @@ config IOSF_MBI_DEBUG
=20
 	  If you don't require the option or are in doubt, say N.
=20
-config X86_RDC321X
-	bool "RDC R-321x SoC"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	select M486
-	select X86_REBOOTFIXUPS
-	help
-	  This option is needed for RDC R-321x system-on-chip, also known
-	  as R-8610-(G).
-	  If you don't have one of these chips, you should say N here.
-
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():

