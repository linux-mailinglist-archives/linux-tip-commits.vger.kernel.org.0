Return-Path: <linux-tip-commits+bounces-7994-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EAD1E277
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23A603024F6D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E02395278;
	Wed, 14 Jan 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVAVbX4r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fAx0PYo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE839448C;
	Wed, 14 Jan 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387221; cv=none; b=lZLobHhrHnb0XKoSlPWjMySjhGn7yQR6GmZCX+B+B7ILtpQzZskWNO1hwBib7G85StObzeqB8F9N+FFn+5zK3RfCX3TPU7GcPiFBx5piBb0lSexpJO8Sq9cJCX/fakaru1sNAnQcEDKE9TnGuKqC5OGX5ph1U2se4ttO6K5dwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387221; c=relaxed/simple;
	bh=lCPnPvtI/4NRY7lkZ5DuhtIFSEypal5wr6gzKcWzVr4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cc5JeGRGxR5itaT8i+kd0gbooQS+z7fKtAsF1rzIg/wc3Jxe/NTZrL95HgXhyvaG2WiUfSVw3PyX2ndKoeYDuWMpIOuvNOFWZhBsZe2r90Jb99xL1uno887QqJIZwEXaEN77L4G8MQsSzWXvffd9r3zwGygJVixjRoFUA4+OPzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVAVbX4r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fAx0PYo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYxaUiBPUxivZCvcCYbQaEhkxetFZUB0FDiZySAtXFM=;
	b=GVAVbX4rvmxgBOClhmTpaoY4dCf6/Jh/PJbsa47RMZhg2hDjDVTj0fznPfgO4CyEl/Jfbf
	hKn2cwZX1c7Jrczul0T4Hw9g49/PDh30Qgn/635rhgAH+6ubRhWHk0+K3o2fDagdZfSQcb
	WOqRJm8x/pQhCRIXk4gI77SDpkl9sxfnhDAdEtDRXkByZ0EL8a4IDsSTgVIuuqJK67K3G6
	LZHGvyw/tuFC0LHYBxOCk+s+JgCycUibISX+Xs26JWzPkkEaWOSCnx2CpW48CymWNliZq8
	i5kXhPHtlWvN82MOSAaxljIcq3Ikm7N/+1xawoHv11Z0sl6cNLMqQzjs9JM0cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYxaUiBPUxivZCvcCYbQaEhkxetFZUB0FDiZySAtXFM=;
	b=0fAx0PYoOVDCR9hwqccPgw8Ey7XfH5qSn33Jrm8T2ZBNWdaPFEIWtlc/Z/1PhEDRRnBC3o
	S94CTA1kccqeNqDg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] arm64/paravirt: Use common code for
 paravirt_steal_clock()
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-9-jgross@suse.com>
References: <20260105110520.21356-9-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721467.510.9865665665690648431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     ad892c4851577ab03c9a297f5addb8450cf844fd
Gitweb:        https://git.kernel.org/tip/ad892c4851577ab03c9a297f5addb8450cf=
844fd
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:07 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 16:30:00 +01:00

arm64/paravirt: Use common code for paravirt_steal_clock()

Remove the arch-specific variant of paravirt_steal_clock() and use
the common one instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-9-jgross@suse.com
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/paravirt.h | 10 ----------
 arch/arm64/kernel/paravirt.c      |  7 -------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0..abbfc54 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1561,6 +1561,7 @@ config CC_HAVE_SHADOW_CALL_STACK
=20
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/parav=
irt.h
index c9f7590..cb037e7 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -3,16 +3,6 @@
 #define _ASM_ARM64_PARAVIRT_H
=20
 #ifdef CONFIG_PARAVIRT
-#include <linux/static_call_types.h>
-
-u64 dummy_steal_clock(int cpu);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
=20
 int __init pv_time_init(void);
=20
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 943b60c..572efb9 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -25,13 +25,6 @@
 #include <asm/pvclock-abi.h>
 #include <asm/smp_plat.h>
=20
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
-
 struct pv_time_stolen_time_region {
 	struct pvclock_vcpu_stolen_time __rcu *kaddr;
 };

