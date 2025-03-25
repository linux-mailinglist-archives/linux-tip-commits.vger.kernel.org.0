Return-Path: <linux-tip-commits+bounces-4427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F07A6EA99
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F66188DB9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516782517B9;
	Tue, 25 Mar 2025 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ujit0omv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7b0lTil"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26121A2C06;
	Tue, 25 Mar 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888171; cv=none; b=JCaxs5vbB5796TLiZ7Q05YsugGSh+L0eE4EkmRO8XYMqTeGOh3JoURrVzaOdIICrN+n/0hEXVE/weQeoCwth5BcbxHGaftRt02FD+3xr5NNetFfPoPF+3mNONsBk+FSy25tqpSN82W6h0goDSAxsR0AUmH3LpTIgrlUO+kGRFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888171; c=relaxed/simple;
	bh=PoriMQNe+1utq2hwn8g+Q0VfoW4Mk2JKNVkZd6pme28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VsDmwGneVTRLhl18UiF+0AOhm+3D0Fa/sN2FZLKMg0hWeaDrMXY4HqaIDXQFhO22mIV93dJnAMdklOF6kI5CnTJfRPpm1XvIxPARQZ2qsv/VQ4nh9N3viHbNBMUHO80PDmEYnIcPApoVLkiqJg64N19/LQsQoX3BJmOiSr/PwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ujit0omv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7b0lTil; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEJgjQt43/3MD3ly3Y2Tsmc5Lm4TpITE0luyrameTrE=;
	b=Ujit0omvaaZQAxCEEjbc5MjmrYZRoh4Z6ChXATzjJDmbx5TegS6MhT93+lypfNGlSy5l70
	oR7GBCAkEpqjQ+QtGZVHwkxojve3P0CKU3EyGF49AVwhkIDN7IJUSjECgvy24P+1mUb83G
	WpqzH5D2n/xYzSjOfS6Q75Wr06A1Ch0QPv0xOHPpZ5+UwfIQ7qVxQvYr22jLPM0EaK69LC
	S+eZpYdm5kW2XRjnofXA4ooQ0/ungCBXMhWB4MeiLS3cSC7lq5oYYccc39isWKrbZBmgEr
	BtxHK7PSgFnNWhHvl1+HGpQoHyqGyP626mw670msZuTiHrg2VulwYzhL9RKq2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEJgjQt43/3MD3ly3Y2Tsmc5Lm4TpITE0luyrameTrE=;
	b=k7b0lTilT7LMs4I95uOcgaN47TfhAYGCBtkw+ZnhSCTT4C27WeD0z/F7dDE7ddKL3Y9Tbh
	VoCGYbTW0hucoYBQ==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Correct X86_X2APIC help text
Cc: mat.jonczyk@o2.pl, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250322154541.40325-1-mat.jonczyk@o2.pl>
References: <20250322154541.40325-1-mat.jonczyk@o2.pl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288816711.14745.688065786285184139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     99bb1bd810eaf37e15ef757a30a815e774a2445b
Gitweb:        https://git.kernel.org/tip/99bb1bd810eaf37e15ef757a30a815e774a=
2445b
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Sat, 22 Mar 2025 16:45:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:17:49 +01:00

x86/Kconfig: Correct X86_X2APIC help text

Currently, it is not true that the kernel will panic with CONFIG_X86_X2APIC=
=3Dn
on systems that require it; it will try to disable the APIC and run without
it to at least give the user a clear warning message. See the second
variant of check_x2apic() in arch/x86/kernel/apic/apic.c .

Also massage some other parts of the help text.

Fixes: 9232c49ff31c ("x86/Kconfig: Enable X86_X2APIC by default and improve h=
elp text")
Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250322154541.40325-1-mat.jonczyk@o2.pl
---
 arch/x86/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e72cb77..ef48584 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -471,14 +471,15 @@ config X86_X2APIC
 	  in 2019, but it can be disabled by the BIOS. It is also frequently
 	  emulated in virtual machines, even when the host CPU does not support
 	  it. Support in the CPU can be checked by executing
-		cat /proc/cpuinfo | grep x2apic
+		grep x2apic /proc/cpuinfo
=20
-	  If this configuration option is disabled, the kernel will not boot on
-	  some platforms that have x2APIC enabled.
+	  If this configuration option is disabled, the kernel will boot with
+	  very reduced functionality and performance on some platforms that
+	  have x2APIC enabled. On the other hand, on hardware that does not
+	  support x2APIC, a kernel with this option enabled will just fallback
+	  to older APIC implementations.
=20
-	  Say N if you know that your platform does not have x2APIC.
-
-	  Otherwise, say Y.
+	  If in doubt, say Y.
=20
 config X86_POSTED_MSI
 	bool "Enable MSI and MSI-x delivery by posted interrupts"

