Return-Path: <linux-tip-commits+bounces-2036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D1950201
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 12:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7488FB2A2D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671B18CC0F;
	Tue, 13 Aug 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqpLHudH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sutDvq1Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4717E47A;
	Tue, 13 Aug 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543522; cv=none; b=bgGq18mD1Ld4HURbL5c4WrZwAei1iaeM1hmMHWInO5qK8mWavbW2Zv/XREdnS0B6TinHJicLxNnQPWnamEZiKHJ0m7yaz4+B0dS61No5aNW5tkEdfSgWUC9TWsQ7jgi9h1W0ExVJs0/PeHogQYrY9aMJ37S6EDmQfowjmGeWsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543522; c=relaxed/simple;
	bh=JVs6PdK4r9Eqcj7uGf5HydiscJgeVY4qeuNr/BDBp4E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c5xXFdDz5yNjTdHwmJbdz+bCaife9bFc1ZORPc3JjA4muFh+NDQB42eg5mMJTySb/eEd4tRoCRx84NW98eYO2hIs6/aiIRvsqKRNMWs0aBiM3VxkTQgIMP5Fv+3yp6Wepjl99kQ0FEytDIj2c0CLPUZN4nynGNjzHAdN8P2aj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqpLHudH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sutDvq1Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 10:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723543519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Torr2WEZoLsXZV1mjigip5fIlj/sCGK2eCaxggELNag=;
	b=xqpLHudHQgdcj8XKcSJRVgBk/HgSQsO9KReoxtLtxGcx8mVGwi1zenxwjBAhIZ6TVfZeAE
	a0VDG974SrXDLfkpchlSvx9+EoUsJ4eaJyCGsN3idoaO6fi4iXDbTLiys5HVxCxE4BIgsJ
	dYSH7dp2fd+5qDv6WnhqzN4jEO5JSrfPDH40fX/fh+bvmavi/ew/sgJPlfB1UCqxw4evRo
	wzUxeG4cHBWZbbHEpubNpaUZelZJJkYhkSaxz9aseG8TM54Zwe/qYk2DSrtV8XLJ4kKMIT
	jRogrcYOZhcq8UsanLezNxmSYk/99/QLQgcPxcfDIbWB2n0vT9LACbTP4DcqEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723543519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Torr2WEZoLsXZV1mjigip5fIlj/sCGK2eCaxggELNag=;
	b=sutDvq1Yc6g1/6AYlozvGqExUTi6hS3bpjPiqytMblktcDCmmec0FqLZJIh+ivwBpsYhCD
	X1w4Vah7/BX9fBBw==
From: "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove unused extern declarations
Cc: Yue Haibing <yuehaibing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240810093610.2586665-1-yuehaibing@huawei.com>
References: <20240810093610.2586665-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172354351865.2215.12429822421535418166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2db5f86c0d5da9ef0f3a1a5a9c460bf0f36268bf
Gitweb:        https://git.kernel.org/tip/2db5f86c0d5da9ef0f3a1a5a9c460bf0f36268bf
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Sat, 10 Aug 2024 17:36:10 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 12:00:09 +02:00

x86/apic: Remove unused extern declarations

The removal of get_physical_broadcast(), generic_bigsmp_probe() and
default_apic_id_valid() left the stale declarations around.

Remove them.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240810093610.2586665-1-yuehaibing@huawei.com
---
 arch/x86/include/asm/apic.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 53f0844..f21ff19 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -127,8 +127,6 @@ static inline bool apic_is_x2apic_enabled(void)
 
 extern void enable_IR_x2apic(void);
 
-extern int get_physical_broadcast(void);
-
 extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
@@ -508,8 +506,6 @@ static inline bool is_vector_pending(unsigned int vector)
 #define TRAMPOLINE_PHYS_LOW		0x467
 #define TRAMPOLINE_PHYS_HIGH		0x469
 
-extern void generic_bigsmp_probe(void);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 
 #include <asm/smp.h>
@@ -532,8 +528,6 @@ static inline int default_acpi_madt_oem_check(char *a, char *b) { return 0; }
 static inline void x86_64_probe_apic(void) { }
 #endif
 
-extern int default_apic_id_valid(u32 apicid);
-
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 

