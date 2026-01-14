Return-Path: <linux-tip-commits+bounces-7996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC72D1E28C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56A693016450
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC698395DBF;
	Wed, 14 Jan 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tR486HPB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n39YSEoi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2437F10D;
	Wed, 14 Jan 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387224; cv=none; b=MOYyVJ/UigOo5CY1pLwbBUt4M7/WF32HA1OEEc5CapgEjdfuoE3B5fPxI8uWsRWM1AtQK84PmQKpubKa3G5Htbog0y78DGrPVDLwP4Q8YYYqBCedwyhvnKvhv/8bTI1hiZlR8uabzsPdTheZHHym0OnW6Hw4JIu8g+vaVIC18UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387224; c=relaxed/simple;
	bh=FFBU59ayK4GzBSSlcoaFGiEGWaXc1PpxxOxVL/d4H9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mLVvi4LYT18HjC0LvvksXEDJ+i6aS8SJZhtrgfJisTFPVhSC0KOEv8LjZKHCUgxjCS2k5Bc2ehSQL2f/l7pXYmsdD1oLchjmIFbAMr3drb+9JbMwoRsjisRbq3hawxNMmS79tQcwCTwJahu4v/bmmjJ4ILODo0tnrS0x3DVx8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tR486HPB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n39YSEoi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HDBrwRxLDaKto+/WephkGsQ7mEXJtC2+6Cmz2ZZ1X0=;
	b=tR486HPBQT8el9rQJAaGTioqpBE69hi79JPWFehKCF31V9+XrhOU6ta9pLpwbVxC5eJRLY
	4lrSQe29Mbs7BXcOQq4qaYV5F068ymwn+RP5zAInIEPaup80dSACd42VwS9Sd3rX2jKSoZ
	mHKHAy3rRcrazee71IW7sqfMYqz95NorUWAsLsOK+Z/X6/O1F1BJLIHDdVIc1jE1pvQGx2
	8h7g6Pvf4pgjSc6oqhvyt6BW9EHAl9T6CxYlAL3mpvsmFEAgtj6JCbzfHTzIa2ABXSWjnr
	s4Iz+ZheE+XkWDR1MJ4RCDGFrF7TJ409Mm3F2l/Wf6FsgConMIp6+RVrhZVHFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HDBrwRxLDaKto+/WephkGsQ7mEXJtC2+6Cmz2ZZ1X0=;
	b=n39YSEois54rLLTkBqI4MfycpTqrgjkD6Doc0aiZoRkBS2kRGsFNsCLa/k5HcXXvkyA9Kd
	4+JGcV175Din0/BQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] paravirt: Remove asm/paravirt_api_clock.h
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-6-jgross@suse.com>
References: <20260105110520.21356-6-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721781.510.12448073294577073503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     68b10fd40d492ebfaebe716dbe21fc559a128065
Gitweb:        https://git.kernel.org/tip/68b10fd40d492ebfaebe716dbe21fc559a1=
28065
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:04 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 15:34:33 +01:00

paravirt: Remove asm/paravirt_api_clock.h

All architectures supporting CONFIG_PARAVIRT share the same contents
of asm/paravirt_api_clock.h:

  #include <asm/paravirt.h>

So remove all incarnations of asm/paravirt_api_clock.h and remove the
only place where it is included, as there asm/paravirt.h is included
anyway.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com> # powerpc, scheduler bits
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-6-jgross@suse.com
---
 arch/arm/include/asm/paravirt_api_clock.h       | 1 -
 arch/arm64/include/asm/paravirt_api_clock.h     | 1 -
 arch/loongarch/include/asm/paravirt_api_clock.h | 1 -
 arch/powerpc/include/asm/paravirt_api_clock.h   | 2 --
 arch/riscv/include/asm/paravirt_api_clock.h     | 1 -
 arch/x86/include/asm/paravirt_api_clock.h       | 1 -
 kernel/sched/sched.h                            | 1 -
 7 files changed, 8 deletions(-)
 delete mode 100644 arch/arm/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/powerpc/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/x86/include/asm/paravirt_api_clock.h

diff --git a/arch/arm/include/asm/paravirt_api_clock.h b/arch/arm/include/asm=
/paravirt_api_clock.h
deleted file mode 100644
index 65ac7ce..0000000
--- a/arch/arm/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/arm64/include/asm/paravirt_api_clock.h b/arch/arm64/include=
/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7ce..0000000
--- a/arch/arm64/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/loongarch/include/asm/paravirt_api_clock.h b/arch/loongarch=
/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7ce..0000000
--- a/arch/loongarch/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/powerpc/include/asm/paravirt_api_clock.h b/arch/powerpc/inc=
lude/asm/paravirt_api_clock.h
deleted file mode 100644
index d25ca7a..0000000
--- a/arch/powerpc/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/paravirt.h>
diff --git a/arch/riscv/include/asm/paravirt_api_clock.h b/arch/riscv/include=
/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7ce..0000000
--- a/arch/riscv/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/x86/include/asm/paravirt_api_clock.h b/arch/x86/include/asm=
/paravirt_api_clock.h
deleted file mode 100644
index 65ac7ce..0000000
--- a/arch/x86/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6..28e7cc4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -84,7 +84,6 @@ struct cpuidle_state;
=20
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
-# include <asm/paravirt_api_clock.h>
 #endif
=20
 #include <asm/barrier.h>

